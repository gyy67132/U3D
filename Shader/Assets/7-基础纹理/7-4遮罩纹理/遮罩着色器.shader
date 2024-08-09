// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "自定义7/遮罩着色器"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex("Main Tex",2D)="white"{}
        _BumpMap("Ramp Tex" ,2D) = "bump" {}//法线纹理
        _BumpScale("Bump Scale",Range(0,2))=1
        _SpecularMask("Specular Mask",2D)="white"{}//遮罩纹理
        _SpecularScale("Specular Scale",Range(0,2))=1
        _Specular("Specular", Color) = (1,1,1,1)
        _Gloss("Gloss", Range(8,256)) = 8
    }
    SubShader
    {
        Pass{
                Tags { "LightMode" = "ForwardBase" }

                CGPROGRAM

        #pragma vertex vert
        #pragma fragment frag
        #include "Lighting.cginc"

            fixed4 _Color;
            sampler2D _MainTex;
            float4 _MainTex_ST;

            sampler2D _BumpMap;
            float4 _BumpMap_ST;
            float _BumpScale;

            sampler2D _SpecularMask;
            float _SpecularScale;
            float4 _Specular;
            
            float _Gloss;

            struct a2v {
                float4 vertex:POSITION;
                float3 normal:NORMAL;
                float4 tangent:TANGENT;
                float4 texcoord:TEXCOORD0;
            };

            struct v2f {
                float4 pos:SV_POSITION;
                float3 lightDir:TEXCOORD0;
                float3 viewDir:TEXCOORD1;
                float2 uv:TEXCOORD2;
            };

            v2f vert(a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;

                TANGENT_SPACE_ROTATION;

                o.lightDir = mul(rotation, ObjSpaceLightDir(v.vertex)).xyz;
                o.viewDir = mul(rotation, ObjSpaceLightDir(v.vertex)).xyz;
                
                return o;
            }

            fixed4 frag(v2f i) :SV_Target
            {
                fixed3 tangentViewDir = normalize(i.viewDir);
                fixed3 tangentLightDir = normalize(i.lightDir);

                fixed3 tangentNormal = UnpackNormal(tex2D(_BumpMap, i.uv));
                tangentNormal.xy *= _BumpScale;

                //tangentNormal.x * tangentNormal.x - tangentNormal.y* tangentNormal.y
                tangentNormal.z = sqrt(1 - saturate(dot(tangentNormal.xy, tangentNormal.xy)));

                fixed3 albedo = tex2D(_MainTex, i.uv).rgb * _Color.rgb;

                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz * albedo;

                fixed3 diffuse = albedo * _LightColor0.rgb * max(0, dot(tangentLightDir, tangentNormal));

                fixed3 halfDir = normalize(tangentViewDir + tangentLightDir);
                fixed3 specularMask = tex2D(_SpecularMask, i.uv).r * _SpecularScale;

                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(max(0, dot(halfDir, tangentNormal)), _Gloss) * specularMask;

                return fixed4(ambient + diffuse + specular, 1.0);
            }
             
            ENDCG
         }
    }
    FallBack "Specluar"
}
