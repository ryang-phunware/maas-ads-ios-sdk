//
//  PWAdsNativeAdController.h
//  PWAdvertising
//
//  Created by Hari Kunwar on 4/21/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PWAdsNativeAd;
@class PWAdsRequest;
@protocol PWAdsNativeAdControllerDelegate;

@interface PWAdsNativeAdController : NSObject

/// The delegate that implements PWAdsNativeAdControllerDelegate protocol.
@property (nonatomic, weak) id<PWAdsNativeAdControllerDelegate> delegate;

/// The view controller to present modal from.
@property (nonatomic, weak) UIViewController *viewControllerForPresentingModal;

/**
 Request Interstitial ads using PWAdsRequest instance.
 
 @param request The object with zone id, location and other ad information.
 */
- (void)loadAdsRequest:(PWAdsRequest *)request;

/**
 Native ad was tapped by user.
 
 @param nativeAd The native ad that was touched.
 */
- (void)nativeAdTapped:(PWAdsNativeAd *)nativeAd;

/**
 Report when native ad is shown to user.
 
 @param nativeAd The native ad that was touched.
 */
- (void)reportAdImpression:(PWAdsNativeAd *)nativeAd;

@end

/**
 `PWAdsNativeAdDelegate` is needed to receive notifications about native ad status.
 */
@protocol PWAdsNativeAdControllerDelegate <NSObject>
@optional

/**
 Called when a new native advertisement is loaded.
 
 @param nativeAdManager The native ad manager that was downloaded.
 */
- (void)nativeAdControllerDidLoadAds:(NSArray *)nativeAds;

/**
 Called when a native advertisement fails to load.
 
 @param nativeAdManager The native ad manager that failed to load.
 @param error The error object that describes the problem.
 */
- (void)nativeAdController:(PWAdsNativeAdController *)controller didFailWithError:(NSError *)error;

/**
 Called before a native ad dismisses a modal.
 
 @param bannerView The banner view that will finish executing an action.
 */
- (void)nativeAdControllerWillDissmissModal:(PWAdsNativeAdController *)controller;

/**
 Called after a native ad dismissed a modal view.
 
 @param bannerView The banner view that finished executing an action.
 */
- (void)nativeAdControllerDidDismissModal:(PWAdsNativeAdController *)controller;

/**
 Called before an advertisment modal is presented. This happens when use taps on an advertisment.
 
 @param bannerView The banner view that the user tapped.
 @return Your delegate returns YES if the banner action should execute; NO to prevent the banner action from executing.
 */
- (BOOL)shouldPresentModalForNativeAdController:(PWAdsNativeAdController *)controller;

/**
 Called before user leaves the application. This happens when user taps on an advertisment.
 
 @param bannerView The banner view that the user tapped.
 @return Your delegate returns YES if the banner action should execute; NO to prevent the banner action from executing.
 */
- (BOOL)shouldLeaveApplicationForNativeAdController:(PWAdsNativeAdController *)controller;

@end
