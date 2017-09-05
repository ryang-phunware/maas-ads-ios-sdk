//
//  PWAdsAppTracker.h
//  PWAds iOS SDK
//
//  Copyright © 2015 Phunware, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Class for registering application to ad servers.
 */
@interface PWAdsAppTracker : NSObject

/// Create shared app tracker.
+ (PWAdsAppTracker *)sharedAppTracker;

/// Register your application with the ad server.
- (void)reportApplicationOpen;

@end
