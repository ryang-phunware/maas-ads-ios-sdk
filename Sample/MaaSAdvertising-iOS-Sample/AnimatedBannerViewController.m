//
//  AnimationBannerViewController.m
//  PWAdvertising
//
//  Created by John Zhao on 5/5/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "AnimatedBannerViewController.h"
#import <PWAdvertising/PWAdsBannerView.h>
#import <PWAdvertising/PWAdsRequest.h>


static NSString * const kZoneID =  @"7268";// Example zone id, don't use this in your app!
static NSString *const kNoneAnimation = @"None";
static NSString *const kRandomAnimation = @"Random";
static NSString *const k3DRotationAnimation = @"3D Rotation";
static NSString *const kCurlUpAnimation = @"Curl Up";
static NSString *const kCurlDownAnimation = @"Curl Down";
static NSString *const kFlipFromLeftAnimation = @"Flip From Left";
static NSString *const kFlipFromRightAnimation = @"Flip From Right";


@interface AnimatedBannerViewController () <PWAdsBannerViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;
@end

@implementation AnimatedBannerViewController {
    __weak IBOutlet PWAdsBannerView *_bannerView;
    __weak IBOutlet UIPickerView *_pickerView;
    NSString *_selectedAnimationTransition;
    NSArray *_bannerAnimationTransitions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _bannerView.delegate = self;
    _bannerAnimationTransitions = @[kNoneAnimation,kRandomAnimation,k3DRotationAnimation,kCurlUpAnimation,kCurlDownAnimation,kFlipFromLeftAnimation,kFlipFromRightAnimation];
    _selectedAnimationTransition = kNoneAnimation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadAdsWithRequest:(PWAdsRequest *)adsRequest {
    _bannerView.delegate = self;
    [_bannerView loadAdsRequest:adsRequest];
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

// Called after a banner view dismisses a modal.
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

#pragma mark - config banner animation transition
-(void)configBannerAdTransationAnimation {
    _bannerView.loadAnimated = YES;
    if (_selectedAnimationTransition == kNoneAnimation) {
        _bannerView.bannerAnimationTransition = PWAdsBannerAnimationTransitionNone;
    }
    else if (_selectedAnimationTransition == kRandomAnimation) {
        _bannerView.bannerAnimationTransition = PWAdsBannerAnimationTransitionRandom;
    }
    else if (_selectedAnimationTransition == k3DRotationAnimation) {
        _bannerView.bannerAnimationTransition = PWAdsBannerAnimationTransition3DRotation;
    }
    else if (_selectedAnimationTransition == kCurlUpAnimation) {
        _bannerView.bannerAnimationTransition = PWAdsBannerAnimationTransitionCurlUp;
    }
    else if (_selectedAnimationTransition == kCurlDownAnimation) {
        _bannerView.bannerAnimationTransition = PWAdsBannerAnimationTransitionCurlDown;
    }
    else if (_selectedAnimationTransition == kFlipFromLeftAnimation) {
        _bannerView.bannerAnimationTransition = PWAdsBannerAnimationTransitionFlipFromLeft;
    }
    else if (_selectedAnimationTransition == kFlipFromRightAnimation) {
        _bannerView.bannerAnimationTransition = PWAdsBannerAnimationTransitionFlipFromRight;
    }
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _bannerAnimationTransitions.count;
}

#pragma  mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _bannerAnimationTransitions[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedAnimationTransition = _bannerAnimationTransitions [row];
    [self configBannerAdTransationAnimation];
}
@end

