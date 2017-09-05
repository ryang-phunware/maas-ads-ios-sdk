//
//  PWAdsLandingPage.h
//  PWAdvertising
//
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PWAdsRequest;
@protocol PWAdsLandingPageDelegate;

/**
 Class for loading and presenting landingPage advertisments.
 */
@interface PWAdsLandingPage : NSObject

/// The delegate that implements PWAdsLandingPageDelegate protocol.
@property (nonatomic, weak) id<PWAdsLandingPageDelegate> delegate;

/// The current ad request object.
@property (nonatomic, readonly) PWAdsRequest *currentAdsRequest;

/**
 Request landingPage ads using PWAdsRequest instance.
 
 @param request The object with zone id, location and other ad information.
 */
- (void)loadAdsRequest:(PWAdsRequest *)request;

/**
 Called to present full screen landingPage advertisment.
 
 @param contoller The view controller from which the ad should be displayed.
 @discussion This method should be called only after landingPage advertisment is loaded.
 */
- (void)presentFromViewController:(UIViewController *)contoller;

@end


/**
 A `PWAdsLandingPageDelegate` is needed to receive callbacks about banner ad status.
 */
@protocol PWAdsLandingPageDelegate <NSObject>

@optional

/**
 Called when a new advertisement is loaded.
 
 @param landingPageAd The ad object that loaded a new advertisement.
 @discussion landingPage ad should be presented here by calling presentFromViewController: method.
 */
- (void)landingPageDidLoadAd:(PWAdsLandingPage *)landingPageAd;

/**
 Called when an landingPage fails to load advertisement.
 
 @param landingPage The full-screen ad that received the error.
 @param error The error object that describes the problem.
 @discussion Although the error message informs your application about why the error occurred, your application normally does not need to display the error to the user.
 */
- (void)landingPage:(PWAdsLandingPage *)landingPage didFailWithError:(NSError *)error;

/**
 Called after landingPage ad is presented.
 
 @param landingPageAd The full-screen ad that is presented.
 */
- (void)landingPageDidPresentModal:(PWAdsLandingPage *)landingPageAd;

/**
 Called before landingPage ad is dissmissed.
 
 @param landingPageAd The full-screen ad that will dismiss.
 */
- (void)landingPageWillDismissModal:(PWAdsLandingPage *)landingPageAd;

/**
 Called after landingPage ad has been dismissed
 
 @param landingPageAd The full-screen ad that was dismissed.
 */
- (void)landingPageDidDismissModal:(PWAdsLandingPage *)landingPageAd;

/**
 Called before user leaves the application. This happens when user taps on an advertisment.
 
 @param landingPage The full-screen ad that the user tapped.
 @return Return YES to allow user to leave the appliction; NO to prevent it. YES by default.
 */
- (BOOL)shouldLeaveApplicationForlandingPage:(PWAdsLandingPage *)landingPage;

@end
