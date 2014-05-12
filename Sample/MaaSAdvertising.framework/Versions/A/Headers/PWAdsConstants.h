//
//  PWAdsConstants.h
//  PWAds iOS SDK
//
//  Created by Nick Penteado on 4/13/12.
//  Updated by Carl Zornes on 10/24/13.
//  Copyright (c) 2013 PWAds!. All rights reserved.
//

#ifndef PWAds_iOS_Sample_PWAdsConstants_h
#define PWAds_iOS_Sample_PWAdsConstants_h

#define PWADS_VERSION @"3.0.13"

/**
 `PWAdsAdType` defines the available ad types for interstitial ads.
 */
typedef enum {
    PWAdsBannerAdType       = 0x01,
    PWAdsFullscreenAdType   = 0x02,
    PWAdsVideoAdType        = 0x04,
    PWAdsOfferWallType      = 0x08,
} PWAdsAdType;

/**
 `PWAdsBannerHideDirection` defines the orientations in which you want to disable displaying ads.
 */
typedef enum {
    PWAdsBannerHideNone,
    PWAdsBannerHideLeft,
    PWAdsBannerHideRight,
    PWAdsBannerHideUp,
    PWAdsBannerHideDown,
} PWAdsBannerHideDirection;

/**
 `PWAdsVideoType` defines the available video types for video ads.
 */
typedef enum {
    PWAdsVideoTypeAll,
    PWAdsVideoTypePreroll,
    PWAdsVideoTypeMidroll,
    PWAdsVideoTypePostroll,
} PWAdsVideoType;

#define PWADS_PARAM_KEY_BANNER_ROTATE_INTERVAL @"RotateBannerInterval"
#define PWADS_PARAM_KEY_BANNER_ERROR_TIMEOUT_INTERVAL @"ErrorRetryInterval"

#define PWAdsDefaultLocationPrecision 6

#endif
