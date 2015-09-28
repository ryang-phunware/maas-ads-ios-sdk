//
//  MaaSAdvertisingFirstViewController.h
//  MaaSAdvertising-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <PWAdvertising/PWAds.h>

@interface MaaSAdvertisingBannerExampleViewController : UIViewController<PWAdsBannerAdViewDelegate>

@property (retain, nonatomic) PWAdsBannerAdView *pwAd;

@end
