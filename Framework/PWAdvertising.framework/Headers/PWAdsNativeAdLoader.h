//
//  PWAdsNativeAdLoader.h
//  PWAdvertising
//
//  Created by Hari Kunwar on 4/21/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//


#import <UIKit/UIKit.h>

@class PWAdsRequest;
@protocol PWAdsNativeAdLoaderDelegate;

/**
 Class for loading native advertisement.
 */
@interface PWAdsNativeAdLoader : NSObject

/// The delegate that implements PWAdsNativeAdLoaderDelegate protocol.
@property (nonatomic, weak) id<PWAdsNativeAdLoaderDelegate> delegate;

/**
 Request Interstitial ads using PWAdsRequest instance.
 
 @param request The object with zone id, location and other ad information.
 */
- (void)loadAdsRequest:(PWAdsRequest *)request;

@end


/**
 `PWAdsNativeAdLoaderDelegate` is needed to receive notifications about native ad status.
 */
@protocol PWAdsNativeAdLoaderDelegate <NSObject>
@optional

/**
 Called when a new native advertisement is loaded.
 
 @param nativeAds The native ads that was downloaded.
 */
- (void)nativeAdLoaderDidLoadAds:(NSArray *)nativeAds;

/**
 Called when a native advertisement fails to load.
 
 @param loader The native ad loader that failed to load.
 @param error The error object that describes the problem.
 */
- (void)nativeAdLoader:(PWAdsNativeAdLoader *)loader didFailWithError:(NSError *)error;

@end



