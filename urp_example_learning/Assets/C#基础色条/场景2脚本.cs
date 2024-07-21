using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class 场景2脚本 : MonoBehaviour
{
    public GameObject newCube;
    // Start is called before the first frame update
    void Start()
    {
        newCube = GameObject.CreatePrimitive(PrimitiveType.Cube);
        //newCube.GetComponent<MeshRenderer>().material = Resources.Load("mat");
        
        newCube.GetComponent<MeshRenderer>().material = (Material)Resources.Load("mat");
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
