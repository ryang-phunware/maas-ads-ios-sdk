//
//  TapItMediationAdMob.m
//
//  Created by Nick Penteado on 8/24/12.
//  Copyright (c) 2012 Nick Penteado. All rights reserved.
//

#import "TapItMediationAdMob.h"
#import "GADAdSize.h"
#import <MaaSAdvertising/PWAds.h>

#define MEDIATION_STRING @"admob-1.0.1"

@implementation TapItMediationAdMob

@synthesize pwAd, pwInterstitial;

+ (NSString *)adapterVersion {
    return PWADS_VERSION;
}

+ (Class<GADAdNetworkExtras>)networkExtrasClass {
    return nil;
}

- (id)initWithGADMAdNetworkConnector:(id<GADMAdNetworkConnector>)c {
    self = [super init];
    if (self != nil) {
        connector = c;
        redirectCount = 0;
    }
    return self;
}

- (void)getInterstitial {
    pwInterstitial = [[PWAdsInterstitialAd alloc] init];
    pwInterstitial.delegate = self;
    pwInterstitial.showLoadingOverlay = NO;
    NSString *zoneId = [connector publisherId];
    PWAdsRequest *request = [PWAdsRequest requestWithAdZone:zoneId];
    [request setCustomParameter:MEDIATION_STRING forKey:@"mediation"];
    [pwInterstitial loadInterstitialForRequest:request];
}

- (void)getBannerWithSize:(GADAdSize)adSize {
    if (!GADAdSizeEqualToSize(adSize, kGADAdSizeBanner) &&
        !GADAdSizeEqualToSize(adSize, kGADAdSizeFullBanner) &&
        !GADAdSizeEqualToSize(adSize, kGADAdSizeLeaderboard) &&
        !GADAdSizeEqualToSize(adSize, kGADAdSizeMediumRectangle)) {
        NSString *errorDesc = [NSString stringWithFormat:
                               @"Invalid ad type %@, not going to get ad.",
                               NSStringFromGADAdSize(adSize)];
        NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                   errorDesc, NSLocalizedDescriptionKey, nil];
        NSError *error = [NSError errorWithDomain:@"ad_mediation"
                                             code:1
                                         userInfo:errorInfo];
        [self pwBannerAdView:nil didFailToReceiveAdWithError:error];
        return;
    }
    
    CGSize cgAdSize = CGSizeFromGADAdSize(adSize);
    CGRect adFrame = CGRectMake(0, 0, cgAdSize.width, cgAdSize.height);
    pwAd = [[PWAdsBannerAdView alloc] initWithFrame:adFrame];
    NSString *zoneId = [connector publisherId];
    pwAd.presentingController = [connector viewControllerForPresentingModalView];
//    pwAd.shouldReloadAfterTap = NO;
    pwAd.showLoadingOverlay = NO;
    PWAdsRequest *adRequest = [PWAdsRequest requestWithAdZone:zoneId];
    [adRequest setCustomParameter:@"999999" forKey:PWADS_PARAM_KEY_BANNER_ROTATE_INTERVAL]; // don't rotate banner
    [adRequest setCustomParameter:MEDIATION_STRING forKey:@"mediation"];
    pwAd.delegate = self;
    [pwAd startServingAdsForRequest:adRequest];
}

- (void)stopBeingDelegate {
    if(pwInterstitial) {
        pwInterstitial.delegate = nil;
    }
    
    if(pwAd) {
        pwAd.delegate = nil;
    }
}

- (BOOL)isBannerAnimationOK:(GADMBannerAnimationType)animType {
    return YES;
}

- (void)presentInterstitialFromRootViewController:(UIViewController *)rootViewController {
    [pwInterstitial presentFromViewController:rootViewController];
}

- (void)dealloc {
    [self stopBeingDelegate];
    [pwAd release], pwAd = nil;
    [pwInterstitial release], pwInterstitial = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark PWAdsBannerAdViewDelegate methods

- (void)pwBannerAdViewWillLoadAd:(PWAdsBannerAdView *)bannerView {
//    TILog(@"pwBannerAdViewWillLoadAd:");
    // no google equivilent... NOOP
}

- (void)pwBannerAdViewDidLoadAd:(PWAdsBannerAdView *)bannerView {
//    TILog(@"pwBannerAdViewDidLoadAd:");
    [connector adapter:self didReceiveAdView:bannerView];
}

- (void)pwBannerAdView:(PWAdsBannerAdView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
//    TILog(@"pwBannerAdView:didFailToReceiveAdWithError:");
    [connector adapter:self didFailAd:error];
}

- (BOOL)pwBannerAdViewActionShouldBegin:(PWAdsBannerAdView *)bannerView willLeaveApplication:(BOOL)willLeave {
//    TILog(@"pwBannerAdViewActionShouldBegin:willLeaveApplication:");
    if (redirectCount++ == 0) {
        // pwBannerAdViewActionShouldBegin:willLeaveApplication: may be called multiple times... only report one click/load...
        [connector adapter:self clickDidOccurInBanner:bannerView];
        [connector adapterWillPresentFullScreenModal:self];
    }
    if (willLeave) {
        [connector adapterWillLeaveApplication:self];
    }
    return YES;
}

- (void)pwBannerAdViewActionWillFinish:(PWAdsBannerAdView *)bannerView {
//    TILog(@"pwBannerAdViewActionWillFinish:");
    [connector adapterWillDismissFullScreenModal:self];
}

- (void)pwBannerAdViewActionDidFinish:(PWAdsBannerAdView *)bannerView {
//    TILog(@"pwBannerAdViewActionDidFinish:");
    [connector adapterDidDismissFullScreenModal:self];
}


#pragma mark -
#pragma mark PWAdsInterstitialAdDelegate methods

- (void)pwInterstitialAd:(PWAdsInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
//    TILog(@"pwInterstitialAd:didFailWithError:");
    [connector adapter:self didFailInterstitial:error];
}

- (void)pwInterstitialAdDidUnload:(PWAdsInterstitialAd *)interstitialAd {
    // no google equivilent... NOOP
    // see pwInterstitialAdActionWillFinish: and pwInterstitialAdActionDidFinish:
//    TILog(@"pwInterstitialAdDidUnload:");
}

- (void)pwInterstitialAdWillLoad:(PWAdsInterstitialAd *)interstitialAd {
    // no google equivilent... NOOP
    // see pwInterstitialAdDidLoad
//    TILog(@"pwInterstitialAdWillLoad:");
}

- (void)pwInterstitialAdDidLoad:(PWAdsInterstitialAd *)interstitialAd {
//    TILog(@"pwInterstitialAdDidLoad:");
    [connector adapter:self didReceiveInterstitial:interstitialAd];
}

- (BOOL)pwInterstitialAdActionShouldBegin:(PWAdsInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave {
//    TILog(@"pwInterstitialAdActionShouldBegin:willLeaveApplication:");
    if (redirectCount++ == 0) {
        [connector adapterWillPresentInterstitial:self];
    }
    if (willLeave) {
        [connector adapterWillLeaveApplication:self];
    }
    return YES;
}

- (void)pwInterstitialAdActionWillFinish:(PWAdsInterstitialAd *)interstitialAd {
//    TILog(@"pwInterstitialAdActionWillFinish:");
    [connector adapterWillDismissInterstitial:self];
}

- (void)pwInterstitialAdActionDidFinish:(PWAdsInterstitialAd *)interstitialAd {
//    TILog(@"pwInterstitialAdActionDidFinish:");
    [connector adapterDidDismissInterstitial:self];
}

@end
