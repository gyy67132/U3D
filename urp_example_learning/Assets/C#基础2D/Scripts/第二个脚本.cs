using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class 第二个脚本 : MonoBehaviour
{
  
    public Sprite spriteObj;

    public GameObject secondObj;

    public List<GameObject> cloneObjs;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void btnOnClick1()
    {
        secondObj = new GameObject("SecondUnityObject");
    }
    public void btnOnClick2()
    {
        if (secondObj != null)
        {
            secondObj.AddComponent<SpriteRenderer>();
            var addedSprite = secondObj.GetComponent<SpriteRenderer>();
            if(addedSprite != null && spriteObj != null)
            {
                addedSprite.sprite = spriteObj;
            }
        }
    }
    public void btnOnClick3()
    {
        if(secondObj != null)
        {
            secondObj.SetActive(!secondObj.activeSelf);
        }
    }
    public void btnOnClick4()
    {
        var newPosition = new Vector3(secondObj.transform.position.x, secondObj.transform.position.y+1.0f,
                        secondObj.transform.position.z);
        var cloneObj = Instantiate(secondObj, newPosition, secondObj.transform.rotation);
        cloneObjs.Add(cloneObj);
    }
    public void btnOnClick5()
    {
        foreach(var item in cloneObjs)
        {
            Destroy(item);
        }
        cloneObjs.Clear();
    }
    public void btnOnClick6()
    {
        if(secondObj != null)
        {
            secondObj.AddComponent<HelloUnity>();
        }
    }
    public void btnOnClick7()
    {
        if(secondObj != null)
        {
            secondObj.SendMessage("TestSendMessage");
        }
    }
}
