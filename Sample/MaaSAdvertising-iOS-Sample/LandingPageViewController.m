//
//  LandingPageViewController.m
//  PWAdvertising
//
//  Created on 5/25/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "LandingPageViewController.h"
#import <PWAdvertising/PWAdsLandingPage.h>
#import <PWAdvertising/PWAdsRequest.h>

// Example zone id, don't use this in your app!
static NSString * const kZoneID =  @"76663";

@interface LandingPageViewController () <PWAdsLandingPageDelegate>

@end

@implementation LandingPageViewController {
    PWAdsLandingPage *_landingPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create PWAdsLandingPage instance
    _landingPage = [PWAdsLandingPage new];
    _landingPage.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadButtonPressed:(id)sender {
    // Create ad request with the given zone id.
    PWAdsRequest *adsRequest = [PWAdsRequest requestWithZoneID:kZoneID];
    
    // Set test mode for request. This will fetch test ads.
    adsRequest.testMode = YES;
    
    // Load the ad created request from the LandingPage view.
    [_landingPage loadAdsRequest:adsRequest];
}

#pragma mark -  PWAdsLandingPageDelegate

//  Called when a new advertisement is loaded.
- (void)landingPageDidLoadAd:(PWAdsLandingPage *)LandingPageAd {
    NSLog(@"landingPageDidLoadAd:");
    
    // LandingPage ad is loaded. Now present the LandingPage.
    [_landingPage presentFromViewController:self];
}

//  Called when an LandingPage fails to load advertisement.
- (void)landingPage:(PWAdsLandingPage *)landingPage didFailWithError:(NSError *)error {
    NSLog(@"landingPage:didFailWithError:");
}

// Called before LandingPage ad is dissmissed.
- (void)landingPageWillDismissModal:(PWAdsLandingPage *)landingPageAd {
    NSLog(@"landingPageWillDismissModal:");
}

// Called after landingPage ad has been dismissed.
- (void)landingPageDidDismissModal:(PWAdsLandingPage *)landingPageAd {
    NSLog(@"landingPageDidDismissModal:");
}

// Called before user leaves the application. This happens when user taps on an advertisment.
-(BOOL)shouldLeaveApplicationForlandingPage:(PWAdsLandingPage *)landingPage {
    NSLog(@"shouldLeaveApplicationForLandingPage:");
    return YES;
}

@end
