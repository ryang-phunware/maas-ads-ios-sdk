//
//  MaaSAdvertisingNativeExampleViewController.h
//  PWAds-iOS-Sample
//
//  Created by Carl Zornes on 12/17/14.
//  Copyright (c) 2014 Phunware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <PWAdvertising/PWAds.h>

@interface MaaSAdvertisingNativeExampleViewController : UIViewController <PWAdsNativeAdDelegate, UITableViewDelegate, UITableViewDataSource> {
    
    NSArray *offices;
    NSIndexPath *currentIndexPath;
    IBOutlet UITableView *customTable;
    BOOL didGetAd;
}

@property (nonatomic, retain) PWAdsNativeAdManager *pwNativeManager;

@end
