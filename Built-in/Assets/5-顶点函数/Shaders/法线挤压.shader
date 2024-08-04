Shader "着色器5/法线挤压"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _NormalMap("Normal Map",2D)="bump"{}
        _ExtrusionAmount("Extrusion Amount",Range(-0.0001,0.0001)) = 0
        _ExtrusionMap("_Extrusion Map",2D) = "bump"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NormalMap;
        sampler2D _ExtrusionMap;
        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        float _ExtrusionAmount;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void vert(inout appdata_full v)
        {
            float4 tex = tex2Dlod(_ExtrusionMap, float4(v.texcoord.xy,0,0));
            float extrusion = tex.x * 2.0 - 1.0;
            v.vertex.xyz += v.normal * _ExtrusionAmount * extrusion;
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            fixed3 normal = UnpackNormal(tex2D(_NormalMap, IN.uv_MainTex));
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
            o.Normal = normal;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
