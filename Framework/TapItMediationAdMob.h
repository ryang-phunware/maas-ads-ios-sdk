//
//  TapItMediationAdMob.h
//  NickTest
//
//  Created by Nick Penteado on 8/24/12.
//  Copyright (c) 2012 Nick Penteado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADMAdNetworkAdapterProtocol.h"
#import "GADMAdNetworkConnectorProtocol.h"
#import <MaaSAdvertising/PWAds.h>

@interface TapItMediationAdMob : NSObject <PWAdsBannerAdViewDelegate, PWAdsInterstitialAdDelegate, GADMAdNetworkAdapter> {
    id<GADMAdNetworkConnector> connector;
    PWAdsBannerAdView *pwAd;
    PWAdsInterstitialAd *pwInterstitial;
    // used to suppress duplicate calls to adapterWillPresentInterstitial:, adapter:clickDidOccurInBanner, and adapterWillPresentFullScreenModal:
    // (pw sdk calls pw[Interstitial|Banner]AdActionShouldBegin:willLeaveApplication: each time a http redirect occurs...)
    int redirectCount;
}

@property (nonatomic, retain) UIView *pwAd;
@property (nonatomic, retain) NSObject *pwInterstitial;

@end
