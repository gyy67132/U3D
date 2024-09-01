using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ��˹ģ���ű� : PostEffectsBase
{
    public Shader ��˹ģ����ɫ��;
    private Material ��˹ģ������ = null;
    public Material material
    {
        get {
            ��˹ģ������ = CheckShaderAndCreateMaterial(��˹ģ����ɫ��, ��˹ģ������);
            return ��˹ģ������;
        }
    }

    [Range(0, 4)]
    public int �������� = 3;
    
    [Range(0.2f, 3.0f)]
    public float ģ����Χ = 0.6f;

    [Range(1, 8)]
    public int downSample = 2;

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (material != null)
        {
            material.SetFloat("_EdgeOnly", ��Ե��ǿ��);
            material.SetColor("_EdgeColor", ��Ե����ɫ);
            material.SetColor("_BackgroundColor", ����ɫ);

            Graphics.Blit(src, dest, material);
        }
        else {
            Graphics.Blit(src, dest);
        }
    }
}
