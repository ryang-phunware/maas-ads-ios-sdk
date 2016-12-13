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

/**
 Base Class for loading and presenting rewarded/interstitial video advertisments.
 */
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
 
 @param controller The view controller from which the ad should be displayed.
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
 @param adExtensionData Ad Extension Data contains information about the rewarded video. i.e. remaining views count for the current user.
 */
- (void)videoBaseDidLoadAd:(PWAdsVideoBase *)videoBase withAdExtensionData:(NSDictionary *)adExtensionData;

@optional

/**
 Called when a video base fails to load ad.
 
 @param videoBase The video base that failed to load ad.
 @param error The error string detailing why the video ad failed to play.
 @param adExtensionData Ad Extension Data contains information about the rewarded video. i.e. remaining views count for the current user.
*/
- (void)videoBase:(PWAdsVideoBase *)videoBase didFailError:(NSError *)error withAdExtensionData:(NSDictionary *)adExtensionData;

/**
 Called after video base is presented.
 
 @param videoBase The full-screen video ad that is presented.
 @param adExtensionData Ad Extension Data contains information about the rewarded video. i.e. remaining views count for the current user.
 */
- (void)videoBaseDidPresentModal:(PWAdsVideoBase *)videoBase withAdExtensionData:(NSDictionary *)adExtensionData;

/**
 Called before video base dismisses video modal.
 
 @param videoBase The video ad that finished playing.
 @param adExtensionData Ad Extension Data contains information about the rewarded video. i.e. remaining views count for the current user.
 */
- (void)videoBaseWillDismissModal:(PWAdsVideoBase *)videoBase withAdExtensionData:(NSDictionary *)adExtensionData;

/**
 Called after video base dismisses video modal.
 
 @param videoBase The video ad that finished playing.
 @param adExtensionData Ad Extension Data contains information about the rewarded video. i.e. remaining views count for the current user.
 */
- (void)videoBaseDidDismissModal:(PWAdsVideoBase *)videoBase withAdExtensionData:(NSDictionary *)adExtensionData;

/**
 Called after video base dismisses video modal.
 
 @param videoBase The video ad that finished playing.
 @param adExtensionData Companion VAST Extension data for Rewarded Video
 @param customData NSDictionary contaning relevant RVSuccess data from tracking event response. ie. amount of energy rewarded to the user.
 @param adExtensionData Ad Extension Data contains information about the rewarded video. i.e. remaining views count for the current user.
 */
- (void)videoBaseDidEndPlaybackSuccessfully:(PWAdsVideoBase *)videoBase withRVResponseObject:(NSDictionary *)customData andAdExtensionData:(NSDictionary *)adExtensionData;

@end
