//
//  PWAdsAppTracker.h
//  PWAds iOS SDK
//
//  Copyright (c) 2015 TapIt! by Phunware. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `PWAdsAppTracker` implements a standard `PWAdsAppTracker` into your app. This is required for all ad requests.
 */

@interface PWAdsAppTracker : NSObject

///-----------------------
/// @name Required Methods
///-----------------------

/**
 This method creates the shared app tracker.
 */
+ (PWAdsAppTracker *)sharedAppTracker;

/**
 This method registers your application with the ad server.
 */
- (void)reportApplicationOpen;

///---------------
/// @name Other Methods
///---------------

///**
// Returns 'MaaSAdvertising'.
// */
//+ (NSString *)serviceName;

@end
