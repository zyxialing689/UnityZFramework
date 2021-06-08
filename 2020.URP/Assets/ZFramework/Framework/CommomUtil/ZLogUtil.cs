using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ZLogUtil 
{
    public static void Log(object message)
    {
        if (ZDefine.ZLog_Switch)
        {
            Debug.Log(message);
        }
    }
}
