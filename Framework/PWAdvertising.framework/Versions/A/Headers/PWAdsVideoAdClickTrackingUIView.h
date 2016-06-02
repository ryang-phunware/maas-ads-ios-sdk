//
//  PWAdsVideoAdClickTrackingUIView.h
//  Video Ads SDK
//
//  Created by Kevin Truong on 4/30/13.
//
//  Declares PWAdsVideoAdClickTrackingUIView instance that is set to track clicks on the
//  ad. Also defines a delegate protocol for click tracking view to get
//  clicks from the view.
//

#import <UIKit/UIKit.h>

#pragma mark PWAdsVideoAdClickTrackingUIViewDelegate

@protocol PWAdsVideoAdClickTrackingUIViewDelegate;

/**
 @Deprecated
 A UIView instance that is used as the click tracking element.
 
 In order for the SDK to track clicks on the ad, a transparent click tracking
 should be added on the video player and should be added as the tracking
 element by setting click tracking view on PWAdsVideoManager.
 */
__deprecated_msg("PWAdsVideoAdClickTrackingUIView has been deprecated.")
@interface PWAdsVideoAdClickTrackingUIView : UIView <UIGestureRecognizerDelegate>

/// Delegate object that receives touch notifications.
//
/// The caller should implement PWAdsVideoAdClickTrackingUIViewDelegate to get touch
/// events from the view. Remember to nil the delegate before deallocating
/// this object.
@property (nonatomic, weak) id<PWAdsVideoAdClickTrackingUIViewDelegate> delegate;

@end


/**
 Delegate protocol for PWAdsVideoAdClickTrackingUIView.
 
 The publisher can adopt this protocol to receive touch events from the
 PWAdsVideoAdClickTrackingUIView instance.
 */
__deprecated_msg("PWAdsVideoAdClickTrackingUIViewDelegate has been deprecated.")
@protocol PWAdsVideoAdClickTrackingUIViewDelegate

@required
/**
 Received when the user touched the click tracking view.
 */
- (void)clickTrackingView:(PWAdsVideoAdClickTrackingUIView *)view
     didReceiveTouchEvent:(UIEvent *)event;

@end
