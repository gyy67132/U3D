using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class 贴合地面材质 : MonoBehaviour
{
    public Material mat;
    public float Radius = 1.0f;
    public Color Color = Color.white;
    // Update is called once per frame
    void Update()
    {
        if(mat != null)
        {
            mat.SetVector("_Center", this.transform.position);
            mat.SetFloat("_Radius", Radius);
            mat.SetColor("Radius Color", Color);
        }
    }
}
