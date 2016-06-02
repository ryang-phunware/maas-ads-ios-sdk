//
//  PWAdsVideoAdsRequest.h
//  Video Ads SDK
//
//  Copyright 2013 TapIt by Phunware Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 @Deprecated
 AdsRequest for loading ads from ad server.
 
 Caller can provide ads request key and values that needs to be passed to
 PWAdsVideoAdsLoader to request ads.
 */
__deprecated_msg("PWAdsVideoAdsRequest has been deprecated.")
@interface PWAdsVideoAdsRequest : NSObject

@property (nonatomic, assign) NSUInteger locationPrecision;

/**
 Initializes and return a PWAdsVideoAdsRequest instance with given zoneID.
 
 @param zone The id string of the zone of publisher site.
 */
+ (PWAdsVideoAdsRequest *)requestWithAdZone:(NSString *)zone;

/**
 Initializes and return a PWAdsVideoAdsRequest instance with given zoneID and custom parameters.
 
 @param zone The id string of the zone of publisher site.
 @param andCustomParameters The ad request custom parameters.
 */
+ (PWAdsVideoAdsRequest *)requestWithAdZone:(NSString *)zone andCustomParameters:(NSDictionary *)params;

/**
 Set a string request parameter value for a key.
 */
- (id)setCustomParameter:(id)value forKey:(NSString *)key;

/**
 Get a custom parameter given a key.
 */
- (id)customParameterForKey:(NSString *)key;

/**
 Remove a custom parameter with given a key.
 */
- (id)removeCustomParameterForKey:(NSString *)key;

/**
 Update location information.
 */
- (void)updateLocation:(CLLocation *)location;

@end
