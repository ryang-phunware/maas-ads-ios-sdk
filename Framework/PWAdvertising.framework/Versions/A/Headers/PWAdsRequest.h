//
//  PWAdsRequest.h
//  PWAds iOS SDK
//
//  Copyright (c) 2015 TapIt! by Phunware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

/**
 `PWAdsRequest` implements a standard `PWAdsRequest` into your app. This is required for all ad requests.
 */

@interface PWAdsRequest : NSObject

///---------------
/// @name Optional
///---------------

/**
 Creates the `PWAdsRequest` object with the specified zone ID.
 
 @param zone The zone ID for which you want to request ads.
 */
+ (PWAdsRequest *)requestWithAdZone:(NSString *)zone;

/**
 Creates the `PWAdsRequest` object with the specified zone ID and any custom parameters.
 
 @param zone The zone ID for which you want to request ads.
 @param theParams An `NSDictionary` with key / value pairs of custom parameters.
 */
+ (PWAdsRequest *)requestWithAdZone:(NSString *)zone andCustomParameters:(NSDictionary *)theParams;

/**
 Updates the `PWAdsRequest` object with the user's location information.
 
 @param location The user's current location.
 */
- (void)updateLocation:(CLLocation *)location;

/**
 Returns the custom parameter that is set in the `PWAdsRequest` object for the given key.
 
 @param key The key for which you want to see the value.
 */
- (id)customParameterForKey:(NSString *)key;

/**
 Sets the custom parameter in the `PWAdsRequest` object for the given key.
 
 @param value The value for which you want to set the key.
 @param key The key for which you want to set the value.
 */
- (id)setCustomParameter:(id)value forKey:(NSString *)key;

/**
 Removes the custom parameter in the `PWAdsRequest` object for the given key.
 
 @param key The key for which you want to remove the value.
 */
- (id)removeCustomParameterForKey:(NSString *)key;


/**
 An `NSUInteger` that sets the location precision information of the `PWAdsRequest`.
 */
@property (nonatomic, assign) NSUInteger locationPrecision;

/**
 A `BOOL` to indicate whether the `PWAdsRequest` should run in test mode.
 */
@property (nonatomic, readwrite, setter = setTestMode:) BOOL isTestMode;

@end
