//
//  PWAdsNativeAd.h
//  PWAdvertising
//
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//  

#import <UIKit/UIKit.h>

/**
 Class with native advertisment information.
 */
@interface PWAdsNativeAd : NSObject

/// An `NSString` that contains the ad title for the `adTitle`.
@property (nonatomic, readonly) NSString *adTitle;

/// An `NSString` that contains the ad text for the `adText`.
@property (nonatomic, readonly) NSString *adText;

/// An `NSString` that contains the ad HTML for the `adHTML`.
@property (nonatomic, readonly) NSString *adHTML;

/// An `NSNumber` that contains the ad rating for the `adRating`.
@property (nonatomic, readonly) NSNumber *adRating;

/// An `NSString` that contains the ad icon URL for the `adIconURL`.
@property (nonatomic, readonly) NSString *adIconURL;

/// An `NSString` that contains the ad image URL for the `adImageURL`.
@property (nonatomic, readonly) NSString *adImageURL;

/// An `NSString` that contains the ad call to action for the `adCTA`.
@property (nonatomic, readonly) NSString *adCTA;

/// An `NSString` that contains the ad click URL for the `adClickURL`.
@property (nonatomic, readonly) NSString *adClickURL;

/// An `NSArray` that contains the ad impression URLs for the `adImpressionURLs`.
@property (nonatomic, readonly) NSArray *adImpressionURLs;

/// An `NSString` that contains the ad type for the `adType`.
@property (nonatomic, readonly) NSString *adType;

/// An `NSString` that contains the ad dimension for the `adDimension`.
@property (nonatomic, readonly) NSString *adDimension;

/// An `NSDictionary` that contains all of the native ad data for the `nativeAdData`.
@property (nonatomic, readonly) NSDictionary *nativeAdData;

@end



