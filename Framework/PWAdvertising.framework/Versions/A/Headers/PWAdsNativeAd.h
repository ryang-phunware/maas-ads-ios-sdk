//
//  PWAdsNativeAd.h
//  PWAds iOS SDK
//
//
//

#import <Foundation/Foundation.h>

/**
 `PWAdsNativeAd` implements a standard `PWAdsNativeAd` into your app.
 */
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
 An `NSString` that contains the ad image URL for the `PWAdsNativeAd`.
 */
- (NSString *)adImageURL;

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
- (NSString *)adImpressionURL DEPRECATED_ATTRIBUTE;

/**
 An `NSArray` that contains the ad impression URLs for the `PWAdsNativeAd`.
 */
- (NSArray *)adImpressionURLs;

/**
 An `NSString` that contains the ad type for the `PWAdsNativeAd`.
 */
- (NSString *)adType;

/**
 An `NSString` that contains the ad dimension for the `PWAdsNativeAd`.
 */
- (NSString *)adDimension;

/**
 An `NSDictionary` that contains all of the native ad data for the `PWAdsNativeAd`.
 */
- (NSDictionary *)nativeAdData;

@end
