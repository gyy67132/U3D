Shader "着色器3/布林冯"
{
    Properties
    {
        _SpecularColor ("Specular Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _SpecPower("Specular Power", Range(2,10)) =10
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf BoonPhong

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _SpecularColor;
        float _SpecPower;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        fixed4 LightingBoonPhong(SurfaceOutput s, fixed3 LightDir, fixed3 ViewDir, half atten)
        {
            fixed NdotL = dot(s.Normal, LightDir);
            fixed3 diffuse = _LightColor0.rgb * s.Albedo.rgb * max(NdotL, 0) ;

            fixed3 halfDir = normalize(LightDir + ViewDir);

            float spec = pow(max(dot(halfDir, s.Normal), 0), _SpecPower);
            fixed3 specular = _LightColor0.rgb * _SpecularColor.rgb * spec * atten;

            fixed4 c;
            c.rgb = diffuse + specular;
            c.a = s.Alpha;
            return c;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
