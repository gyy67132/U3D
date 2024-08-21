using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class RenderCubemapWizard : ScriptableWizard
{
    public Transform renderFromPosition;
    public Cubemap cubemap;

    private void OnWizardUpdate()
    {
        helpString = "Select transform to render from and cubemap to render into";
        isValid = (renderFromPosition != null) && (cubemap != null);
    }

    private void OnWizardCreate()
    {
        GameObject go = new GameObject("CubemapCamera");
        go.AddComponent<Camera>();

        go.transform.position = renderFromPosition.position;

        go.GetComponent<Camera>().RenderToCubemap(cubemap);

        DestroyImmediate(go);
    }

    [MenuItem("GameObject/Render into Cubemap")]

    static void RenderCubemap()
    {
        ScriptableWizard.DisplayWizard<RenderCubemapWizard>("render cubemap", "Render!");
    }
}
