Shader "shader do nothing"{

	Properties{//����
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
	//һ��Pass��һ�����ܷ���
	//�����и�Pass��
		Pass{
			//
			CGPROGRAM
			//ʹ��CG���Ա�дshader����
			float4 _Color;//float half fixed
			float3 t1;//half3 fixed3
			float2 t;//half2 fixed2
			//float 32λ half 16λ -6��~6�� fixed 11λ -2~2
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
	
	//SubShader ��������ʱ
	Fallback "VertexLit"
}