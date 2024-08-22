Shader "着色器10/Reflection"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _ReflectColor("Reflect Color",Color) =(1,1,1,1)
        _ReflectAmount("Reflect Amount",Range(0,1))=1
        _Cubemap("Reflection Cubemap", Cube) = "_Skybox"{}

    }
    SubShader
    {
        Tags { "RenderType"="Opaque"  "Queue" = "Geometry"}
        
        Pass{
            Tags {"LightMode"="ForwardBase"}
            CGPROGRAM
            // Physically based Standard lighting model, and enable shadows on all light types
            #pragma multi_compile_fwdbase

            #pragma vertex vert
            #pragma fragment frag

            #include "Lighting.cginc"
            #include "AutoLight.cginc"
            
            fixed4 _Color;
            fixed4 _ReflectColor;
            fixed _ReflectAmount;
            samplerCUBE _Cubemap;

            struct a2v
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos :SV_POSITION;
                float3 worldPos:TEXCOORD0;
                fixed3 worldNormal : TEXCOORD1;
                fixed3 worldViewDir : TEXCOORD2;
                fixed3 worldRefl : TEXCOORD3;
                SHADOW_COORDS(4)
            };

            v2f vert(a2v i)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(i.vertex);
                o.worldNormal = UnityObjectToWorldNormal(i.normal);
                o.worldPos = mul(unity_ObjectToWorld, i.vertex).xyz;
                o.worldViewDir = UnityWorldSpaceViewDir(o.worldPos);

                o.worldRefl = reflect(-o.worldViewDir, o.worldNormal);
                TRANSFER_SHADOW(o);
                return o;
            }

            fixed4 frag(v2f i) :SV_Target
            {
                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
                fixed3 worldViewDir = normalize(i.worldViewDir);

                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

                fixed3 diffuse = _LightColor0.rgb * _Color.rgb * max(dot(worldNormal, worldLightDir), 0);
            
                fixed3 reflection = texCUBE(_Cubemap, i.worldRefl).rgb * _ReflectColor.rgb;

                UNITY_LIGHT_ATTENUATION(atten, i, i.worldPos);

                fixed3 color = ambient + lerp(diffuse , reflection, _ReflectAmount) * atten;

                return fixed4(color, 1.0);
            }
        
        
            ENDCG
        }
    }
    FallBack "Reflective/VertexLit"
}
