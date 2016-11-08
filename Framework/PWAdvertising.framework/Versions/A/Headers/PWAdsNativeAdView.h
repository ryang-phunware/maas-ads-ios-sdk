//
//  PWAdsNativeAdView.h
//  PWAdvertising
//
//  Created by Hari Kunwar on 4/21/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PWAdsNativeAd;
@protocol PWAdsNativeAdViewDelegate;

/**
 Base class for displaying native advertisement.
 */
@interface PWAdsNativeAdView : UIView

@property (nonatomic, weak) id<PWAdsNativeAdViewDelegate> delegate;

/// The nativeAd model
@property (nonatomic, strong) PWAdsNativeAd *nativeAd;

/// The view controller to present modal from.
@property (nonatomic, weak) UIViewController *viewControllerForPresentingModal;

/**
 Method to update the UIView to handle user interaction.
 
 @param adActionViews NSArray of UIView objects that will handle user interaction inside the PWAdsNativeAdView.
 */
- (void)updateAdActionViews:(NSArray *)adActionViews;

@end

/**
 `PWAdsNativeAdViewDelegate` is needed to receive notifications about native ad status.
 */
@protocol PWAdsNativeAdViewDelegate <NSObject>
@optional

/**
 Called before a native advertisment modal is presented.
 
 @param nativeAdView The native ad view that was tapped by user.
 */
- (void)nativeAdViewWillPresentModal:(PWAdsNativeAdView *)nativeAdView;

/**
 Called after a native advertisment modal is presented.
 
 @param nativeAdView The native ad view that was tapped by user.
 */
- (void)nativeAdViewDidPresentModal:(PWAdsNativeAdView *)nativeAdView;

/**
 Called before a native ad dismisses a modal.
 
 @param nativeAdView The native ad view that will finish executing an action.
 */
- (void)nativeAdViewWillDissmissModal:(PWAdsNativeAdView *)nativeAdView;

/**
 Called after a native ad dismissed a modal view.
 
 @param nativeAdView The native ad view view that finished executing an action.
 */
- (void)nativeAdViewDidDismissModal:(PWAdsNativeAdView *)nativeAdView;

/**
 Called before an advertisment modal is presented. This happens when use taps on an advertisment.
 
 @param nativeAdView The native ad view that the user tapped.
 @return Your delegate returns YES if the native ad action should execute; NO to prevent executing an action.
 */
- (BOOL)shouldPresentModalForNativeAdView:(PWAdsNativeAdView *)nativeAdView;

/**
 Called before user leaves the application. This happens when user taps on an advertisment.
 
 @param nativeAdView The native ad view view that the user tapped.
 @return Return YES to allow user to leave the appliction; NO to prevent it. YES by default.
 */
- (BOOL)shouldLeaveApplicationForNativeAdView:(PWAdsNativeAdView *)nativeAdView;

@end



