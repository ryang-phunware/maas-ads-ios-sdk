//
//  PWAds.h
//  PWAdvertising
//
//  Copyright © 2015 Phunware, Inc. All rights reserved.
//

#ifndef PWAds_iOS_SDK_h
#define PWAds_iOS_SDK_h
#import "PWAdsAppTracker.h"
#import "PWAdsRequest.h"
#import "PWAdsBannerView.h"
#import "PWAdsInterstitial.h"
#import "PWAdsVideoInterstitial.h"
#import "PWAdsNativeAdLoader.h"
#import "PWAdsNativeAdView.h"
#import "PWAdsNativeAd.h"
// Deprecated
#import "PWAdsBannerAdView.h"
#import "PWAdsBrowserControllerDelegate.h"
#import "PWAdsConstants.h"
#import "PWAdsInterstitialAd.h"
#import "PWAdsNativeAd.h"
#import "PWAdsNativeAdManager.h"
#import "PWAdsVideoAd.h"
#import "PWAdsVideoAdClickThroughBrowser.h"
#import "PWAdsVideoAdClickTrackingUIView.h"
#import "PWAdsVideoAdError.h"
#import "PWAdsVideoAdsLoader.h"
#import "PWAdsVideoAdsRequest.h"
#import "PWAdsVideoInterstitialAd.h"
#import "PWAdsVideoManager.h"

#endif

@interface PWAds : NSObject

/**
 Set the maximum number of bytes allowed on disk before it starts evicting objects.
 
 @discussion The default cache size limit is 50 MB. It can be set to 0, or any value betweem 50 MB to 2 GB. After reaching the limit, the least recently used item(s) will be evicted on background thread.
 
 @param byteLimit The maximum number of bytes allowed on disk
 
 */
+ (void)setCacheByteLimit:(NSInteger)byteLimit;

@end
