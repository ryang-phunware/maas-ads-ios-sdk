//
//  MaaSAdvertisingAdPromptExampleViewController.m
//  MaaSAdvertising-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import "MaaSAdvertisingAppDelegate.h"
#import "MaaSAdvertisingAdPromptExampleViewController.h"
#import <MaaSAdvertising/PWAds.h>

//*************************************
// Replace with your valid ZONE_ID here.
#define ZONE_ID @"7980" // for example use only, don't use this zone in your app!

@interface MaaSAdvertisingAdPromptExampleViewController ()

@end

@implementation MaaSAdvertisingAdPromptExampleViewController
@synthesize preloadButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark PWAdsAdPrompt Example code
- (void)simpleExample:(id)sender {
    PWAdsRequest *request = [PWAdsRequest requestWithAdZone:ZONE_ID];
    PWAdsAdPrompt *prompt = [[PWAdsAdPrompt alloc] initWithRequest:request];
    [prompt showAsAlert];
}


- (void)loadAdPrompt {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            @"test", @"mode", // enable test mode to test AdPrompts in your app
                            nil];
    PWAdsRequest *request = [PWAdsRequest requestWithAdZone:ZONE_ID andCustomParameters:params];
    MaaSAdvertisingAppDelegate *myAppDelegate = (MaaSAdvertisingAppDelegate *)([[UIApplication sharedApplication] delegate]);
    [request updateLocation:myAppDelegate.locationManager.location];
    pwAdPrompt = [[PWAdsAdPrompt alloc] initWithRequest:request];
    pwAdPrompt.delegate = self;
    pwAdPrompt.showLoadingOverlay = NO;
}

- (IBAction)preLoadAdPrompt:(id)sender {
    [self loadAdPrompt];
    [pwAdPrompt load];
}

- (IBAction)showAdPrompt:(id)sender {
    if (!pwAdPrompt) {
        [self loadAdPrompt];
    }
    
    [pwAdPrompt showAsAlert];
}

- (void)pwAdPrompt:(PWAdsAdPrompt *)adPrompt didFailWithError:(NSError *)error {
    NSLog(@"Error showing AdPrompt: %@", error);
    [self cleanupAdPrompt];
}

- (void)pwAdPromptWasDeclined:(PWAdsAdPrompt *)adPrompt {
    NSLog(@"AdPrompt was DECLINED!");
    [self cleanupAdPrompt];
}

- (void)pwAdPromptDidLoad:(PWAdsAdPrompt *)adPrompt {
    NSLog(@"AdPrompt loaded!");
    self.preloadButton.enabled = NO;
}

- (void)pwAdPromptWasDisplayed:(PWAdsAdPrompt *)adPrompt {
    NSLog(@"AdPrompt displayed!");
}

- (BOOL)pwAdPromptActionShouldBegin:(PWAdsAdPrompt *)adPrompt willLeaveApplication:(BOOL)willLeave {
    NSString *strWillLeave = willLeave ? @"Leaving app" : @"loading internally";
    NSLog(@"AdPrompt was accepted, loading app/advertisement... %@", strWillLeave);
    return YES;
}

- (void)pwAdPromptActionDidFinish:(PWAdsAdPrompt *)adPrompt {
    NSLog(@"AdPrompt Action finished!");
    [self cleanupAdPrompt];
}


- (void)cleanupAdPrompt {
    pwAdPrompt = nil;
    self.preloadButton.enabled = YES;
}

@end
