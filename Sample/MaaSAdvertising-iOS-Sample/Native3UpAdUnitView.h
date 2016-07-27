//
//  Native3UpAdUnitView.h
//  PWAdvertising
//
//  Created by John Zhao on 4/29/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import <PWAdvertising/PWAdsNativeAdView.h>

typedef NS_ENUM(NSInteger,NativeAdHorizontalAligment) {
    NativeAdHorizontalAligmentCenter = 0,
    NativeAdHorizontalAligmentLeft = 1,
    NativeAdHorizontalAligmentRight = 2,
};

@interface Native3UpAdUnitView : UIView

@property (nonatomic, weak) id<PWAdsNativeAdViewDelegate> delegate;

-(void)show3UpAdUnit:(NSArray *)nativeAds layoutType:(NativeAdHorizontalAligment)aligment;

@end
