using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class 按钮鼠标事件 : MonoBehaviour
{
    // Start is called before the first frame update
    Vector3 Position;

    void Start()
    {
        Position = this.gameObject.transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        //print("Update" + Time.deltaTime);   
        if (Input.GetKeyDown(KeyCode.Space))
        {
            Debug.Log("Space down");
            this.gameObject.transform.position = Position;
        }
        if (Input.GetMouseButtonDown(0))
        {
            print("mouse button down");

            var pos = this.gameObject.transform.position;
            this.gameObject.transform.position = new Vector3(pos.x, pos.y + 0.5f, pos.z);
        }
        if(Input.GetKeyDown(KeyCode.Escape))
        {
            UnityEditor.EditorApplication.isPlaying = false;
            print("out");
        }
        if(Input.GetKeyDown(KeyCode.L))
        {
            SceneManager.LoadScene("SampleScene");//必须要在build settings中添加过的
        }
        
    }

    void FixedUpdate()
    {
        //print("FixedUpdate" + Time.deltaTime);
    }

    private void OnCollisionEnter(Collision collision)
    {
        Debug.Log(collision.gameObject.name + "Enter---------------------------------------1");
    }

    private void OnCollisionStay(Collision collision)
    {
        Debug.Log(collision.gameObject.name + "Stay---------------------------------------2");
    }
    private void OnCollisionExit(Collision collision)
    {
        Debug.Log(collision.gameObject.name + "Exit---------------------------------------3");
    }

    private void OnTriggerEnter(Collider collision)
    {
        Debug.Log(collision.gameObject.name + "Trigger Enter---------------------------------------4");
    }

    private void OnTriggerStay(Collider collision)
    {
        Debug.Log(collision.gameObject.name + "Trigger Stay---------------------------------------5");
    }

    private void OnTriggerExit(Collider collision)
    {
        Debug.Log(collision.gameObject.name + "Trigger Exit---------------------------------------6");
    }

    private void OnMouseDown()
    {
        print("OnMouseDown ---------------------------------------7");
        //var pos = this.gameObject.transform.position;
        //this.gameObject.transform.position = new Vector3(pos.x, pos.y+0.5f, pos.z);
    }

    private void OnMouseEnter()
    {
        print("OnMouseEnter---------------------------------------8");
    }

    private void OnMouseDrag()
    {
        //print("OnMouseDrag---------------------------------------9");
    }

    private void OnMouseExit()
    {
        print("OnMouseExit---------------------------------------10");
    }

    private void OnMouseOver()
    {
        //print("OnMouseOver---------------------------------------11");
    }

    private void OnMouseUp()
    {
        print("OnMouseUp---------------------------------------12");
    }
}
