// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//��Ӧ�ó��򴫵����㺯��������
//POSITION
//NORMAL
//TANGENT ����
//TEXTURE0 TEXTURE1 ~n ��������
//COLOR ������ɫ

//�Ӷ��㺯�����ݸ�ƬԪ����
//SV_POSITION
//COLOR0 COLOR1 ��һ��������ɫ float4
//TEXCOORD0 TEXCOORD1 ~7 ��������

//ƬԪ��������ϵͳ
//SV_Target



Shader "shader normal"{

	SubShader{
		Pass{
			CGPROGRAM
// Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members temp)
//#pragma exclude_renderers d3d11
			//�������㺯��,������vert
#pragma vertex vert
		//����ƬԪ����,������frag
#pragma fragment frag

		struct a2v {
			float4 vertex:POSITION;
			float3 normal:NORMAL;
			float4 texcoord:TEXCOORD0;
		};

		struct v2f {
			float4 position:SV_POSITION;
			float3 temp:COLOR0;//COLOR0�м����壬�û��Լ����壬�洢��ɫ
		};

		//POSITION model�����꣬SV_POSITION����������
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