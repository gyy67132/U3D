using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class 法线压缩 : MonoBehaviour
{
    [Range(-0.0001f,0.0001f)]
    public float 压缩度 = 0;
    // Start is called before the first frame update
    void Start()
    {
        Material mat = GetComponent<Renderer>().sharedMaterial;
        if(mat != null)
        {
            Material material = new Material(mat);
            material.SetFloat("_ExtrusionAmount", 压缩度);
            GetComponent<Renderer>().material = material;
        }
    }

    
}
