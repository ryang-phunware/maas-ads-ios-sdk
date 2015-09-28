//
//  VideoInterstitialrViewController.m
//  PWAds-iOS-Sample
//
//  Created by Carl Zornes on 10/28/13.
//
//

#import "MaaSAdvertisingVideoExampleViewController.h"
#import <PWAdvertising/PWAds.h>

//*************************************
// Replace with your valid ZONE_ID here.
#define ZONE_ID @"59219" // for example use only, don't use this zone in your app!

@interface MaaSAdvertisingVideoExampleViewController ()

@end

@implementation MaaSAdvertisingVideoExampleViewController

@synthesize videoAd = _videoAd;

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
    _videoAd = [[PWAdsVideoInterstitialAd alloc] init];
    _videoAd.delegate = self;
    
    //Optional... override the presentingViewController (defaults to the delegate)
    //_videoAd.presentingViewController = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestAds {    
    // Create an adsRequest object and request ads from the ad server with your own ZONE_ID
    
    PWAdsVideoAdsRequest *request = [PWAdsVideoAdsRequest requestWithAdZone:ZONE_ID];
    [request setCustomParameter:@"522003" forKey:@"cid"];
    
    [_videoAd requestAdsWithRequestObject:request];
    
    //If you want to specify the type of video ad you are requesting, use the call below.
    //[_videoAd requestAdsWithRequestObject:request andVideoType:PWAdsVideoTypeMidroll];
}

- (IBAction)onRequestAds {
    [self requestAds];
}

- (void)pwVideoInterstitialAdDidFinish:(PWAdsVideoInterstitialAd *)videoAd {
    NSLog(@"Override point for resuming your app's content.");
    [_videoAd unloadAdsManager];
}

- (void)viewDidUnload {
    [_videoAd unloadAdsManager];
    [super viewDidUnload];
}

- (void)pwVideoInterstitialAdDidLoad:(PWAdsVideoInterstitialAd *)videoAd {
    NSLog(@"We received an ad... now show it.");
    [videoAd playVideoFromAdsManager];
}

- (void)pwVideoInterstitialAdDidFail:(PWAdsVideoInterstitialAd *)videoAd withErrorString:(NSString *)error {
    NSLog(@"%@", error);
}
@end
