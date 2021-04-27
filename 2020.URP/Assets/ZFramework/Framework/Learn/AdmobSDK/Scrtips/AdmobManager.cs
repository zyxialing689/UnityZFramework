using GoogleMobileAds.Api;
using GoogleMobileAds.Placement;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AdmobManager
{
    private static AdmobManager _instance;

    private BannerAdGameObject _bannerAdGameObject;

    public static AdmobManager GetInstance()
    {
        if (_instance == null)
        {
            _instance = new AdmobManager();
        }
        return _instance; 
    }

    public void InitBanner()
    {
        _bannerAdGameObject = MobileAds.Instance.GetAd<BannerAdGameObject>("Banner Ad");
        _bannerAdGameObject.LoadAd();
    }

    public void ShowBanner()
    {
        _bannerAdGameObject.Show();
    }

}
