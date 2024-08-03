Shader "着色器3/各向异性"
{
    Properties
    {
        _MainTint ("Main Tint", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _SpecularColor("Specular Color",Color)=(1,1,1,1)
        _SpecularPower("Specular Power",Range(0,1))=0.5
        _SpecularAmount("Specular Amount",Range(0,1))=0.5
        _AnisoDir("Anisotropic Direction",2D) = "white"{}
       _AnisoOffset("Anisotropic Offset",Range(-1,1)) = -0.2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf AnisotropicSpec

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_AnisoDir;
        };
        sampler2D _MainTex;
        sampler2D _AnisoDir;
        float4 _MainTint;
        float4 _SpecularColor;
        float _AnisoOffset;
        float _SpecularPower;
        float _SpecularAmount;

        struct SurfaceAnisoOutput {
            fixed3 Albedo;
            fixed3 Normal;
            fixed3 Emission;
            fixed3 AnisoDirection;
            half Specular;
            fixed Gloss;
            fixed Alpha;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceAnisoOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _MainTint;
            float3 anisoTex = tex2D(_AnisoDir, IN.uv_AnisoDir);
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Alpha = c.a;
            o.Gloss = _SpecularPower;
            o.AnisoDirection = anisoTex;
            o.Specular = _SpecularAmount;
        }

        fixed4 LightingAnisotropicSpec(SurfaceAnisoOutput s, fixed3 LightDir, half3 ViewDir, fixed atten)
        {
            fixed3 halfVector = normalize(normalize(LightDir) + normalize(ViewDir));
            float NdotL = saturate(dot(s.Normal, LightDir));

            fixed NdotH = dot(normalize(s.Normal + s.AnisoDirection), halfVector);
            float aniso = max(0, sin( radians((NdotH + _AnisoOffset)* 180) ) );

            float spec = saturate(pow(aniso, s.Gloss * 128) * s.Specular);

            fixed4 c;
            c.rgb = (s.Albedo.rgb * _LightColor0.rgb * NdotL + _SpecularColor.rgb*_LightColor0.rgb * spec )* atten;
            c.a = s.Alpha;
            return c;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
