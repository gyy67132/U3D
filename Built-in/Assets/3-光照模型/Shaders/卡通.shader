Shader "着色器3/卡通"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white"{}
        _RampTex("Ramp",2D) = "white"{}
        _Level("Level", Range(2, 10)) = 10
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Toon2
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _RampTex;
        struct Input
        {
            float2 uv_MainTex;
        };
        float _Level;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
        }

        fixed4 LightingToon(SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            half NdotL = dot(s.Normal, lightDir);
            NdotL = tex2D(_RampTex, fixed2(NdotL, 0.5));
            fixed4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
            c.a = s.Alpha;
            return c;
        }

        fixed4 LightingToon2(SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            half NdotL = dot(s.Normal, lightDir);
            NdotL = floor(NdotL* _Level) /(_Level - 0.5);
            fixed4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
            c.a = s.Alpha;
            return c;
        }
        ENDCG
    }
        FallBack "Diffuse"
}
