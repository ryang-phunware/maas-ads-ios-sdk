//
//  PWAdsBannerView.h
//  PWAdvertising
//
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PWAdsRequest;
@protocol PWAdsBannerViewDelegate;

/**
 *  Available banner animation transitions.
 */
typedef NS_ENUM(NSUInteger, PWAdsBannerAnimationTransition) {
    /**
     *  Banner animation transition none.
     */
    PWAdsBannerAnimationTransitionNone = 0,
    /**
     *  Banner animation transition Random.
     */
    PWAdsBannerAnimationTransitionRandom,
    /**
     *  Banner animation transition 3D rotation.
     */
    PWAdsBannerAnimationTransition3DRotation,
    /**
     *  Banner animation transition Curl Up.
     */
    PWAdsBannerAnimationTransitionCurlUp,
    /**
     *  Banner animation transition Curl Down.
     */
    PWAdsBannerAnimationTransitionCurlDown,
    /**
     *  Banner animation transition Flip from left.
     */
    PWAdsBannerAnimationTransitionFlipFromLeft,
    /**
     *  Banner animation transition Flip from right.
     */
    PWAdsBannerAnimationTransitionFlipFromRight,
};

/**
 Class for loading and displaying banner advertisments.
 */
@interface PWAdsBannerView : UIView

/// The delegate that implements PWAdsBannerViewDelegate protocol.
@property (nonatomic, weak) id<PWAdsBannerViewDelegate> delegate;

/// Whether the ad will load with animation. The default value is TRUE.
@property (nonatomic, assign) BOOL loadAnimated;

///The banner animation transition. The default value is PWAdsBannerAnimationTransitionNone.
@property (nonatomic, assign)PWAdsBannerAnimationTransition bannerAnimationTransition;

/// Whether to show loading overlay when ad is tapped. The default value is TRUE.
@property (nonatomic, assign) BOOL showLoadingOverlay;

/// The view controller to present modal from.
@property (nonatomic, weak) UIViewController *viewControllerForPresentingModal;

/// The current ad request object.
@property (nonatomic, readonly) PWAdsRequest *currentAdsRequest;

/**
 Request Ads passing PWAdsRequest object.
 
 @param request The object with zone id, location and other ad information.
 */
- (void)loadAdsRequest:(PWAdsRequest *)request;

@end


/**
 Protocol PWAdsBannerViewDelegate declares delegate methods for receiving callbacks from PWAdsBannerView.
 */
@protocol PWAdsBannerViewDelegate <NSObject>
@optional

/**
 Called when a new banner advertisement is loaded.
 
 @param bannerView The banner view that loaded a new advertisement.
 */
- (void)bannerViewDidLoadAd:(PWAdsBannerView *)bannerView;

/**
 Called when a banner view fails to load a new advertisement.
 
 @param bannerView The banner view that failed to load an advertisement.
 @param error The error object that describes the problem.
 */
- (void)bannerView:(PWAdsBannerView *)bannerView didFailWithError:(NSError *)error;

/**
 Called before an advertisment modal is presented
 
 @param bannerView The banner view that was tapped by user.
 */
- (void)bannerViewWillPresentModal:(PWAdsBannerView *)bannerView;

/**
 Called after an advertisment modal is presented
 
 @param bannerView The banner view that was tapped by user.
 */
- (void)bannerViewDidPresentModal:(PWAdsBannerView *)bannerView;

/**
 Called before a banner view dismisses a modal.
 
 @param bannerView The banner view that will finish executing an action.
 */
- (void)bannerViewWillDissmissModal:(PWAdsBannerView *)bannerView;

/**
 Called after a banner view dismissed a modal view.
 
 @param bannerView The banner view that finished executing an action.
 */
- (void)bannerViewDidDismissModal:(PWAdsBannerView *)bannerView;

/**
 Called before an advertisment modal is presented. This happens when use taps on an advertisment.
 
 @param bannerView The banner view that the user tapped.
 @return Your delegate returns YES if the banner action should execute; NO to prevent the executing.
 */
- (BOOL)shouldPresentModalForBannerView:(PWAdsBannerView *)bannerView;

/**
 Called before user leaves the application. This happens when user taps on an advertisment.
 
 @param bannerView The banner view that the user tapped.
 @return Return YES to allow user to leave the appliction; NO to prevent it. YES by default.
 */
- (BOOL)shouldLeaveApplicationForBannerView:(PWAdsBannerView *)bannerView;

@end



