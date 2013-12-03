//
//  MaaSAdvertisingSecondViewController.m
//  MaaSAdvertising-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import "MaaSAdvertisingAppDelegate.h"
#import "MaaSAdvertisingInterstitialExampleViewController.h"
#import <MaaSAdvertising/PWAds.h>

// This is the zone id for the Interstitial Example
// go to http://ads.tapit.com/ to get yours
#define ZONE_ID @"7271"

@interface MaaSAdvertisingInterstitialExampleViewController ()

@end

@implementation MaaSAdvertisingInterstitialExampleViewController

@synthesize activityIndicator;
@synthesize loadButton;
@synthesize showButton;
@synthesize interstitialAd;

- (void)viewDidLoad {
    [super viewDidLoad];
    [showButton setHidden:TRUE];
}

- (void)updateUIWithState:(ButtonState)state {
    [loadButton setEnabled:(state != StateLoading)];
    [showButton setHidden:(state != StateReady)];
    [activityIndicator setHidden:(state != StateLoading)];
}

- (IBAction)loadInterstitial:(id)sender {
    self.interstitialAd = [[PWAdsInterstitialAd alloc] init];
    self.interstitialAd.delegate = self;
    self.interstitialAd.animated = YES;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            @"test", @"mode", // enable test mode to test banner ads in your app
                            nil];
    PWAdsRequest *request = [PWAdsRequest requestWithAdZone:ZONE_ID andCustomParameters:params];
    MaaSAdvertisingAppDelegate *myAppDelegate = (MaaSAdvertisingAppDelegate *)([[UIApplication sharedApplication] delegate]);
    [request updateLocation:myAppDelegate.locationManager.location];
    [self.interstitialAd loadInterstitialForRequest:request];
}

- (IBAction)showInterstitial:(id)sender {
    [self.interstitialAd presentFromViewController:self];
}

#pragma mark -
#pragma mark PWAdsInterstitialAdDelegate methods

- (void)pwInterstitialAd:(PWAdsInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error.localizedDescription);
    [self updateUIWithState:StateError];
}

- (void)pwInterstitialAdDidUnload:(PWAdsInterstitialAd *)interstitialAd {
    NSLog(@"Ad did unload");
    self.interstitialAd = nil; // don't reuse interstitial ad!
    [self updateUIWithState:StateNone];
}

- (void)pwInterstitialAdWillLoad:(PWAdsInterstitialAd *)interstitialAd {
    NSLog(@"Ad will load");
}

- (void)pwInterstitialAdDidLoad:(PWAdsInterstitialAd *)interstitialAd {
    NSLog(@"Ad did load");
    [self updateUIWithState:StateReady];
}

- (BOOL)pwInterstitialAdActionShouldBegin:(PWAdsInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave {
    NSLog(@"Ad action should begin");
    return YES;
}

- (void)pwInterstitialAdActionDidFinish:(PWAdsInterstitialAd *)interstitialAd {
    NSLog(@"Ad action did finish");
}
@end