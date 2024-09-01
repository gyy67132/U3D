using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ±ßÔµ¼ì²â½Å±¾ : PostEffectsBase
{
    public Shader ±ßÔµ¼ì²â×ÅÉ«Æ÷;
    private Material ±ßÔµ¼ì²â²ÄÖÊ = null;
    public Material material
    {
        get {
            ±ßÔµ¼ì²â²ÄÖÊ = CheckShaderAndCreateMaterial(±ßÔµ¼ì²â×ÅÉ«Æ÷, ±ßÔµ¼ì²â²ÄÖÊ);
            return ±ßÔµ¼ì²â²ÄÖÊ;
        }
    }

    [Range(0.0f, 1.0f)]
    public float ±ßÔµÏßÇ¿¶È = 0.0f;

    public Color ±ßÔµÏßÑÕÉ« = Color.black;

    public Color ±³¾°É« = Color.white;

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (material != null)
        {
            material.SetFloat("_EdgeOnly", ±ßÔµÏßÇ¿¶È);
            material.SetColor("_EdgeColor", ±ßÔµÏßÑÕÉ«);
            material.SetColor("_BackgroundColor", ±³¾°É«);

            Graphics.Blit(src, dest, material);
        }
        else {
            Graphics.Blit(src, dest);
        }
    }
}
