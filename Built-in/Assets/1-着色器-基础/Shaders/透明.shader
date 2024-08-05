// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "透明"{
	Properties{
		_Diffuse("Diffuse Color", Color) = (1,1,1,1)
		_Specular("Specular Color", Color) = (1,1,1,1)
		_Gloss("Gloss", Range(5,200)) = 20
		_Texture("Main Tex", 2D) = "white"{}
		_NMTexture("Normal Tex", 2D) = "bump"{}
		_BumpScale("Bump Scale", Float) = 1
		_AlphaScale("Aipha Scale", Range(0,1)) = 0.7
	}

		SubShader{
			//"Queue" = "Transparent" 表明加入透明物体渲染队列
			// "IngnoreProjector"="True" 表明该物体不受其他物体投影影响 
			//Unity的投影仪组件允许开发者将纹理或光影投射到场景中的物体上，以创造各种视觉效果，
			//如阴影、光斑、纹理映射等。然而，在某些情况下，开发者可能不希望某些物体被投影仪所影响，
			//这时就可以通过设置Shader的"IgnoreProjector"标签为"True"来实现。

			Tags{"Queue" = "Transparent" "IngnoreProjector"="True" "RenderType"="Transparent"}
			Pass{
				Tags{"LightMode" = "ForwardBase"}

				ZWrite Off
				Blend SrcAlpha OneMinusSrcAlpha

				CGPROGRAM
	#include "Lighting.cginc"
	#pragma vertex vert
	#pragma fragment frag

				fixed4 _Diffuse;
				fixed4 _Specular;
				half _Gloss;
				sampler2D _Texture;
				float4 _Texture_ST;//名字固定写法

				sampler2D _NMTexture;
				float4 _NMTexture_ST;

				float _BumpScale;
				float _AlphaScale;

				struct a2v {
					float4 vertex:POSITION;
					float3 normal:NORMAL;
					float4 texCoord:TEXCOORD0;
					float4 norTexCoord:TEXCOORD1;
					float4 tangent:TANGENT;//系统需要使用
				};

				struct v2f {
					float4 svPos:SV_POSITION;
					//float3 worldNormal : TEXCOORD3;
					float3 lightDir : TEXCOORD0;
					float4 worldVertex : TEXCOORD1;
					float4 uv:TEXCOORD2;
				};

				v2f vert(a2v v)//一定要叫v
				{
					v2f f;
					f.svPos = UnityObjectToClipPos(v.vertex);//模型坐标转剪裁空间坐标
					//f.worldNormal = UnityObjectToWorldNormal(v.normal);
					f.worldVertex = mul(v.vertex, unity_WorldToObject);//模型坐标转世界空间坐标
					f.uv.xy = v.texCoord.xy * _Texture_ST.xy + _Texture_ST.zw;
					f.uv.zw = v.norTexCoord.xy * _NMTexture_ST.xy + _NMTexture_ST.zw;

					TANGENT_SPACE_ROTATION;//调用这个宏后，会得到一个矩阵 rotation,
								//这个矩阵用来把模型空间下的方向转成切线空间下

					f.lightDir = mul(rotation, ObjSpaceLightDir(v.vertex));//模型空间下的平行光方向 
										//转为切线空间下的方向
					return f;
				}
				//切线空间
				fixed4 frag(v2f f) :SV_TARGET
				{
					//fixed3 normalDir = normalize(f.worldNormal);
					
					fixed4 normalColor = tex2D(_NMTexture, f.uv.zw);
					fixed3 tangentNormal = UnpackNormal(normalColor);

					tangentNormal.xy = _BumpScale* tangentNormal.xy;
					//点光源 对于不同顶点的方向
					//fixed3 lightDir = normalize(WorldSpaceLightDir(f.worldVertex));
					fixed3 lightDir = normalize(f.lightDir);

					//漫反射
					fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * max(dot(tangentNormal, lightDir), 0);

					//相机方向（人眼方向）
					//fixed3 viewDir = normalize(UnityWorldSpaceViewDir(f.worldVertex));
					//fixed3 halfDir = normalize(lightDir + viewDir);
					//高光反射
					//fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(max(dot(tangentNormal, halfDir),0), _Gloss);

					fixed3 texColor = tex2D(_Texture, f.uv);
					fixed3 retColor = (diffuse  + UNITY_LIGHTMODEL_AMBIENT.rgb )* texColor;

					return fixed4(retColor, _AlphaScale);
				}

			ENDCG
		}
	}
	Fallback "Specular"
}