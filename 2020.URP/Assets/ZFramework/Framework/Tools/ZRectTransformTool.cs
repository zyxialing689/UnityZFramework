using System;
using UnityEngine;
namespace ZFramework
{

    public class ZRectTransformTool
    {
        /// <summary>
        /// 修改Recttransform的中心轴位置，且保持当前的位置不变，仅适用于anchors为中心的
        /// </summary>
        /// <param name="rt"></param>
        /// <param name="targetPivot"></param>
        public static void ChangePivotKeepPosition(RectTransform rt, Vector2 targetPivot)
        {
            //Debug.Log(rt);
            Vector2 relPivot;
            relPivot = targetPivot - rt.pivot;

           // Debug.Log(rt.rect.height * relPivot.y);
            rt.anchoredPosition += new Vector2(rt.rect.width * relPivot.x * rt.localScale.x, rt.rect.height * relPivot.y*rt.localScale.y);
            rt.pivot = targetPivot;


        }
        /// <summary>
        /// 修改Recttransform的anchor，且保持当前的位置不变
        /// </summary>
        /// <param name="rt"></param>
        /// <param name="targetPivot"></param>
        public static void ChangeAnchorKeepPositionX(RectTransform rt,float width,float targetAnchorX)
        {
            float relPivotX;

            relPivotX = -(targetAnchorX - rt.anchorMin.x);

            Debug.Log(relPivotX);
            Debug.Log(width);
            rt.anchoredPosition += new Vector2(width * relPivotX,0);
            rt.anchorMin = new Vector2(targetAnchorX, rt.anchorMin.y);
            rt.anchorMax = new Vector2(targetAnchorX, rt.anchorMax.y);


        }
        /// <summary>
        /// 修改Recttransform的anchor，且保持当前的位置不变
        /// </summary>
        /// <param name="rt"></param>
        /// <param name="targetPivot"></param>
        public static void ChangeAnchorKeepPositionY(RectTransform rt, float height, float targetAnchorY)
        {
            float relPivotY;

            relPivotY = -(targetAnchorY - rt.anchorMin.y);

            Debug.Log(relPivotY);
            Debug.Log(height);
            rt.anchoredPosition += new Vector2(0, height * relPivotY);
            rt.anchorMin = new Vector2(rt.anchorMin.x, targetAnchorY);
            rt.anchorMax = new Vector2(rt.anchorMax.x, targetAnchorY);


        }

        /// <summary>
        /// 该方法不适合用于anchor特殊的值
        /// </summary>
        /// <param name="orgin"></param>
        /// <param name="target"></param>
        public static void CopyValueToTarget(RectTransform orgin,RectTransform target)
        {
            target.localScale = orgin.localScale;
            target.anchorMin = orgin.anchorMin;
            target.anchorMax = orgin.anchorMax;
            target.pivot = orgin.pivot;
            target.sizeDelta = orgin.sizeDelta;
            target.anchoredPosition = orgin.anchoredPosition;
        }

    }
}