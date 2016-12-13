MaaS Advertising iOS SDK
================

Version 3.5.1

Overview
------------
This is Phunware's iOS SDK for the MaaS Advertising module. Visit http://maas.phunware.com/ for more details and to sign up.



Getting Started
---------------

- [Download MaaS Advertising](https://github.com/phunware/maas-ads-ios-sdk/archive/master.zip) and run the included sample app.
- Continue reading below for installation and integration instructions.
- Be sure to read the [documentation](http://phunware.github.io/maas-ads-ios-sdk/) for additional details.



Installation
------------

The following frameworks are required:

````
PWCore.framework
SystemConfiguration.framework
QuartsCore.framework
CoreTelephony.framework
MessageUI.framework
EventKit.framework
EventKitUI.framework
CoreMedia.framework
AVFoundation.framework
MediaPlayer.framework
AudioToolbox.framework
WebKit.framework
AdSupport.framework - enable support for IDFA
StoreKit.framework - enable use of SKStoreProductViewController, displays app store ads without leaving your app
````

MaaS Advertising has a dependency on PWCore.framework, which is available here: https://github.com/phunware/maas-core-ios-sdk

It's recommended that you add the MaaS frameworks to the 'Vendor/Phunware' directory. This directory should contain PWCore.framework and PWAdvertising.framework, as well as any other MaaS frameworks that you are using.

**In the Build Settings for your target, you must include the following "Other Linker Flags:" -ObjC**

The following frameworks are optional:

````
CoreLocation.framework
````
CoreLocation is optional and is used for geo-targeting ads. Apple mandates that your app have a good reason for enabling location services and will deny your app if location is not a core feature for your app.

The following bundles are required:

````
PWAds.bundle
````

PWAds.bundle includes files needed for media-rich advertisements that make use of device-specific features. It is included with this sample app.



Integration
----------

The MaaS Advertising SDK allows developers to serve many types of ads, including banner, interstitial and video ads.

### Initialization

~~~~
// In your AppDelegate.m file:
#import <PWAdvertising/PWAdsAppTracker.h>
...

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    PWAdsAppTracker *appTracker = [PWAdsAppTracker sharedAppTracker];
    [appTracker reportApplicationOpen];
    return YES;
}
~~~~


### Banner Usage

~~~~
// In your .h file:
#import <PWAdvertising/PWAdsBannerView.h>
#import <PWAdvertising/PWAdsRequest.h>

@property (strong, nonatomic) PWAdsBannerView *pwAd;
...

// In your .m file:
- (void)viewDidLoad
{
    self.pwAd = [[PWAdsBannerView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [self.view addSubview:self.pwAd];

    ...

    // To animate the banner transition with 3D effect
    self.pwAd.loadAnimated = YES;
    self.pwAd.bannerAnimationTransition = PWAdsBannerAnimationTransition3DRotation;
    ...

    // To create adsRequest:
    PWAdsRequest *adsRequest = [PWAdsRequest requestWithZoneID:@"**YOUR ZONE ID**"];

    //To set customized parameters:
    [adsRequest setValue:@"**YOUR CREATE ID**" forKey:@"creativeID"];
    adRequest.testMode = YES;//set test mode,Default is NO.

    // To kick off banner rotation
    [self.pwAd loadAdsRequest:adsRequest]];
    ...
}

~~~~

### Interstitial Usage

~~~~
// In your .h file:
#import <PWAdvertising/PWAdsInterstitial.h>
#import <PWAdvertising/PWAdsRequest.h>
...

// Make sure your view controller conforms with 'PWAdsInterstitialDelegate'.
@interface InterstitialViewController () <PWAdsInterstitialDelegate>
...

@property (strong, nonatomic) PWAdsInterstitial *interstitialAd;
...

// In your .m file:
- (void)viewDidLoad
{
    self.interstitialAd = [PWAdsInterstitial new];
    self.interstitialAd.delegate = self;
    PWAdsRequest *request = [PWAdsRequest requestWithZoneID:@"**YOUR ZONE ID**"];
    [self.interstitialAd loadAdsRequest:request];
    ...
}

- (void)interstitialDidLoadAd:(PWAdsInterstitial *)interstitialAd
{
    [self.interstitialAd presentFromViewController:self];
}
~~~~

### Video Interstitial Ads Usage

~~~~  
// In your .h file:
#import <PWAdvertising/PWAdsVideoInterstitial.h>
#import <PWAdvertising/PWAdsRequest.h>
...

// Make sure your view controller conforms with 'PWAdsVideoInterstitialDelegate'.
@interface VideoViewController () <PWAdsVideoInterstitialDelegate>
...

@property (strong, nonatomic) PWAdsVideoInterstitial *videoInterstitial;
...

// In your .m file:
- (void)viewDidLoad
{
    self.videoInterstitial = [PWAdsVideoInterstitial new];
    self.videoInterstitial.delegate = self;
    ...
}

- (void)requestAds
{    
    PWAdsRequest *request = [PWAdsRequest requestWithZoneID:**YOUR ZONE ID**];
    [self.videoInterstitial loadAdsRequest:adsRequest];
}

- (IBAction)onRequestAds
{
    [self requestAds];
}

#pragma mark - PWAdsVideoInterstitialDelegate

- (void)videoInterstitialDidLoadAd:(PWAdsVideoInterstitial *)videoInterstitial
{
    NSLog(@"videoInterstitialDidLoadAd:");
    [self.videoInterstitial presentFromViewController:self];
}

- (void)videoInterstitial:(PWAdsVideoInterstitial *)videoInterstitial didFailError:(NSError *)error
{
    NSLog(@"videoInterstitial:didFailError:");
}

~~~~

### Rewarded Video Ads Usage

~~~~  
// In your .h file:
#import <PWAdvertising/PWAdsRewardedVideo.h>
#import <PWAdvertising/PWAdsRequest.h>
...

// Make sure your view controller conforms with 'PWAdsRewardedVideoDelegate'.
@interface RewardedVideoViewController () <PWAdsRewardedVideoDelegate>
...

@property (strong, nonatomic) PWAdsRewardedVideo *rewardedVideo;
...

// In your .m file:
- (void)viewDidLoad
{
    self.rewardedVideo = [PWAdsRewardedVideo new];
    self.rewardedVideo.delegate = self;
    ...
}

- (void)requestAds
{    
    PWAdsRequest *adsRequest = [PWAdsRequest requestWithZoneID:**YOUR ZONE ID**];
    [self.videoInterstitial loadAdsRequest:adsRequest];

    // Set User ID
    // You should identify each user with a single ID.
    adsRequest.userID = **CURRENT USER ID**;

    // Add custom data for the request
    // This custom data is going to be returned on playback susccess event
    adsRequest.customData = [NSMutableDictionary dictionaryWithDictionary:@{
        @"gameCustomKey1"   : @"gameCustomValue1",
        @"gameCustomKey2"    : @"gameCustomValue2"
    }];

    [self.rewardedVideo loadAdsRequest:adsRequest];
}

- (IBAction)onRequestAds
{
    [self requestAds];
}

#pragma mark - PWAdsRewardedVideoDelegate

- (void)rewardedVideoDidLoadAd:(PWAdsRewardedVideo *)rewardedVideo withAdExtensionData:(NSDictionary *)adExtensionData {
    NSLog(@"rewardedVideoDidLoadAd:withAdExtensionData:");
    [self.rewardedVideo presentFromViewController:self];
}

- (void)rewardedVideo:(PWAdsRewardedVideo *)rewardedVideo didFailError:(NSError *)error withAdExtensionData:(NSDictionary *)adExtensionData{
    NSLog(@"rewardedVideo:didFailError:withAdExtensionData");
}

- (void)rewardedVideoDidEndPlaybackSuccessfully:(PWAdsRewardedVideo *)rewardedVideo withRVResponseObject:(NSDictionary *)customData andAdExtensionData:(NSDictionary *)adExtensionData {
    NSLog(@"rewardedVideoDidEndPlaybackSuccessfully:withRVResponseObject:andAdExtensionData:");
    NSLog(@"customData: %@", customData);
    NSLog(@"adExtensionData: %@", adExtensionData);

}

~~~~

### Landing Page Usage

~~~~
// In your .h file:
#import <PWAdvertising/PWAdsLandingPage.h>
#import <PWAdvertising/PWAdsRequest.h>
...

// Make sure your view controller conforms with 'PWAdsLandingPageDelegate'.
@interface LandingPageViewController () <PWAdsLandingPageDelegate>
...

@property (strong, nonatomic) PWAdsLandingPage *landingPageAd;
...

// In your .m file:
- (void)viewDidLoad
{
    self.landingPageAd = [PWAdsLandingPage new];
    self.landingPageAd.delegate = self;
    PWAdsRequest *request = [PWAdsRequest requestWithZoneID:@"**YOUR ZONE ID**"];
    [self.landingPageAd loadAdsRequest:request];
    ...
}

- (void)landingPageDidLoadAd:(PWAdsLandingPage *)landingPageAd {

    [self.landingPageAd presentFromViewController:self];
}

~~~~

### Native Ad Usage

~~~~
// In your .h file:
#import <PWAdvertising/PWAdsNativeAdLoader.h>
#import <PWAdvertising/PWAdsRequest.h>
#import <PWAdvertising/PWAdsNativeAdView.h>

@interface MyViewController : UIViewController <PWAdsNativeAdLoaderDelegate>

@property (nonatomic, retain) PWAdsNativeAdLoader *nativeAdLoader;
...

// In your .m file:
...
_nativeAdLoader = [PWAdsNativeAdLoader new];
_nativeAdLoader.delegate = self;

// Create ad request with the specified Zone ID.
PWAdsRequest *adsRequest = [PWAdsRequest requestWithZoneID:@"**YOUR ZONE ID**"];
...
// You can set the number of ad object you want to request, default is 1.
adsRequest.numberOfAds = 3;
...
[_nativeAdLoader loadAdsRequest:adsRequest];

...

- (void)nativeAdLoaderDidLoadAds:(NSArray *)nativeAds {

    // nativeAds array is going to contain the numberOfAds you requested for if there are ads available for your request.

    // Once the native ads are loaded you can grab an item from nativeAds array and create a custom PWAdsNativeAdView.

    PWAdsNativeAd *newAd = [nativeAds lastObject]

    // Create new Native Ad View

    PWAdsNativeAdView *nativeView = (PWAdsNativeAdView *)[[PWAdsNativeAdView alloc] initWithFrame:CGRectMake(x,y,width,height)];
    nativeView.delegate = self;
    nativeView.nativeAd = newAd;
    adView = nativeView;

    // Get data from `newAd` and add fields to your view:

    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(startingPointX,10,300,20)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.userInteractionEnabled=YES;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.text = newAd.adTitle;
    [adView addSubview:titleLabel];

    ...

    // By default the whole PWAdsNativeAdView if enabled to user interaction. If you tap anywhere in the PWAdsNativeAdView it'd take you to the ad destination. If you want to customize this behaviour you can specify the views you want to enable for user interation in your PWAdsNativeAdView.

    [adView updateAdActionViews:@[titleLabel]];

    // Then only titleLabel view will react to user's interaction.

    ...

    // Inside the sample app code you are going to find a custom and clean sample of a PWAdsNativeAdView builder: NativeCleanAdUnitView.h

    NativeCleanAdUnitView *cleanAdView = [[NativeCleanAdUnitView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    cleanAdView.delegate = self;
    [cleanAdView showCleanAdUnit:newAd];
    [_adContainerView addSubview:cleanAdView];
}

- (void)nativeAdLoader:(PWAdsNativeAdLoader *)loader didFailWithError:(NSError *)error {
    NSLog(@"Native Ad Loader failed to load with the following error: %@", error.localizedDescription);
}

...

~~~~

### Listen for Location Updates

If you want to allow for geotargeting, listen for location updates:

~~~~
@property (strong, nonatomic) CLLocationManager *locationManager;

...

// Start listening for location updates:
self.locationManager = [[CLLocationManager alloc] init];
self.locationManager.delegate = self;

// iOS 8 check:
if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
    [self.locationManager requestWhenInUseAuthorization];
}
[self.locationManager startUpdatingLocation];

...

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    // Notify the PW Ads banner when the location changes. New location will be used the next time an ad is requested.
    [self.pwAd updateLocation:newLocation];
}

...

// To stop monitoring location when complete to conserve battery life:
[self.locationManager stopMonitoringSignificantLocationChanges];
~~~~

### Customization Options

If you want to customize the appearance of the in-app browser controller that appears when a user taps on an ad, follow the below instructions:

1. To customize the background color of the browser controller toolbar, in your app's Info.plist file add the key **pwAdsToolbarBgColor** with a color value represented in RGBA format (ex. orange = **255 149 0 1**).
2. To customize the tint color of the browser controller toolbar items, in your app's Info.plist file add the key **pwAdsToolbarTintColor** with a color value represented in RGBA format (ex. blue = **0 0 255 1**).

If you want to customize the appearance of the close button for interstitial ads, follow the below instructions:

1. Create close button images at 32x32 @1x and 64x64 @2x.
2. Name the newly created images **pwCustomClose.png** and **pwCustomClose@2x.png**.
3. Add the pwCustomClose.png and pwCustomClose@2x.png images to your Xcode project.
