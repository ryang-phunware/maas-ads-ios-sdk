//
//  TVASTAd.h
//  Video Ads SDK
//
//  Created by Kevin Truong on 4/30/13.
//
//  Declares TVASTAd interface that has the general representation of an ad.

#import <Foundation/Foundation.h>
#import "PWAdsConstants.h"

/**
 @Deprecated
 
 Class with video ad information.
 */
__deprecated_msg("PWAdsVideoAd has been deprecated.")
@interface PWAdsVideoAd : NSObject

@property(readonly, assign) PWAdsAdType adType;
@property(readonly, strong) NSString *adId;
@property(readonly, assign) float creativeWidth;
@property(readonly, assign) float creativeHeight;
@property(readonly, strong) NSDictionary *adExtensionData;

/// The length of the media file in seconds. Returns -1 if the duration value
/// is not available.
@property(readonly, assign) float duration;

/// The URL of the media file chosen from the ad to play. Returns null if the
/// information is not available.
@property(readonly, strong) NSString *mediaUrl;

/**
 Returns the current version string of this SDK.
 */
+ (NSString *)getSDKVersionString;

@end

