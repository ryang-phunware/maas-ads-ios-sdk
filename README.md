MaaS Advertising iOS SDK
================

Version 3.0.12

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
MaaSCore.framework
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
AdSupport.framework - enable support for IDFA
StoreKit.framework - enable use of SKStoreProductViewController, displays app store ads without leaving your app
````

MaaS Advertising has a dependency on MaaSCore.framework, which is available here: https://github.com/phunware/maas-core-ios-sdk

It's recommended that you add the MaaS framesworks to the 'Vendor/Phunware' directory. This directory should contain MaaSCore.framework and MaaSAdvertising.framework  as well as any other MaaS frameworks that you are using.

**In the Build Settings for your target, you must include the following "Other Linker Flags:" -ObjC**

The following frameworks are optional:

````
CoreLocation.framework
````
CoreLocation is optional and is used for geo-targeting ads.  Apple mandates that your app have a good reason for enabling Location services and will deny your app if location is not a core feature for your app.

The following bundles are required:

````
PWAds.bundle
````

PWAds.bundle includes files needed for media-rich advertisements that make use of device specific features. It is included with this sample app.



Integration
----------

The MaaS Advertising SDK allows developers to serve many types of ads, including banner, interstitial and video ads.

### Initialization

~~~~
//In your AppDelegate.m file:
#import <MaaSAdvertising/PWAdsAppTracker.h>

...

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    PWAdsAppTracker *appTracker = [PWAdsAppTracker sharedAppTracker];
    [appTracker reportApplicationOpen];
    return YES;
}
~~~~


### Banner Usage

~~~~
// In your .h file:
#import <MaaSAdvertising/PWAdsBannerAdView.h>
@property (retain, nonatomic) PWAdsBannerAdView *pwAd;

...

// In your .m file:
#import <MaaSAdvertising/PWAds.h>
...
// Init banner and add to your view:
pwAd = [[PWAdsBannerAdView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
[self.view addSubview:self.pwAd];

// To kick off banner rotation:
[self.pwAd startServingAdsForRequest:[PWAdsRequest requestWithAdZone:@"**YOUR ZONE ID**"]];

...

// To hide and cancel ads: 
[self.pwAd hide];
[self.pwAd cancelAds];
~~~~



### Interstitial Usage

#### Show Modally

~~~~
// In your .h file:
#import <MaaSAdvertising/PWAdsInterstitialAd.h>
...
@property (retain, nonatomic) PWAdsInterstitialAd *interstitialAd;

...

// In your .m file: 
#import <MaaSAdvertising/PWAds.h>
...
// Init and load interstitial:
self.interstitialAd = [[PWAdsInterstitialAd alloc] init];
self.interstitialAd.delegate = self; // notify me of the interstitial's state changes
PWAdsRequest *request = [PWAdsRequest requestWithAdZone:@"**YOUR ZONE ID**"];
[self.interstitialAd loadInterstitialForRequest:request];

...

- (void)pwInterstitialAdDidLoad:(PWAdsInterstitialAd *)interstitialAd {
    // Ad is ready for display... show it!
    [self.interstitialAd presentFromViewController:self];
}
~~~~


#### Include in Paged Navigation
    
~~~~
@property (retain, nonatomic) TapItInterstitialAd *interstitialAd;

...

// Init and load interstitial:
self.interstitialAd = [[PWAdsInterstitialAd alloc] init];
PWAdsRequest *request = [PWAdsRequest requestWithAdZone:@"**YOUR ZONE ID**"];
[self.interstitialAd loadInterstitialForRequest:request];

...

// If interstitial is ready, show:
if( self.interstitialAd.isLoaded ) {
    [self.interstitialAd presentInView:self.view];
}
~~~~

### Video Ads Usage

When requesting a video ad from the server, a TVASTAdsRequest object must be instantiated and its zoneId parameter specified. This parameter is required for a successful retrieval of the ad.

~~~~    
    // Create an adsRequest object and request ads from the ad server with your own ZONE_ID
    TVASTAdsRequest *request = [TVASTAdsRequest requestWithAdZone:**YOUR ZONE ID**;
    [_videoAd requestAdsWithRequestObject:request];
~~~~

If you want to specify the type of video ad you are requesting, use the call below.

~~~~    
    TVASTAdsRequest *request = [TVASTAdsRequest requestWithAdZone:**YOUR ZONE ID**];
    [_videoAd requestAdsWithRequestObject:request andVideoType:TapItVideoTypeMidroll];
~~~~

(Essentially, what needs to be included in the code is as follows:)

~~~~
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _videoAd = [[TapItVideoInterstitialAd alloc] init];
    _videoAd.delegate = self;
    
    //Optional: Override the presentingViewController (defaults to the delegate)
    //_videoAd.presentingViewController = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestAds {    
    // Create an adsRequest object and request ads from the ad server with your own ZONE_ID
    TVASTAdsRequest *request = [TVASTAdsRequest requestWithAdZone:**YOUR ZONE ID**];
    [_videoAd requestAdsWithRequestObject:request];
    
    //If you want to specify the type of video ad you are requesting, use the call below.
    //[_videoAd requestAdsWithRequestObject:request andVideoType:TapItVideoTypeMidroll];
}

- (IBAction)onRequestAds {
    [self requestAds];
}

- (void)tapitVideoInterstitialAdDidFinish:(TapItVideoInterstitialAd *)videoAd {
    NSLog(@"Override point for resuming your app's content.");
    [_videoAd unloadAdsManager];
}

- (void)viewDidUnload {
    [_videoAd unloadAdsManager];
    [super viewDidUnload];
}

- (void)tapitVideoInterstitialAdDidLoad:(TapItVideoInterstitialAd *)videoAd {
    NSLog(@"We received an ad... now show it.");
    [videoAd playVideoFromAdsManager];
}

- (void)tapitVideoInterstitialAdDidFail:(TapItVideoInterstitialAd *)videoAd withErrorString:(NSString *)error {
    NSLog(@"%@", error);
}
~~~~

### Listen for Location Updates

If you want to allow for geo-targeting, listen for location updates:

~~~~
@property (retain, nonatomic) CLLocationManager *locationManager;

...

// start listening for location updates
self.locationManager = [[CLLocationManager alloc] init];
self.locationManager.delegate = self;
[self.locationManager startMonitoringSignificantLocationChanges];

...

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    // Notify the TapIt! banner when the location changes.  New location will be used the next time an ad is requested.
    [self.tapitAd updateLocation:newLocation];
}

...

// To stop monitoring location when complete to conserve battery life:
[self.locationManager stopMonitoringSignificantLocationChanges];
~~~~
