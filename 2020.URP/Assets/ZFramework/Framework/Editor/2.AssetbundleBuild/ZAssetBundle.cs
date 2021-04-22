using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;
namespace ZFramework
{
 public class ZAssetBundle
{

    [MenuItem("ZFramework/Editor/2.Bulid/Build Android")]
    static private void BuildAndroid()
    {
        Build_ANDROID();
    }

    [MenuItem("ZFramework/Editor/2.Bulid/Build Ios")]
    static private void BuildIos()
    {
        Build_IOS();
    }

    [MenuItem("ZFramework/Editor/2.Bulid/Build Windows64")]
    static private void BuildWindows64()
    {
        Build_WINDOWS64();
    }

    public static void Build_ANDROID()
    {

        // Choose the output path according to the build target.
        string outputPath = Application.streamingAssetsPath;
        if (!Directory.Exists(outputPath))
            Directory.CreateDirectory(outputPath);

        //@TODO: use append hash... (Make sure pipeline works correctly with it.)
        BuildPipeline.BuildAssetBundles(outputPath, BuildAssetBundleOptions.None, BuildTarget.Android);
        AssetDatabase.Refresh();

    }
    public static void Build_IOS()
    {
        // Choose the output path according to the build target.
        string outputPath = Application.streamingAssetsPath;
        if (!Directory.Exists(outputPath))
            Directory.CreateDirectory(outputPath);

        //@TODO: use append hash... (Make sure pipeline works correctly with it.)
        BuildPipeline.BuildAssetBundles(outputPath, BuildAssetBundleOptions.None, BuildTarget.iOS);
        AssetDatabase.Refresh();

    }

    public static void Build_WINDOWS64()
    {
        // Choose the output path according to the build target.
        string outputPath =Application.streamingAssetsPath;
        if (!Directory.Exists(outputPath))
            Directory.CreateDirectory(outputPath);

        //@TODO: use append hash... (Make sure pipeline works correctly with it.)
        BuildPipeline.BuildAssetBundles(outputPath, BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows64);
        AssetDatabase.Refresh();

    }
}

}