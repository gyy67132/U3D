// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "纹理贴图"{
	Properties{
		_Diffuse("Diffuse Color", Color) = (1,1,1,1)
		_Specular("Specular Color", Color) = (1,1,1,1)
		_Gloss("Gloss", Range(10,200)) = 20
		_Texture("Main Tex", 2D) = "white"{}
	}

		SubShader{
			Pass{
				Tags{"LightMode" = "ForwardBase"}
				CGPROGRAM
	#include "Lighting.cginc"
	#pragma vertex vert
	#pragma fragment frag

				fixed4 _Diffuse;
				fixed4 _Specular;
				half _Gloss;
				sampler2D _Texture;
				float4 _Texture_ST;//名字固定
				struct a2v {
					float4 vertex:POSITION;
					float3 normal:NORMAL;
					float4 texCoord:TEXCOORD0;
				};

				struct v2f {
					float4 svPos:SV_POSITION;
					float3 worldNormal : TEXCOORD0;
					float4 worldVertex : TEXCOORD1;
					float2 uv:TEXCOORD2;
				};

				v2f vert(a2v v)
				{
					v2f f;
					f.svPos = UnityObjectToClipPos(v.vertex);//模型坐标转剪裁空间坐标
					f.worldNormal = UnityObjectToWorldNormal(v.normal);
					f.worldVertex = mul(v.vertex, unity_WorldToObject);//模型坐标转世界空间坐标
					f.uv = v.texCoord.xy * _Texture_ST.xy + _Texture_ST.zw;
					return f;
				}

				fixed4 frag(v2f f) :SV_TARGET
				{
					fixed3 normalDir = normalize(f.worldNormal);
					//点光源 对于不同顶点的方向
					fixed3 lightDir = normalize(WorldSpaceLightDir(f.worldVertex));

					//漫反射
					float halfLabert = dot(lightDir, normalDir) * 0.5 + 0.5;
					float3 diffuse = _LightColor0.rgb * halfLabert * _Diffuse.rgb;
					//fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * max(dot(normalDir, lightDir), 0);

					//相机方向（人眼方向）
					fixed3 viewDir = normalize(UnityWorldSpaceViewDir(f.worldVertex));

					fixed3 halfDir = normalize(lightDir + viewDir);
					//高光反射
					fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(max(dot(normalDir, halfDir),0), _Gloss);

					fixed3 texColor = tex2D(_Texture, f.uv);
					fixed3 retColor = (diffuse + specular + UNITY_LIGHTMODEL_AMBIENT.rgb)* texColor;

					return fixed4(retColor, 1.0);
				}

			ENDCG
		}
	}
	Fallback "Specular"
}