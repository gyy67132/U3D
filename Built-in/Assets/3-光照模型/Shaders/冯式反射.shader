Shader "着色器3/冯式反射"
{
    Properties
    {
        _MainTint("Diffuse Tint", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _SpecularColor("Specular Color", Color)=(1,1,1,1)
        _SpecPower("Specular Power",Range(0.1, 30))=1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf CustomPhone

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        float4 _MainTint;
        float4 _SpecularColor;
        float _SpecPower;

        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _MainTint;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        fixed4 LightingCustomPhone(SurfaceOutput s, fixed3 lightDir, fixed3 viewDir, fixed atten)
        {
            float3 reflectDir = reflect(-lightDir, s.Normal);
            float NdotL = dot(s.Normal, lightDir);
            //float3 reflectDir = normalize(2.0 * s.Normal * NdotL - lightDir);
            float spec = pow(max(0, dot(reflectDir, viewDir)), _SpecPower);
            fixed3 specular = _SpecularColor.rgb * spec;
            fixed4 finalColor;
            finalColor.rgb = s.Albedo * _LightColor0.rgb *  max(0, NdotL) * atten + _LightColor0.rgb * specular;
            finalColor.a = s.Alpha;
            return finalColor;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
