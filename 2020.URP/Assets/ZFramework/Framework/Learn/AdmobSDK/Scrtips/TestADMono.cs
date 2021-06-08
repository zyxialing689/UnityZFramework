using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TestADMono : MonoBehaviour
{
    public Text bannerText;
    public Text interText;
    public Text rewardText;
    void Start()
    {
        AdmobManager.GetInstance().InitAllAds();
 
    }

    public void ShowBanner()
    {
        AdmobManager.GetInstance().ShowBanner();
    }

    public void ShowInter()
    {
        AdmobManager.GetInstance().ShowInter();
    }

    public void ShowRewarded()
    {
        AdmobManager.GetInstance().ShowRewarded();
    }

    public void BannerOnAdLoaded()
    {
        ZLogUtil.Log("BannerOnAdLoaded");
    }

    public void BannerOnAdFailedToLoad(string data)
    {
        ZLogUtil.Log("BannerOnAdFailedToLoad");
    }

    public void BannerOnAdOpening()
    {
        ZLogUtil.Log("BannerOnAdOpening");
    }

    public void BannerOnAdClosed()
    {
        ZLogUtil.Log("BannerOnAdClosed");
    }

    public void BannerOnAdLeavingApplication()
    {
        ZLogUtil.Log("BannerOnAdLeavingApplication");
    }

    public void InterstitialOnAdLoaded()
    {
        ZLogUtil.Log("InterstitialOnAdLoaded");
    }

    public void InterstitialOnAdFailedToLoad(string data)
    {
        ZLogUtil.Log("InterstitialOnAdFailedToLoad");
    }

    public void InterstitialOnAdOpening()
    {
        ZLogUtil.Log("InterstitialOnAdOpening");
    }

    public void InterstitialOnAdClosed()
    {
        ZLogUtil.Log("InterstitialOnAdClosed");
    }

    public void InterstitialAdLeavingApplication()
    {
        ZLogUtil.Log("InterstitialAdLeavingApplication");
    }

    public void RewardedOnAdLoaded()
    {
        ZLogUtil.Log("RewardedOnAdLoaded");
    }

    public void RewardedOnAdFailedToLoad(string data)
    {
        ZLogUtil.Log("RewardedOnAdFailedToLoad");
    }

    public void RewardedOnAdFailedToShow(string data)
    {
        ZLogUtil.Log("RewardedOnAdFailedToShow");
    }

    public void RewardedOnAdOpening()
    {
        ZLogUtil.Log("RewardedOnAdOpening");
    }

    public void RewardedOnUserEarnedReward()
    {
        ZLogUtil.Log("RewardedOnAdOpening");
        rewardText.text = "RewardedOnAdOpening";
    }

    public void RewardedOnAdClosed()
    {
        ZLogUtil.Log("RewardedOnAdClosed");
    }

}
