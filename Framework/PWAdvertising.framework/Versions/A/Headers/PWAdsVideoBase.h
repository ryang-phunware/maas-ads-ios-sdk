//
//  PWAdsVideoBase.h
//  PWAdvertising
//
//  Created by Ricardo Guillen on 8/11/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PWAdsRequest;
@protocol PWAdsVideoBaseDelegate;

@interface PWAdsVideoBase : NSObject

/// The delegate that implements PWAdsVideoBaseDelegate protocol.
@property (nonatomic, weak) id<PWAdsVideoBaseDelegate> baseDelegate;

/// The current video ad request object.
@property (nonatomic, readonly) PWAdsRequest *baseCurrentAdsRequest;

/**
 Request video ads using PWAdsRequest instance.
 
 @param request The object with zone id, location and other ad information.
 */
- (void)baseLoadAdsRequest:(PWAdsRequest *)request;

/**
 Called to present full screen video ad advertisment.
 
 @param contoller The view controller from which the ad should be displayed.
 @discussion This method should be called only after video ad advertisment is loaded.
 */
- (void)basePresentFromViewController:(UIViewController *)controller;

@end

/**
 A `PWAdsVideoBaseDelegate` is needed to receive callbacks about video ad status.
 */
@protocol PWAdsVideoBaseDelegate <NSObject>

@required

/**
 Called when the adsLoader receives a video ad and is ready to play (required).
 
 @param videoBase The video ad that was loaded.
 */
- (void)videoBaseDidLoadAd:(PWAdsVideoBase *)videoBase withAdExtensionData:(NSDictionary *)adExtensionData;

@optional

/**
 Called when a video base fails to load ad.
 
 @param videoBase The video base that failed to load ad.
 @param error The error string detailing why the video ad failed to play.
 */
- (void)videoBase:(PWAdsVideoBase *)videoBase didFailError:(NSError *)error withAdExtensionData:(NSDictionary *)adExtensionData;

/**
 Called after video base is presented.
 
 @param videoBase The full-screen video ad that is presented.
 */
- (void)videoBaseDidPresentModal:(PWAdsVideoBase *)videoBase withAdExtensionData:(NSDictionary *)adExtensionData;

/**
 Called before video base dismisses video modal.
 
 @param videoBase The video ad that finished playing.
 */
- (void)videoBaseWillDismissModal:(PWAdsVideoBase *)videoBase withAdExtensionData:(NSDictionary *)adExtensionData;

/**
 Called after video base dismisses video modal.
 
 @param videoBase The video ad that finished playing.
 */
- (void)videoBaseDidDismissModal:(PWAdsVideoBase *)videoBase withAdExtensionData:(NSDictionary *)adExtensionData;

/**
 Called after video base dismisses video modal.
 
 @param videoBase The video ad that finished playing.
 */
- (void)videoBaseDidEndPlaybackSuccessfully:(PWAdsVideoBase *)videoBase withRVResponseObject:(NSDictionary *)customData andAdExtensionData:(NSDictionary *)adExtensionData;

@end
