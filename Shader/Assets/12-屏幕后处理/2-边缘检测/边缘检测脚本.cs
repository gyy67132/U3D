using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ��Ե���ű� : PostEffectsBase
{
    public Shader ��Ե�����ɫ��;
    private Material ��Ե������ = null;
    public Material material
    {
        get {
            ��Ե������ = CheckShaderAndCreateMaterial(��Ե�����ɫ��, ��Ե������);
            return ��Ե������;
        }
    }

    [Range(0.0f, 1.0f)]
    public float ��Ե��ǿ�� = 0.0f;

    public Color ��Ե����ɫ = Color.black;

    public Color ����ɫ = Color.white;

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
