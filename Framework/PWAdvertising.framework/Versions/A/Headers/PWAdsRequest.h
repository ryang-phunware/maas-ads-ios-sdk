//
//  PWAdsRequest.h
//  PWAdvertising
//
//  Copyright © 2015 Phunware, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

/**
 Class with ad request parameters.
 */
@interface PWAdsRequest : NSObject

/// The id string of the zone of publisher site.
@property (nonatomic, strong) NSString *zoneID;

/// Geolocation for targeted ads.
@property (nonatomic, copy) CLLocation *location;

/// List of keywords to that describe a request.
@property (nonatomic, copy) NSArray *keywords;

/// Number of ads requested. Only supported for requesting native ads.
@property (nonatomic, assign) NSInteger numberOfAds;

/// Whether request is for test ads. Default is NO.
@property (nonatomic, assign) BOOL testMode;

/// Custom Data object for Rewarded Video ads request.
@property (nonatomic, copy) NSMutableDictionary *customData;

/// User ID for Rewarded Video ads request.
@property (nonatomic, copy) NSString *userID;

/**
 Designated initializer for PWAdsRequest.
 
 @param zoneID The id string of the zone of publisher site
 */
- (instancetype)initWithZoneID:(NSString *)zoneID NS_DESIGNATED_INITIALIZER;

/**
 Initializes and return a PWAdsRequest instance with given zoneID.
 
 @param zoneID The id string of the zone of publisher site.
 */
+ (PWAdsRequest *)requestWithZoneID:(NSString *)zoneID;


#pragma mark - DEPRECATED
#pragma mark -

/// Whether request ads in test mode. Deprecated use testMode.
@property (nonatomic, readwrite, setter = setTestMode:) BOOL isTestMode DEPRECATED_ATTRIBUTE;

/// An `NSUInteger` that sets the location precision information of the `PWAdsRequest`.
@property (nonatomic, assign) NSUInteger locationPrecision DEPRECATED_ATTRIBUTE;

/**
 Creates the `PWAdsRequest` object with the specified zone ID.
 
 @param zone The zone ID for which you want to request ads.
 */
+ (PWAdsRequest *)requestWithAdZone:(NSString *)zone DEPRECATED_ATTRIBUTE;

/**
 Creates the `PWAdsRequest` object with the specified zone ID and any custom parameters.
 
 @param zone The zone ID for which you want to request ads.
 @param theParams An `NSDictionary` with key / value pairs of custom parameters.
 */
+ (PWAdsRequest *)requestWithAdZone:(NSString *)zone andCustomParameters:(NSDictionary *)theParams DEPRECATED_ATTRIBUTE;

/**
 Updates the `PWAdsRequest` object with the user's location information.
 
 @param location The user's current location.
 */
- (void)updateLocation:(CLLocation *)location DEPRECATED_ATTRIBUTE;

/**
 Returns the custom parameter that is set in the `PWAdsRequest` object for the given key.
 
 @param key The key for which you want to see the value.
 */
- (id)customParameterForKey:(NSString *)key DEPRECATED_ATTRIBUTE;

/**
 Sets the custom parameter in the `PWAdsRequest` object for the given key.
 
 @param value The value for which you want to set the key.
 @param key The key for which you want to set the value.
 */
- (id)setCustomParameter:(id)value forKey:(NSString *)key DEPRECATED_ATTRIBUTE;

/**
 Removes the custom parameter in the `PWAdsRequest` object for the given key.
 
 @param key The key for which you want to remove the value.
 */
- (id)removeCustomParameterForKey:(NSString *)key DEPRECATED_ATTRIBUTE;

@end
