using GoogleMobileAds.Api;
using GoogleMobileAds.Placement;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AdmobManager
{
    private static AdmobManager _instance;

    private BannerAdGameObject _bannerAdGameObject;
    private InterstitialAdGameObject _InterAdGameObject;
    private RewardedAdGameObject _rewardedAdGameObject;

    public static AdmobManager GetInstance()
    {
        if (_instance == null)
        {
            _instance = new AdmobManager();
        }
        return _instance; 
    }

    public void InitAllAds()
    {
        InitBanner();
        InitIntertitial();
        InitRewarded();
    }

    public void InitBanner()
    {
        _bannerAdGameObject = MobileAds.Instance.GetAd<BannerAdGameObject>("Banner Ad");
        _bannerAdGameObject.LoadAd();
        _bannerAdGameObject.Hide();
    }

    public void InitIntertitial()
    {
        _InterAdGameObject = MobileAds.Instance.GetAd<InterstitialAdGameObject>("Interstitial Ad");
        _InterAdGameObject.LoadAd();
    }

    public void InitRewarded()
    {
        _rewardedAdGameObject = MobileAds.Instance.GetAd<RewardedAdGameObject>("Rewarded Ad");
        _rewardedAdGameObject.LoadAd();
    }

    public void ShowBanner()
    {
        _bannerAdGameObject.BannerView.Show();
    }
    public void ShowInter()
    {
        if (_InterAdGameObject.InterstitialAd.IsLoaded())
        {
            _InterAdGameObject.InterstitialAd.Show();
        }
        else
        {
            ZLogUtil.Log("插页没有准备完成");
        }
    }
    public void ShowRewarded()
    {
        if (_rewardedAdGameObject.RewardedAd.IsLoaded())
        {
            _rewardedAdGameObject.RewardedAd.Show();
        }
        else
        {
            ZLogUtil.Log("视频没有准备完成");
        }
    }


}
