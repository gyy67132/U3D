// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//从应用程序传到顶点函数的语义
//POSITION
//NORMAL
//TANGENT 切线
//TEXTURE0 TEXTURE1 ~n 纹理坐标
//COLOR 顶点颜色

//从顶点函数传递给片元函数
//SV_POSITION
//COLOR0 COLOR1 不一定传递颜色 float4
//TEXCOORD0 TEXCOORD1 ~7 纹理坐标

//片元函数传给系统
//SV_Target

//_WorldSpaceLightPos0
// _LightColor0

//normalize()
//max()
//dot()

Shader "Shader diffuse fragment"{

	Properties{
		_Diffuse("Diffuse Color", Color) = (1,1,1,1)
	}

		SubShader{
			Pass{
				Tags{"LightMode" = "ForwardBase"}
				CGPROGRAM
	#include "Lighting.cginc"//取得第一个直射光的颜色 _LightColor0 直射光位置_WorldSpaceLightPos0
		
		
//声明顶点函数,函数名vert
		#pragma vertex vert
//声明片元函数,函数名frag
		#pragma fragment frag

		float3 _Diffuse;

		struct a2v {
			float4 vertex:POSITION;
			float3 normal:NORMAL;
			float4 texcoord:TEXCOORD0;
		};

		struct v2f {
			float4 position:SV_POSITION;
			float3 worldNormalDir:COLOR0;//COLOR0中间语义，用户自己定义，存储颜色
		
		};

		//POSITION model点坐标，SV_POSITION处理后的坐标
		//v2f vert(float4 v : POSITION) : SV_POSITION{
		v2f vert(a2v v){
			v2f f;
			f.position = UnityObjectToClipPos(v.vertex);
			f.worldNormalDir = mul(v.normal, (float3x3)unity_WorldToObject);
			return f;
		}

		fixed4 frag(v2f f) : SV_Target
		{
			fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;

			fixed3 lightDir = normalize(_WorldSpaceLightPos0.xyz);//阳光方向
			fixed3 normalDir = normalize(f.worldNormalDir);//法线 从模型空间转世界空间

			float3 diffuse = _LightColor0.rgb * max(dot(lightDir, normalDir), 0) * _Diffuse.rgb;
			fixed3 temp  = diffuse + ambient;

			return fixed4(temp.rgb,1);
		}


			ENDCG
		}
	}
	Fallback "VertexLit"
}