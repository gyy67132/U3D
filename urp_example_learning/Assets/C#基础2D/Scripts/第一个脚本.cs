using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class 第一个脚本 : MonoBehaviour
{
    public GameObject firstGameObj;
    public TMP_Text firstText;
    public Sprite firstSprite;
    public GameObject rum;
    // Start is called before the first frame update
    void Start()
    {
        firstGameObj.transform.position = new Vector3(firstGameObj.transform.position.x ,
            firstGameObj.transform.position.y+0.5f , firstGameObj.transform.position.z);
        print(firstGameObj.transform.position.y);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void firstOnClick()
    {
        //firstGameObj.transform.position = new Vector3(firstGameObj.transform.position.x,
        //    firstGameObj.transform.position.y + 0.5f, firstGameObj.transform.position.z);
        //float y_value = firstGameObj.transform.position.y;
        //firstText.text = y_value.ToString();

        //firstGameObj.GetComponent<SpriteRenderer>().sprite = firstSprite;
        firstGameObj.SetActive(!firstGameObj.activeSelf);

        rum = GameObject.Find("rum");
    }
}
