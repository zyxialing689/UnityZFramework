using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestADMono : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        AdmobManager.GetInstance().InitBanner();
        AdmobManager.GetInstance().ShowBanner();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
