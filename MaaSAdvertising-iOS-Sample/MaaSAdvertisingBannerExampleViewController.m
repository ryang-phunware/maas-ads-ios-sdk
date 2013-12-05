//
//  MaaSAdvertisingFirstViewController.m
//  MaaSAdvertising-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import "MaaSAdvertisingAppDelegate.h"
#import "MaaSAdvertisingBannerExampleViewController.h"
#import <MaaSAdvertising/PWAds.h>

//*************************************
// Replace with your valid ZONE_ID here.
#define ZONE_ID @"7268" // for example use only, don't use this zone in your app!

@interface MaaSAdvertisingBannerExampleViewController ()

@end

@implementation MaaSAdvertisingBannerExampleViewController
@synthesize pwAd;

- (void)initBannerAdvanced {
    // init banner and add to your view
    if (!pwAd) {
        // don't re-define if we used IB to init the banner...
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            pwAd = [[PWAdsBannerAdView alloc] initWithFrame:CGRectMake(20, 89, 728, 90)];
        } else {
            pwAd = [[PWAdsBannerAdView alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
        }
        
        [self.view addSubview:self.pwAd];
    }

    self.pwAd.delegate = self;
    self.pwAd.showLoadingOverlay = YES;
    
    // set the parent controller for modal browser that loads when user taps ad
    //self.pwAd.presentingController = self; // only needed if tapping banner doesn't load modal browser properly
    
    // customize the request...
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            @"test", @"mode", // enable test mode to test banner ads in your app
                            nil];
    PWAdsRequest *request = [PWAdsRequest requestWithAdZone:ZONE_ID andCustomParameters:params];
    
    // this is how you enable location updates... NOTE: only enable if your app has a good reason to know the users location (Apple will reject your app if not)
    MaaSAdvertisingAppDelegate *myAppDelegate = (MaaSAdvertisingAppDelegate *)([[UIApplication sharedApplication] delegate]);
    [request updateLocation:myAppDelegate.locationManager.location];
    
    // kick off banner rotation!
    [self.pwAd startServingAdsForRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initBannerAdvanced];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.pwAd resume];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.pwAd pause];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    // notify banner of orientation changes
    [self.pwAd repositionToInterfaceOrientation:toInterfaceOrientation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark PWAdsBannerAdViewDelegate methods

- (void)pwBannerAdViewWillLoadAd:(PWAdsBannerAdView *)bannerView {
    NSLog(@"Banner is about to check server for ad...");
}

- (void)pwBannerAdViewDidLoadAd:(PWAdsBannerAdView *)bannerView {
    NSLog(@"Banner has been loaded...");
    // Banner view will display automatically if docking is enabled
    // if disabled, you'll want to show bannerView
}

- (void)pwBannerAdView:(PWAdsBannerAdView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Banner failed to load with the following error: %@", error);
    // Banner view will hide automatically if docking is enabled
    // if disabled, you'll want to hide bannerView
}

- (BOOL)pwBannerAdViewActionShouldBegin:(PWAdsBannerAdView *)bannerView willLeaveApplication:(BOOL)willLeave {
    NSLog(@"Banner was tapped, your UI will be covered up. %@", (willLeave ? @" !!LEAVING APP!!" : @""));
    // minimise app footprint for a better ad experience.
    // e.g. pause game, duck music, pause network access, reduce memory footprint, etc...
    return YES;
}

- (void)pwBannerAdViewActionWillFinish:(PWAdsBannerAdView *)bannerView {
    NSLog(@"Banner is about to be dismissed, get ready!");
    
}

- (void)pwBannerAdViewActionDidFinish:(PWAdsBannerAdView *)bannerView {
    NSLog(@"Banner is done covering your app, back to normal!");
    // resume normal app functions
}
@end