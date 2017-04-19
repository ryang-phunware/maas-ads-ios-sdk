//
//  InterstitialViewController.m
//  PWAdvertising
//
//  Created on 4/16/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "InterstitialViewController.h"
#import <PWAdvertising/PWAdsInterstitial.h>
#import <PWAdvertising/PWAdsRequest.h>

// Example zone id, don't use this in your app!
static NSString * const kZoneID =  @"7271";

@interface InterstitialViewController () <PWAdsInterstitialDelegate>

@end

@implementation InterstitialViewController {
    PWAdsInterstitial *_interstitial;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create PWAdsInterstitial instance
    _interstitial = [PWAdsInterstitial new];
    _interstitial.delegate = self;
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
    
    // Load the ad created request from the interstitial view.
    [_interstitial loadAdsRequest:adsRequest];
}

#pragma mark -  PWAdsInterstitialDelegate

//  Called when a new advertisement is loaded.
- (void)interstitialDidLoadAd:(PWAdsInterstitial *)interstitialAd {
    NSLog(@"interstitialDidLoadAd:");
    
    // Interstitial ad is loaded. Now present the interstitial.
    [_interstitial presentFromViewController:self];
}

//  Called when an interstitial fails to load advertisement.
- (void)interstitial:(PWAdsInterstitial *)interstitial didFailWithError:(NSError *)error {
    NSLog(@"interstitial:didFailWithError:");
}

// Called before interstitial ad is dissmissed.
- (void)interstitialWillDismissModal:(PWAdsInterstitial *)interstitialAd {
    NSLog(@"interstitialWillDismissModal:");
}

// Called after Interstitial ad has been dismissed.
- (void)interstitialDidDismissModal:(PWAdsInterstitial *)interstitialAd {
    NSLog(@"interstitialDidDismissModal:");
}

// Called before user leaves the application. This happens when user taps on an advertisment.
- (BOOL)shouldLeaveApplicationForInterstitial:(PWAdsInterstitial *)interstitial {
    NSLog(@"shouldLeaveApplicationForInterstitial:");
    return YES;
}

@end
