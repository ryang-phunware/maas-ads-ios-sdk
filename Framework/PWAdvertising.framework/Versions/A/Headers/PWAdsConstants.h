//
//  PWAdsConstants.h
//  PWAds iOS SDK
//
//  Created by Nick Penteado on 4/13/12.
//  Updated by Carl Zornes on 12/12/14.
//  Copyright (c) 2013 PWAds!. All rights reserved.
//

#ifndef PWAds_iOS_Sample_PWAdsConstants_h
#define PWAds_iOS_Sample_PWAdsConstants_h

#define PWADS_VERSION @"3.3.0"

#import <Foundation/Foundation.h>
/**
 `PWAdsAdType` defines the available ad types for interstitial ads.
 */

typedef NS_OPTIONS(unsigned int, PWAdsAdType) {
    PWAdsBannerAdType       = 0x01,
    PWAdsFullscreenAdType   = 0x02,
    PWAdsVideoAdType        = 0x04,
    PWAdsOfferWallType      = 0x08,
};

/**
 `PWAdsBannerHideDirection` defines the orientations in which you want to disable displaying ads.
 */
typedef NS_ENUM(unsigned int, PWAdsBannerHideDirection) {
    PWAdsBannerHideNone,
    PWAdsBannerHideLeft,
    PWAdsBannerHideRight,
    PWAdsBannerHideUp,
    PWAdsBannerHideDown,
};

/**
 `PWAdsVideoType` defines the available video types for video ads.
 */
typedef NS_ENUM(unsigned int, PWAdsVideoType) {
    PWAdsVideoTypeAll,
    PWAdsVideoTypePreroll,
    PWAdsVideoTypeMidroll,
    PWAdsVideoTypePostroll,
};


#define PWAdsDefaultLocationPrecision 6

#endif
