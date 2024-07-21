using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class 相机 : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.W))
        {
            transform.position = new Vector3(transform.position.x,
                            transform.position.y + 1.0f, transform.position.z);
        }else if(Input.GetKeyDown(KeyCode.S))
        {
            transform.position = new Vector3(transform.position.x,
                            transform.position.y - 1.0f, transform.position.z);
        }
        else if (Input.GetKeyDown(KeyCode.A))
        {
            transform.position = new Vector3(transform.position.x - 1.0f,
                            transform.position.y, transform.position.z);
        }
        else if (Input.GetKeyDown(KeyCode.D))
        {
            transform.position = new Vector3(transform.position.x + 1.0f,
                            transform.position.y, transform.position.z);
        }

        if(Input.GetKey(KeyCode.LeftAlt))
        {
            float scrollValue = Input.GetAxis("Mouse ScrollWheel");
            if(scrollValue > 0f)
            {
                transform.position = new Vector3(transform.position.x,
                           transform.position.y, transform.position.z + 1f);
            }
            else if (scrollValue < 0f)
            {
                transform.position = new Vector3(transform.position.x,
                           transform.position.y, transform.position.z - 1f);
            }
        }

        Vector3 dragOrigin = new Vector3(0,0,0);
        bool isDragging = false;

        if(!isDragging && Input.GetMouseButtonDown(0))
        {
            dragOrigin = Input.mousePosition;
            isDragging = true;
        }

        if (isDragging)
        {
            if (Input.GetMouseButtonDown(0))
            {
                Vector3 dragDelta = Input.mousePosition - dragOrigin;
                transform.position = new Vector3(transform.position.x - dragDelta.x,
                           transform.position.y - dragDelta.y, transform.position.z);
                //dragOrigin = Input.mousePosition;
            }
            else
            {
                isDragging = false;
            }

        }
    }
}
