using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class 相机 : MonoBehaviour
{
    public float 移动方向 = 0.001f;//0-360
    // Start is called before the first frame update
    void Start()
    {
        transform.position = new Vector3(0, 0, - 10f);
    }

    Vector3 dragOrigin = new Vector3(0, 0, 0);
    bool isDragging = false;
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

        //if (Input.GetKey(KeyCode.LeftAlt)) 
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

        if(Input.GetMouseButtonDown(0))
            isDragging = true;

        if (Input.GetMouseButtonUp(0))
            isDragging = false;

        if (isDragging)
        {
            float mouseX = Input.GetAxis("Mouse X");
            float mouseY = Input.GetAxis("Mouse Y");
            if (Input.GetKey(KeyCode.LeftAlt))
            {
                if(mouseX != 0f || mouseY != 0f)
                {
                    //float r = Mathf.Sqrt(transform.position.x * transform.position.x + transform.position.y * transform.position.y + transform.position.z * transform.position.z);
                    //float 单位值 = r/10.0f;
                    //float 正弦值= mouseY / Mathf.Sqrt(mouseY * mouseY +  mouseX* mouseX);
                    //float 弧度角度 = Mathf.Asin(正弦值);
                    //float x = transform.position.x + Mathf.Cos(弧度角度) * 单位值;
                    //float y = transform.position.y + Mathf.Sin(弧度角度) * 单位值;
                    //float z = Mathf.Sqrt(r * r - x * x - y * y);

                    //transform.position = new Vector3(x,y,z);
                    //transform.LookAt(Vector3.zero);
                }

            }
            else
            {
                transform.position = new Vector3(transform.position.x - mouseX,
                          transform.position.y - mouseY, transform.position.z);
            }
        }

        转圈圈();
    }

    private float angle=0;
    private void 转圈圈()
    {
        float r = 10f;

        float PI = 3.1515926f;

        float yChange = Mathf.Sin(0.5f) * r;
        float xChange = Mathf.Sin(angle) * r * Mathf.Cos(0.5f);
        angle += 0.01f;
        if (angle > PI * 2)
            angle = 0f;
        float x = xChange;
        float y = yChange;
        float zTmp = 10f * 10f - x * x - y * y;
        float z;
        if (angle > PI/2f && angle < PI*1.5f )
            z = -Mathf.Sqrt(zTmp);
        else
            z = Mathf.Sqrt(zTmp);
        transform.position = new Vector3(x,y,z);
        transform.LookAt(Vector3.zero);
    }
}
