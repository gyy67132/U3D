using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class 碰撞脚本 : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        //print("Update" + Time.deltaTime);   
        if(Input.GetKeyDown(KeyCode.Space))
        {
            print("Space down");
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
        Debug.Log(collision.gameObject.name + "Enter");
    }

    private void OnCollisionStay(Collision collision)
    {
        Debug.Log(collision.gameObject.name + "Stay");
    }
    private void OnCollisionExit(Collision collision)
    {
        Debug.Log(collision.gameObject.name + "Exit");
    }

    private void OnTriggerEnter(Collider collision)
    {
        Debug.Log(collision.gameObject.name + "Trigger Enter");
    }

    private void OnTriggerStay(Collider collision)
    {
        Debug.Log(collision.gameObject.name + "Trigger Stay");
    }

    private void OnTriggerExit(Collider collision)
    {
        Debug.Log(collision.gameObject.name + "Trigger Exit");
    }

    private void OnMouseDown()
    {
        print("OnMouseDown");
        var pos = this.gameObject.transform.position;
        this.gameObject.transform.position = new Vector3(pos.x, pos.y+0.5f, pos.z);
    }

    private void OnMouseEnter()
    {
        print("OnMouseEnter");
    }

    private void OnMouseDrag()
    {
        print("OnMouseDrag");
    }

    private void OnMouseExit()
    {
        print("OnMouseExit");
    }

    private void OnMouseOver()
    {
        print("OnMouseOver");
    }

    private void OnMouseUp()
    {
        print("OnMouseUp");
    }
}
