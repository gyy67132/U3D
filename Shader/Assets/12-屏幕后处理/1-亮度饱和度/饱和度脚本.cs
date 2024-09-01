using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ���ͶȽű� : PostEffectsBase
{
    public Shader ���ȱ��Ͷ���ɫ��;
    private Material ���ȱ��ͶȲ���;
    public Material material
    {
        get {
            ���ȱ��ͶȲ��� = CheckShaderAndCreateMaterial(���ȱ��Ͷ���ɫ��, ���ȱ��ͶȲ���);
            return ���ȱ��ͶȲ���;
        }
    }

    [Range(0.0f, 3.0f)]
    public float ���� = 1.0f;

    [Range(0.0f, 3.0f)]
    public float ���Ͷ� = 1.0f;

    [Range(0.0f, 3.0f)]
    public float �Աȶ� = 1.0f;

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (material != null)
        {
            material.SetFloat("_Brightness", ����);
            material.SetFloat("_Saturation", ���Ͷ�);
            material.SetFloat("_Contrast", �Աȶ�);

            Graphics.Blit(src, dest, material);
        }
        else {
            Graphics.Blit(src, dest);
        }
    }
}
