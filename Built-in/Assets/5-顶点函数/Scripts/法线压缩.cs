using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ����ѹ�� : MonoBehaviour
{
    [Range(-0.0001f,0.0001f)]
    public float ѹ���� = 0;
    // Start is called before the first frame update
    void Start()
    {
        Material mat = GetComponent<Renderer>().sharedMaterial;
        if(mat != null)
        {
            Material material = new Material(mat);
            material.SetFloat("_ExtrusionAmount", ѹ����);
            GetComponent<Renderer>().material = material;
        }
    }

    
}
