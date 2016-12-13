//
//  PWAdsRewardedVideo.h
//  PWAdvertising
//
//  Created by Ricardo Guillen on 8/11/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWAdsVideoBase.h"

@class PWAdsRequest;
@protocol PWAdsRewardedVideoDelegate;

/**
 Class for loading and presenting rewarded video advertisments.
 */
@interface PWAdsRewardedVideo : PWAdsVideoBase

/// The delegate that implements PWAdsRewardedVideoDelegate protocol.
@property (nonatomic, weak) id<PWAdsRewardedVideoDelegate> delegate;

/// The current ad request object.
@property (nonatomic, readonly) PWAdsRequest *currentAdsRequest;

/// The current ad remaining views for user.
@property (nonatomic, readonly) int remainingViews;

/**
 Request Rewarded Video ad using PWAdsRequest instance.
 
 @param request The object with zone id, location and other ad information.
 */
- (void)loadAdsRequest:(PWAdsRequest *)request;

/**
 Called to present full screen video advertisment.
 
 @param contoller The view controller from which the ad should be displayed.
 @discussion This method should be called only after rewarded video advertisment is loaded.
 */
- (void)presentFromViewController:(UIViewController *)contoller;

@end

/**
 A `PWAdsRewardedVideoDelegate` is needed to receive callbacks about rewarded video ad status.
 */
@protocol PWAdsRewardedVideoDelegate <NSObject>

@required

/**
 Called when the adsLoader receives a video ad and is ready to play (required).
 
 @param rewardedVideo The video ad that was loaded.
 @param adExtensionData Ad Extension Data contains information about the rewarded video. i.e. remaining views count for the current user.
 */
- (void)rewardedVideoDidLoadAd:(PWAdsRewardedVideo *)rewardedVideo withAdExtensionData:(NSDictionary *)adExtensionData;

/**
 Called after rewarded video playback ends.
 
 @param rewardedVideo The video ad that finished playing.
 @param customData Data provided by the client is returned for confirmation of reward.
 @param adExtensionData Ad Extension Data contains information about the rewarded video. i.e. remaining views count for the current user.
 */
- (void)rewardedVideoDidEndPlaybackSuccessfully:(PWAdsRewardedVideo *)rewardedVideo withRVResponseObject:(NSDictionary *)customData andAdExtensionData:(NSDictionary *)adExtensionData;

@optional

/**
 Called when a rewarded video fails to load ad.
 
 @param rewardedVideo The rewarded video that failed to load ad.
 @param error The error string detailing why the video ad failed to play.
 @param adExtensionData Ad Extension Data contains information about the rewarded video. i.e. remaining views count for the current user.
 */
- (void)rewardedVideo:(PWAdsRewardedVideo *)rewardedVideo didFailError:(NSError *)error withAdExtensionData:(NSDictionary *)adExtensionData;

/**
 Called after rewarded video is presented.
 
 @param rewardedVideo The full-screen video ad that is presented.
 @param adExtensionData Ad Extension Data contains information about the rewarded video. i.e. remaining views count for the current user.
 */
- (void)rewardedVideoDidPresentModal:(PWAdsRewardedVideo *)rewardedVideo withAdExtensionData:(NSDictionary *)adExtensionData;

/**
 Called before rewarded video dismisses video modal.
 
 @param rewardedVideo The video ad that finished playing.
 @param adExtensionData Ad Extension Data contains information about the rewarded video. i.e. remaining views count for the current user.
 */
- (void)rewardedVideoWillDismissModal:(PWAdsRewardedVideo *)rewardedVideo withAdExtensionData:(NSDictionary *)adExtensionData;

/**
 Called after rewarded video dismisses video modal.
 
 @param rewardedVideo The video ad that finished playing.
 @param adExtensionData Ad Extension Data contains information about the rewarded video. i.e. remaining views count for the current user.
 */
- (void)rewardedVideoDidDismissModal:(PWAdsRewardedVideo *)rewardedVideo withAdExtensionData:(NSDictionary *)adExtensionData;


@end
