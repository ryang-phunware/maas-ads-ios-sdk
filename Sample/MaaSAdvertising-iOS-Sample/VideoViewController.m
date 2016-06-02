//
//  VideoViewController.m
//  PWAdvertising
//
//  Created by Hari Kunwar on 4/16/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "VideoViewController.h"
#import <PWAdvertising/PWAdsVideoAd.h>
#import <PWAdvertising/PWAdsVideoInterstitial.h>
#import <PWAdvertising/PWAdsRequest.h>

// Example zone id, don't use this in your app!
static NSString * const kZoneIDVideo =  @"22219";

@interface VideoViewController () <PWAdsVideoInterstitialDelegate>

@end

@implementation VideoViewController {
    PWAdsVideoInterstitial *_videoInterstitial;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create PWAdsVideoInterstitial instance
    _videoInterstitial = [PWAdsVideoInterstitial new];
    _videoInterstitial.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loadButtonPressed:(id)sender {
    // Create ad request instance
    PWAdsRequest *adsRequest = [PWAdsRequest requestWithZoneID:kZoneIDVideo];
    
    // Set test mode for request. This will fetch test ads.
    adsRequest.testMode = YES;
    
    // Load video ads request
    [_videoInterstitial loadAdsRequest:adsRequest];
}

#pragma mark - PWAdsVideoInterstitialDelegate

// Called when the adsLoader receives a video and is ready to play (required).
- (void)videoInterstitialDidLoadAd:(PWAdsVideoInterstitial *)videoInterstitial {
    NSLog(@"videoInterstitialDidLoadAd:");
    
    // Video ad is loaded. Now present the video interstitial.
    [_videoInterstitial presentFromViewController:self];
}

// Called when a video interstitial fails to load ad.
- (void)videoInterstitial:(PWAdsVideoInterstitial *)videoInterstitial didFailError:(NSError *)error {
    NSLog(@"videoInterstitial:didFailError:");
}

// Called before video interstitial dismisses video modal.
- (void)videoInterstitialWillDismissModal:(PWAdsVideoInterstitial *)videoInterstitial {
    NSLog(@"videoInterstitialWillDismissModal:");
}

// Called after video interstitial dismisses video modal.
- (void)videoInterstitialDidDismissModal:(PWAdsVideoInterstitial *)videoInterstitial {
    NSLog(@"videoInterstitialDidDismissModal:");
}

@end
