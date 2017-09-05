//
//  PWAdsInterstitial.h
//  PWAdvertising
//
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PWAdsRequest;
@protocol PWAdsInterstitialDelegate;

/**
 Class for loading and presenting interstitial advertisments.
 */
@interface PWAdsInterstitial : NSObject 

/// The delegate that implements PWAdsInterstitialDelegate protocol.
@property (nonatomic, weak) id<PWAdsInterstitialDelegate> delegate;

/// The current ad request object.
@property (nonatomic, readonly) PWAdsRequest *currentAdsRequest;

/**
 Request Interstitial ads using PWAdsRequest instance.
 
 @param request The object with zone id, location and other ad information.
 */
- (void)loadAdsRequest:(PWAdsRequest *)request;

/**
 Called to present full screen interstitial advertisment.
 
 @param contoller The view controller from which the ad should be displayed.
 @discussion This method should be called only after interstitial advertisment is loaded.
 */
- (void)presentFromViewController:(UIViewController *)contoller;

@end


/**
 A `PWAdsInterstitialDelegate` is needed to receive callbacks about video interstitial ad status.
 */
@protocol PWAdsInterstitialDelegate <NSObject>

@optional

/**
 Called when a new advertisement is loaded.
 
 @param interstitialAd The ad object that loaded a new advertisement.
 @discussion Interstitial ad should be presented here by calling presentFromViewController: method.
 */
- (void)interstitialDidLoadAd:(PWAdsInterstitial *)interstitialAd;

/**
 Called when an interstitial fails to load advertisement.
 
 @param interstitial The full-screen ad that received the error.
 @param error The error object that describes the problem.
 @discussion Although the error message informs your application about why the error occurred, your application normally does not need to display the error to the user.
  */
- (void)interstitial:(PWAdsInterstitial *)interstitial didFailWithError:(NSError *)error;

/**
 Called after interstitial ad is presented.
 
 @param interstitialAd The full-screen ad that is presented.
 */
- (void)interstitialDidPresentModal:(PWAdsInterstitial *)interstitialAd;

/**
 Called before interstitial ad is dissmissed.
 
 @param interstitialAd The full-screen ad that will dismiss.
 */
- (void)interstitialWillDismissModal:(PWAdsInterstitial *)interstitialAd;

/**
 Called after Interstitial ad has been dismissed
 
 @param interstitialAd The full-screen ad that was dismissed.
 */
- (void)interstitialDidDismissModal:(PWAdsInterstitial *)interstitialAd;

/**
 Called before user leaves the application. This happens when user taps on an advertisment.
 
 @param interstitial The full-screen ad that the user tapped.
 @return Return YES to allow user to leave the appliction; NO to prevent it. YES by default.
 */
- (BOOL)shouldLeaveApplicationForInterstitial:(PWAdsInterstitial *)interstitial;

@end



