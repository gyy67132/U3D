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



Shader "shader normal"{

	SubShader{
		Pass{
			CGPROGRAM
// Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members temp)
//#pragma exclude_renderers d3d11
			//声明顶点函数,函数名vert
#pragma vertex vert
		//声明片元函数,函数名frag
#pragma fragment frag

		struct a2v {
			float4 vertex:POSITION;
			float3 normal:NORMAL;
			float4 texcoord:TEXCOORD0;
		};

		struct v2f {
			float4 position:SV_POSITION;
			float3 temp:COLOR0;//COLOR0中间语义，用户自己定义，存储颜色
		};

		//POSITION model点坐标，SV_POSITION处理后的坐标
		//v2f vert(float4 v : POSITION) : SV_POSITION{
		v2f vert(a2v v){
			v2f f;
			f.position = UnityObjectToClipPos(v.vertex);
			f.temp = v.normal;
			return f;
		}

		fixed4 frag(v2f f) : SV_Target
		{
			//float3 t = float3(1,1,1);
			//t += f.temp;
			//return fixed4(t/2,1);
			//f.temp = float3(1, 0, -1);
			return fixed4(f.temp, 1);
		}


		ENDCG
		}
	}
	Fallback "VertexLit"
}