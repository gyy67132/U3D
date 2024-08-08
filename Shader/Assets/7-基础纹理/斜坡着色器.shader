// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "自定义7/斜坡着色器"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _RampTex ("Ramp Tex", 2D) = "white" {}
        _Gloss("Gloss", Range(8.0,256)) = 20
        _Specular("Specular", Color) = (1,1,1,1)
    }
    SubShader
        {
            Pass{
                Tags { "LightMode" = "ForwardBase" }

                CGPROGRAM

        #pragma vertex vert
        #pragma fragment frag
        #include "Lighting.cginc"

            float4 _Color;
            sampler2D _RampTex;
            float4 _RampTex_ST;
            float4 _Gloss;
            float4 _Specular;

            struct a2v {
                float4 vertex:POSITION;
                float3 normal:NORMAL;
                float4 texcoord:TEXCOORD0;
            };

            struct v2f {
                float4 pos:SV_POSITION;
                float3 worldNormal:TEXCOORD0;
                float3 worldPos:TEXCOORD1;
                float2 uv:TEXCOORD2;
            };

            v2f vert(a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.uv = TRANSFORM_TEX(v.texcoord, _RampTex);
                //o.uv = v.texcoord * _RampTex_ST.xy + _RampTex_ST.zw;
                return o;
            }

            fixed4 frag(v2f f) :SV_Target
            {
                fixed3 worldNormal = normalize(f.worldNormal);
                fixed3 lightDir = normalize(UnityWorldSpaceLightDir(f.worldPos));

                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

                fixed halfLambert = dot(lightDir, worldNormal) * 0.5 + 0.5;
                fixed3 diffColor = tex2D(_RampTex, fixed2(halfLambert, halfLambert)).rgb * _Color.rgb;
                fixed3 diffuse = _LightColor0.rgb * diffColor;

                fixed3 viewDir = normalize(UnityWorldSpaceViewDir(f.worldPos));
                fixed3 halfDir = normalize(viewDir + lightDir);
                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(max(dot(halfDir, worldNormal), 0), _Gloss);

                return fixed4(ambient + diffuse + specular, 1.0);
            }

            ENDCG
         }
                    }
    FallBack "Specluar"
}
