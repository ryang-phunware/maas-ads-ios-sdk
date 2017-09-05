//
//  PWAdvertising.h
//  PWAdvertising
//
//  Copyright © 2015 Phunware, Inc. All rights reserved.
//

#import "PWAds.h"
#import "PWAdsAppTracker.h"
#import "PWAdsBannerView.h"
#import "PWAdsBrowserControllerDelegate.h"
#import "PWAdsConstants.h"
#import "PWAdsInterstitial.h"
#import "PWAdsLandingPage.h"
#import "PWAdsNativeAd.h"
#import "PWAdsNativeAdLoader.h"
#import "PWAdsNativeAdManager.h"
#import "PWAdsNativeAdView.h"
#import "PWAdsRequest.h"
#import "PWAdsRewardedVideo.h"
#import "PWAdsVideoInterstitial.h"
#import "PWAdsVideoBase.h"
#import <PWCore/PWCore.h>

static NSString * const PWAdvertisingVersion = @"3.6.3";

@interface PWAdvertising : NSObject

/**
 Set the maximum number of bytes allowed on disk before it starts evicting objects.
 
 @discussion The default cache size limit is 50 MB. It can be set to 0, or any value betweem 50 MB to 2 GB. After reaching the limit, the least recently used item(s) will be evicted on background thread.
 
 @param byteLimit The maximum number of bytes allowed on disk
 
 */
+ (void)setCacheByteLimit:(NSInteger)byteLimit;

/**
 Returns the name of the SDK, `PWAdvertising`.
 */
+ (NSString *)serviceName;

@end
