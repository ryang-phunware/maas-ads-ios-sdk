//
//  RewardedVideoViewController.m
//  PWAdvertising
//
//  Created on 9/21/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "RewardedVideoViewController.h"
#import <PWAdvertising/PWAdsVideoAd.h>
#import <PWAdvertising/PWAdsRewardedVideo.h>
#import <PWAdvertising/PWAdsRequest.h>

// Example zone id, don't use this in your app!
static NSString *const kZoneIDVideo = @"78393";
static NSString *const kRVUserID = @"PWTestUser123";


@interface RewardedVideoViewController () <PWAdsRewardedVideoDelegate, UIAlertViewDelegate>
@property (nonatomic, assign) BOOL isRewardedVideoPreCached;
@end

@implementation RewardedVideoViewController {
    PWAdsRewardedVideo *_rewardedVideo;
    BOOL _RVAdIsLoaded;
    int _RVRemainingViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserver:self forKeyPath:@"isRewardedVideoPreCached" options:NSKeyValueObservingOptionNew context:NULL];
    
    // Create PWAdsRewardedVideo instance
    _rewardedVideo = [PWAdsRewardedVideo new];
    _rewardedVideo.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadButtonPressed:(id)sender {
    // Create ad request instance
    PWAdsRequest *adsRequest = [PWAdsRequest requestWithZoneID:kZoneIDVideo];
    
    // Set test mode for request. This will fetch test ads.
    // adsRequest.testMode = YES;
    
    // Load video ads request
    _RVAdIsLoaded = NO;
    self.isRewardedVideoPreCached = NO;
    [self loadAdsWithRequest:adsRequest];
}

#pragma mark - Load request;

- (void)loadAdsWithRequest:(PWAdsRequest *)adsRequest {
    if (_RVAdIsLoaded) {
        [self showOfferWallWithRemainingViews:_RVRemainingViews];
    }
    else {
        adsRequest.userID = kRVUserID;
        // Test additional data
        adsRequest.customData = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                @"rewardType": @"fuel",
                                                                                @"levelKind": @"amateur",
                                                                                @"points": @"13232321123124432430",
                                                                                @"userName": @"ASDasdsADasdasdasdsadasdadasdas",
                                                                                @"anotherKey": @"3ASDasdsADasdasdasdsadasdadasdas",
                                                                                @"anotherKey1": @"2ASDasdsADasdasdasdsadasdadasdas",
                                                                                @"anotherKey2": @"1ASDasdsADasdasdasdsadasdadasdas",
                                                                                @"anotherKey3": @"0ASDasdsADasdasdasdsadasdadasdas",
                                                                                }];
        [_rewardedVideo loadAdsRequest:adsRequest];
    }
}

#pragma mark - PWAdsVideoInterstitialDelegate

- (void)rewardedVideoDidLoadAd:(PWAdsRewardedVideo *)rewardedVideo withAdExtensionData:(NSDictionary *)adExtensionData {
    _RVAdIsLoaded = YES;
    NSLog(@"rewardedVideoDidLoadAd:withAdExtensionData:");
    if (adExtensionData && [adExtensionData objectForKey:@"remainingViews"]) {
        _RVRemainingViews = [[adExtensionData valueForKey:@"remainingViews"] intValue];
        [self showOfferWallWithRemainingViews:_RVRemainingViews];
    }
}

- (void)rewardedVideoDidFinishedPreCaching:(PWAdsRewardedVideo *)rewardedVideo withAdExtensionData:(NSDictionary *)adExtensionData {
    NSLog(@"rewardedVideoDidFinishedPreCaching:withAdExtensionData:");
    self.isRewardedVideoPreCached = YES;
}

- (void)rewardedVideo:(PWAdsRewardedVideo *)rewardedVideo didFailError:(NSError *)error withAdExtensionData:(NSDictionary *)adExtensionData{
    _RVAdIsLoaded = NO;
    NSLog(@"rewardedVideo:didFailError:withAdExtensionData:");
    if (error.code == 557) {
        UIAlertView *offerWall = [[UIAlertView alloc] initWithTitle:@"Phunware"
                                                            message:@"Come back later to watch more Rewarded Videos."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [offerWall show];
    }
}

- (void)rewardedVideoDidEndPlaybackSuccessfully:(PWAdsRewardedVideo *)rewardedVideo withRVResponseObject:(NSDictionary *)customData andAdExtensionData:(NSDictionary *)adExtensionData{
    _RVAdIsLoaded = NO;
    NSLog(@"rewardedVideoDidEndPlaybackSuccessfully:withRVResponseObject:andAdExtensionData:");
    NSLog(@"customData:%@", customData);
    [[[UIAlertView alloc] initWithTitle:@"PWAdvertising" message:[NSString stringWithFormat:@"Congratulations \n"
                                                                  "You’ve Earned %@ %@ \n"
                                                                  "You now have %@ remaining views", [customData valueForKey:@"amount"], [customData valueForKey:@"currencyID"], [customData valueForKey:@"remainingViews"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

#pragma mark - NSString helper method

- (NSString *)stringOutputForDictionary:(NSDictionary *)inputDict {
    NSString *str = [NSString stringWithFormat:@"%@", inputDict];
    
    return str;
}

#pragma mark - Offer Wall

- (void)showOfferWallWithRemainingViews:(int)remainingViews {
    UIAlertController *offerWall = [UIAlertController alertControllerWithTitle:@"Phunware"
                                                                       message:[NSString stringWithFormat:@"You have %i Remaining views. Press OK to see the Rewarded Video.", remainingViews]
                                                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_rewardedVideo presentFromViewController:self];
    }];
    if (!self.isRewardedVideoPreCached) {
        [ok setEnabled:NO];
    }
    
    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
    
    [offerWall addAction:ok];
    [offerWall addAction:dismiss];
    
    [self presentViewController:offerWall animated:YES completion:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"isRewardedVideoPreCached"]) {
        if (self.presentedViewController) {
            if ([self.presentedViewController isKindOfClass:[UIAlertController class]]) {
                UIAlertController *alert = (UIAlertController *)self.presentedViewController;
                [alert.actions.firstObject setEnabled:YES];
            }
        }
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"isRewardedVideoPreCached"];
}

@end
