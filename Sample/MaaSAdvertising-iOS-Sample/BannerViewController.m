//
//  BannerViewController.m
//  PWAdvertising
//
//  Created on 4/15/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "BannerViewController.h"
#import <PWAdvertising/PWAdsBannerView.h>
#import <PWAdvertising/PWAdsRequest.h>

// Example zone id, don't use this in your app!
static NSString * const kZoneID =  @"7268";

@interface BannerViewController () <PWAdsBannerViewDelegate>

@end

@implementation BannerViewController {
    __weak IBOutlet PWAdsBannerView *_bannerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bannerView.delegate = self;
}

- (IBAction)loadButtonPressed:(id)sender {
    // Create ad request with the specified Zone ID.
    PWAdsRequest *adsRequest = [PWAdsRequest requestWithZoneID:kZoneID];
    
    // Set test mode for request. This will fetch test ads.
    adsRequest.testMode = YES;
    
    // Load the ad created request from the banner view.
    [_bannerView loadAdsRequest:adsRequest];
}

#pragma mark - PWAdsBannerViewDelegate methods

// Called when a new banner advertisement is loaded.
- (void)bannerViewDidLoadAd:(PWAdsBannerView *)bannerView {
    NSLog(@"bannerViewDidLoadAd");
}

//  Called when a banner view fails to load a new advertisement.
- (void)bannerView:(PWAdsBannerView *)bannerView didFailWithError:(NSError *)error {
    NSLog(@"bannerView:didFailWithError:");
}

// Called before a banner view dismisses a modal.
- (void)bannerViewWillDissmissModal:(PWAdsBannerView *)bannerView {
    NSLog(@"bannerViewWillDissmissModal:");
}

// Called after a banner view dismissed a modal view.
- (void)bannerViewDidDismissModal:(PWAdsBannerView *)bannerView {
    NSLog(@"bannerViewDidDismissModal:");
}

// Called before an advertisment modal is presented. This happens when use taps on an advertisment.
- (BOOL)shouldPresentModalForBannerView:(PWAdsBannerView *)bannerView {
    NSLog(@"shouldPresentModalForBannerView:");
    return YES;
}

// Called before an advertisment modal is presented. This happens when use taps on an advertisment.
- (void)bannerViewWillPresentModal:(PWAdsBannerView *)bannerView;
{
    NSLog(@"bannerViewWillPresentModal");
}

// Called after an advertisment modal is presented. This happens when use taps on an advertisment.
- (void)bannerViewDidPresentModal:(PWAdsBannerView *)bannerView;
{
    NSLog(@"bannerViewDidPresentModal:");
}

// Called before user leaves the application. This happens when user taps on an advertisment.
- (BOOL)shouldLeaveApplicationForBannerView:(PWAdsBannerView *)bannerView {
    NSLog(@"shouldLeaveApplicationForBannerView:");
    return YES;
}

@end
