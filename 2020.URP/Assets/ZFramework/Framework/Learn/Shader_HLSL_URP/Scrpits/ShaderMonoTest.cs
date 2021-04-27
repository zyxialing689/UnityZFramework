using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderMonoTest : MonoBehaviour
{
    public int globalMaximumLOD = 0;
    void Start()
    {
        Shader.globalMaximumLOD = globalMaximumLOD;
    }

    // Update is called once per frame
    void Update()
    {
        Shader.globalMaximumLOD = globalMaximumLOD;
    }
}
