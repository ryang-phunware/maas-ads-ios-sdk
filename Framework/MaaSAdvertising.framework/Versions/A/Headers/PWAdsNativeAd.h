//
//  PWAdsNativeAd.h
//  PWAds iOS SDK
//
//  Created by Carl Zornes on 11/20/14.
//
//

#import <Foundation/Foundation.h>

@interface PWAdsNativeAd : NSObject

/**
 An `NSString` that contains the ad title for the `PWAdsNativeAd`.
 */
- (NSString *)adTitle;

/**
 An `NSString` that contains the ad text for the `PWAdsNativeAd`.
 */
- (NSString *)adText;

/**
 An `NSString` that contains the ad HTML for the `PWAdsNativeAd`.
 */
- (NSString *)adHTML;

/**
 An `NSNumber` that contains the ad rating for the `PWAdsNativeAd`.
 */
- (NSNumber *)adRating;

/**
 An `NSString` that contains the ad icon URL for the `PWAdsNativeAd`.
 */
- (NSString *)adIconURL;

/**
 An `NSString` that contains the ad call to action for the `PWAdsNativeAd`.
 */
- (NSString *)adCTA;

/**
 An `NSString` that contains the ad click URL for the `PWAdsNativeAd`.
 */
- (NSString *)adClickURL;

/**
 An `NSString` that contains the ad impression URL for the `PWAdsNativeAd`.
 */
- (NSString *)adImpressionURL;

/**
 An `NSString` that contains the ad type for the `PWAdsNativeAd`.
 */
- (NSString *)adType;

/**
 An `NSString` that contains the ad dimension for the `PWAdsNativeAd`.
 */
- (NSString *)adDimension;

@end
