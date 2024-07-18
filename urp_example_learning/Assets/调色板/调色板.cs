using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class 调色板 : MonoBehaviour
{
    public Image 色相图片;
    public Image 颜色图片;

    public RectTransform 色相横线;
    // Start is called before the first frame update
    void Start()
    {
        if(色相图片 != null)
        {
            int width = 10;
            int height = 10;
            Texture2D texture = new Texture2D(width, height);
            texture.wrapMode = TextureWrapMode.Clamp;

            Color color = new Color(1.0f, 0.0f, 0.0f, 1.0f);
            for (int i = 0; i < width; i++)
                for(int j = 0; j < height; j++)
                {
                    texture.SetPixel(i, j, color);
                }
           
            texture.Apply();
            Sprite sprite = Sprite.Create(texture, new Rect(0, 0, width, height), new Vector2(0.5f, 0.5f));
            色相图片.sprite = sprite;
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void 色相画面点击(点击事件 sender)
    {
        var h = 色相图片.rectTransform.sizeDelta.y / 2.0f;
        var y = Mathf.Clamp(sender.ClickPoint.y, -h, h);
        色相横线.anchoredPosition = new Vector2(0, y);

        if(颜色图片 != null)
        {
            int width = 10;
            int height = 10;
            Texture2D texture = new Texture2D(width, height);
            Color color = new Color(1.0f, 1.0f, 0.0f, 1.0f);
            for (int i = 0; i < width; i++)
                for (int j = 0; j < height; j++)
                {
                    texture.SetPixel(i, j, color);
                }
            texture.Apply();
            Sprite sp =  Sprite.Create(texture, new Rect(0, 0, width, height), new Vector2(0.5f, 0.5f));
            颜色图片.sprite = sp;
        }
    }
}
