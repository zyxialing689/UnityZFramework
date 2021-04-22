using UnityEngine;
using System.Collections;
using System.IO;


public class ScreenShot : MonoBehaviour
{

    public string fileName = "";
    string outPutPath = "C:\\Users\\Administrator\\Desktop\\截图\\";
    public bool START = false;


    public void Update()
    {
        if (START)
        {
            ScreenCapture.CaptureScreenshot(outPutPath + fileName + "_" + ZFramework.ZCommomUtil.ZGetDataTimeString() + ".jpg");
            START = false;
        }
    }


}