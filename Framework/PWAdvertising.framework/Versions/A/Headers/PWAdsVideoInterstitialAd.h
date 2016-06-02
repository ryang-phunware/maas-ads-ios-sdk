//
//  PWAdsVideoInterstitialAd.h
//  PWAds iOS SDK
//
//  Copyright (c) 2015 TapIt! by Phunware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import "PWAdsVideoAdsRequest.h"
#import "PWAdsVideoManager.h"
#import "PWAdsVideoAdsLoader.h"
#import "PWAdsVideoAdClickTrackingUIView.h"
#import "PWAdsVideoAdClickThroughBrowser.h"
#import "PWAdsConstants.h"

@class PWAdsVideoInterstitialAd, PWAdsFullScreenVC;
@protocol PWAdsVideoInterstitialAdDelegate;

/**
 @Deprecated
 `PWAdsVideoInterstitialAd` implements a standard `PWAdsVideoInterstitialAd` into your app.
 */
__deprecated_msg("PWAdsVideoInterstitialAd has been deprecated.")
@interface PWAdsVideoInterstitialAd : NSObject <PWAdsVideoAdsLoaderDelegate,
PWAdsVideoAdClickTrackingUIViewDelegate, PWAdsVideoManagerDelegate,
PWAdsVideoAdClickThroughBrowserDelegate>

/// An `id` used to identify the 'PWAdsVideoInterstitialAdDelegate' delegate.
@property (weak, nonatomic) id<PWAdsVideoInterstitialAdDelegate> delegate;

/// A `PWAdsVideoManager` is the manager of video ads.
@property(nonatomic, strong) PWAdsVideoManager *videoAdsManager;

/// A `BOOL` to signify whether or not you want the ad to automatically reposition to orientation changes. The default value is `TRUE`.
@property (assign, nonatomic) BOOL autoReposition;

/// A `PWAdsVideoAdClickTrackingUIView` handles touch events on the video ad.
@property(nonatomic, strong) PWAdsVideoAdClickTrackingUIView *clickTrackingView;

/// The `AVPlayer` will display the video ad.
@property (nonatomic, strong) AVPlayer *adPlayer;

/// The `PWAdsFullScreenVC` will contain the `AVPlayer`.
@property (nonatomic, strong) PWAdsFullScreenVC *landscapeVC;

/// A `UIViewController` is responsible for presenting the video ad (optional).
@property (nonatomic, strong) UIViewController *presentingViewController;

/**
 Once an ad has successfully been returned from the server, the `PWAdsVideoManager` is created. You need to stop observing and unload the `PWAdsVideoManager` upon deallocating this object.
 */
- (void)unloadAdsManager;

/**
 Once `PWAdsVideoManager` has an ad ready to play, this is the function you need to call when you are ready to play the ad.
 */
- (void)playVideoFromAdsManager;

/**
 Instantiantes the `PWAdsVideoAdsRequest`.
 
 @param request The ad request with zone information and any custom parameters.
 */
-(void)requestAdsWithRequestObject:(PWAdsVideoAdsRequest *)request;

/**
 Instantiantes the `PWAdsVideoAdsRequest` with a specified `PWAdsVideoType`.
 
 @param request The ad request with zone information and any custom parameters.
 @param videoType The type of video being requested (all, pre-roll, mid-roll, post-roll).
 */
-(void)requestAdsWithRequestObject:(PWAdsVideoAdsRequest *)request andVideoType:(PWAdsVideoType)videoType;

@end

/**
 @Deprecated
 A `PWAdsVideoInterstitialAdDelegate` is needed to receive notifications about video ad status.
 */
__deprecated_msg("PWAdsVideoInterstitialAdDelegate has been deprecated.")
@protocol PWAdsVideoInterstitialAdDelegate <NSObject>

@required

/**
 Called when the adsLoader receives a video and is ready to play (required).
 
 @param videoAd The video ad that was loaded.
 */
- (void)pwVideoInterstitialAdDidLoad:(PWAdsVideoInterstitialAd *)videoAd;

/**
 Gets called when the video ad has finished playing and the screen returns to your app.
 
 @param videoAd The video ad that finished playing.
 */
- (void)pwVideoInterstitialAdDidFinish:(PWAdsVideoInterstitialAd *)videoAd;

/**
 Gets called if there are no ads to display.
 
 @param videoAd The video ad that failed to load.
 @param error The error string detailing why the video ad failed to play.
 */
- (void)pwVideoInterstitialAdDidFail:(PWAdsVideoInterstitialAd *)videoAd withErrorString:(NSString *)error;

@end
