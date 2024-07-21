using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class 点击事件 : MonoBehaviour, IPointerDownHandler , IDragHandler
{
    public Button.ButtonClickedEvent Click;
    public Vector3 ClickPoint { get; set; }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    public void OnPointerDown(PointerEventData eventData)
    {
        var rect = transform as RectTransform;
        if (rect != null)
        {
            ClickPoint = rect.InverseTransformPoint(eventData.position);
            Click.Invoke();
        }
    }

    public void OnDrag(PointerEventData eventData)
    {
        
    }
}
