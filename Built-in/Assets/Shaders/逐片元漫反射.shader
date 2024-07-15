// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

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
	#include "Lighting.cginc"//ȡ�õ�һ��ֱ������ɫ _LightColor0 ֱ���λ��_WorldSpaceLightPos0
		
		
//�������㺯��,������vert
		#pragma vertex vert
//����ƬԪ����,������frag
		#pragma fragment frag

		float3 _Diffuse;

		struct a2v {
			float4 vertex:POSITION;
			float3 normal:NORMAL;
			float4 texcoord:TEXCOORD0;
		};

		struct v2f {
			float4 position:SV_POSITION;
			float3 worldNormalDir:COLOR0;//COLOR0�м����壬�û��Լ����壬�洢��ɫ
		
		};

		//POSITION model�����꣬SV_POSITION����������
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

			fixed3 lightDir = normalize(_WorldSpaceLightPos0.xyz);//���ⷽ��
			fixed3 normalDir = normalize(f.worldNormalDir);//���� ��ģ�Ϳռ�ת����ռ�

			float3 diffuse = _LightColor0.rgb * max(dot(lightDir, normalDir), 0) * _Diffuse.rgb;
			fixed3 temp  = diffuse + ambient;

			return fixed4(temp.rgb,1);
		}


			ENDCG
		}
	}
	Fallback "VertexLit"
}