using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class 饱和度脚本 : PostEffectsBase
{
    public Shader 亮度饱和度着色器;
    private Material 亮度饱和度材质;
    public Material material
    {
        get {
            亮度饱和度材质 = CheckShaderAndCreateMaterial(亮度饱和度着色器, 亮度饱和度材质);
            return 亮度饱和度材质;
        }
    }

    [Range(0.0f, 3.0f)]
    public float 亮度 = 1.0f;

    [Range(0.0f, 3.0f)]
    public float 饱和度 = 1.0f;

    [Range(0.0f, 3.0f)]
    public float 对比度 = 1.0f;

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (material != null)
        {
            material.SetFloat("_Brightness", 亮度);
            material.SetFloat("_Saturation", 饱和度);
            material.SetFloat("_Contrast", 对比度);

            Graphics.Blit(src, dest, material);
        }
        else {
            Graphics.Blit(src, dest);
        }
    }
}
