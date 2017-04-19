//
//  NativeIconAdUnitView.h
//  PWAdvertising
//
//  Created on 5/2/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import <PWAdvertising/PWAdsNativeAdView.h>

@interface NativeIconAdUnitView : UIView

@property (nonatomic, weak) id<PWAdsNativeAdViewDelegate> delegate;

-(void)showIconAdUnit:(NSArray *)nativeAds;

@end
