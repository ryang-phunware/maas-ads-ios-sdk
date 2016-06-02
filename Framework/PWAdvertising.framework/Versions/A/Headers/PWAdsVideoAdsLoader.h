//
//  PWAdsVideoAdsLoader.h
//  Video Ads SDK
//
//  Created by Kevin Truong on 4/30/13.
//

#import <Foundation/Foundation.h>
#import "PWAdsVideoManager.h"
#import "PWAdsVideoAdsRequest.h"
#import "PWAdsVideoAdError.h"

@protocol PWAdsVideoAdsLoaderDelegate;

/**
 @Deprecated
 Ad loaded data that is returned when the adsLoader loads the ad.
 */
__deprecated_msg("PWAdsVideoAdsLoadedData has been deprecated.")
@interface PWAdsVideoAdsLoadedData : NSObject

/// The ads manager returned by the adsLoader.
@property(nonatomic, strong) PWAdsVideoManager *adsManager;

/// Other user context object returned by the adsLoader.
@property(nonatomic, strong) id userContext;

@end

/**
 Ad error data that is returned when the adsLoader failed to load the ad.
 */
__deprecated_msg("PWAdsVideoAdLoadingErrorData has been deprecated.")
@interface PWAdsVideoAdLoadingErrorData : NSObject

/// The ad error that occured while loading the ad.
@property(nonatomic, strong) PWAdsVideoAdError *adError;

/// Other user context object returned by the adsLoader.
@property(nonatomic, strong) id userContext;

@end

/**
 The PWAdsVideoAdsLoader class allows requesting ads from various ad servers.
 To do so, IMAAdsLoaderDelegate must be implemented and then ads should
 be requested.
 */
__deprecated_msg("PWAdsVideoAdsLoader has been deprecated.")
@interface PWAdsVideoAdsLoader : NSObject

/// Delegate object that receives state change notifications from this
/// IMAAdsLoader. Remember to nil the delegate before releasing this
/// object.
@property(nonatomic, weak) NSObject<PWAdsVideoAdsLoaderDelegate> *delegate;

/**
 Request ads by providing the ads |request| object with properties populated
 with parameters to make an ad request to Google or DoubleClick ad server.
 Optionally, |userContext| object that is associated with the ads request can
 be provided. This can be retrieved when the ads are loaded.
 */
- (void)requestAdsWithRequestObject:(PWAdsVideoAdsRequest *)request
                        userContext:(id)context;

/**
 Request ads from a adsserver by providing the ads request object.
 */
- (void)requestAdsWithRequestObject:(PWAdsVideoAdsRequest *)request;

@end

/**
 Delegate object that receives state change callbacks from IMAAdsLoader.
 */
__deprecated_msg("PWAdsVideoAdsLoaderDelegate has been deprecated.")
@protocol PWAdsVideoAdsLoaderDelegate<NSObject>

/**
 Called when ads are successfully loaded from the ad servers by the loader.
 */
- (void)adsLoader:(PWAdsVideoAdsLoader *)loader
adsLoadedWithData:(PWAdsVideoAdsLoadedData *)adsLoadedData;

/**
 Error reported by the ads loader when ads loading failed.
 */
- (void)adsLoader:(PWAdsVideoAdsLoader *)loader
failedWithErrorData:(PWAdsVideoAdLoadingErrorData *)adErrorData;

@end
