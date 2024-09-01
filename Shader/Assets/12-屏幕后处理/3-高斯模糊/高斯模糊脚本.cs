using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class 高斯模糊脚本 : PostEffectsBase
{
    public Shader 高斯模糊着色器;
    private Material 高斯模糊材质 = null;
    public Material material
    {
        get {
            高斯模糊材质 = CheckShaderAndCreateMaterial(高斯模糊着色器, 高斯模糊材质);
            return 高斯模糊材质;
        }
    }

    [Range(0, 4)]
    public int 迭代次数 = 3;
    
    [Range(0.2f, 3.0f)]
    public float 模糊范围 = 0.6f;

    [Range(1, 8)]
    public int downSample = 2;

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (material != null)
        {
            material.SetFloat("_EdgeOnly", 边缘线强度);
            material.SetColor("_EdgeColor", 边缘线颜色);
            material.SetColor("_BackgroundColor", 背景色);

            Graphics.Blit(src, dest, material);
        }
        else {
            Graphics.Blit(src, dest);
        }
    }
}
