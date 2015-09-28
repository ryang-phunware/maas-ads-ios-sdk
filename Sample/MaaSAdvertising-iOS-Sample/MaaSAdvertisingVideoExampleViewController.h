//
//  VideoInterstitialrViewController.h
//  PWAds-iOS-Sample
//
//  Created by Carl Zornes on 10/28/13.
//
//

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import <PWAdvertising/PWAds.h>

@interface MaaSAdvertisingVideoExampleViewController : UIViewController<PWAdsVideoInterstitialAdDelegate>

@property (nonatomic, retain) IBOutlet UIButton     *adRequestButton;
@property (nonatomic, retain) PWAdsVideoInterstitialAd *videoAd;

- (IBAction)onRequestAds;
@end
