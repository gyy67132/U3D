Shader "shader do nothing"{

	Properties{//属性
		_Color("Color", Color) = (1,1,0,1)
		_Vector("Vector", Vector)=(1,2,3,4)
		_Int("Int", Int) = 3412
		_Float("Float", Float) = 3.14
		_Range("Range", Range(1,11))=6
		_2D("Texture",2D) = "white"{}
		_Cube("Cube",Cube)="white"{}
		_3D("Texture",3D) = "black"{}
	}

	SubShader{
	//一个Pass块一个功能方法
	//至少有个Pass块
		Pass{
			//
			CGPROGRAM
			//使用CG语言编写shader代码
			float4 _Color;//float half fixed
			float3 t1;//half3 fixed3
			float2 t;//half2 fixed2
			//float 32位 half 16位 -6万~6万 fixed 11位 -2~2
			float4 _Vector;
			float _Int;
			float _Float;
			float _Range;
			sampler2D _2D;
			samplerCube _Cube;
			sampler3D _3D;

			
			ENDCG
		}
	}
	
	//SubShader 都不能用时
	Fallback "VertexLit"
}