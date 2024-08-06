using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Video;

public class MyVideo : MonoBehaviour
{
    public Text text_PlayOrPause;
    public Button button_PlayOrPause;
    public Slider slider;

    private VideoPlayer videoPlayer;
    private RawImage rawImage;

    // Start is called before the first frame update
    void Start()
    {
        videoPlayer = GetComponent<VideoPlayer>();
        rawImage = GetComponent<RawImage>();
        button_PlayOrPause.onClick.AddListener(PlayorPause);
        slider.onValueChanged.AddListener(OnSliderValueChanged);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void PlayorPause()
    {
        if(videoPlayer.isPlaying == true)
        {
            videoPlayer.Pause();
            text_PlayOrPause.text = "²¥·Å";
            Time.timeScale = 0;
        }
        else
        {
            videoPlayer.Play();
            text_PlayOrPause.text = "ÔÝÍ£";
        }
    }

    void OnSliderValueChanged(float value)
    {
        videoPlayer.time = videoPlayer.length * value;
    }
}
