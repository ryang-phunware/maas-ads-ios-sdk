//
//  MediumRectViewController.m
//  PWAdvertising
//
//  Created by Hari Kunwar on 4/17/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "MediumRectViewController.h"
#import <PWAdvertising/PWAdsBannerView.h>
#import <PWAdvertising/PWAdsRequest.h>

// Example Zone ID
static NSString * const kZoneID =  @"7270"; // for example use only, don't use this zone in your app!

@interface MediumRectViewController () <PWAdsBannerViewDelegate>

@end

@implementation MediumRectViewController {
    __weak IBOutlet PWAdsBannerView *_mediumRectView;
    NSString *_zoneId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _zoneId = kZoneID;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadButtonPressed:(id)sender {
    _mediumRectView.hidden = NO;

    _mediumRectView.delegate = self;
    
    // Create ad request with the specified Zone ID.
    PWAdsRequest *adsRequest = [PWAdsRequest requestWithZoneID:_zoneId];
    
    // Load the ad created request from the banner view.
    [_mediumRectView loadAdsRequest:adsRequest];
}


#pragma mark - PWAdsBannerViewDelegate methods

// Called when a new banner advertisement is loaded.
- (void)bannerViewDidLoadAd:(PWAdsBannerView *)bannerView {
    NSLog(@"bannerViewDidLoadAd");
}

// Called when a banner view fails to load a new advertisement.
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

// Called before user leaves the application. This happens when user taps on an advertisment.
- (BOOL)shouldLeaveApplicationForBannerView:(PWAdsBannerView *)bannerView {
    NSLog(@"shouldLeaveApplicationForBannerView:");
    return YES;
}

@end
