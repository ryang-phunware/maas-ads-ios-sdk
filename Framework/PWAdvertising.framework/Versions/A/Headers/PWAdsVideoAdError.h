//
//  PWAdsVideoAdError.h
//  Video Ads SDK
//
//  Created by Kevin Truong on 4/30/13.
//
//  This file provides error codes that are raised internally by the SDK and
//  declares the PWAdsVideoAdError instance.

#import <Foundation/Foundation.h>

/// Possible error types while loading or playing ads.
typedef NS_ENUM(unsigned int, PWAdsVideoAdErrorType) {
  /// An unexpected error occured while loading or playing the ads.
  //
  /// This may mean that the SDK wasn't loaded properly.
  _PWAdsVideoAdAdUnknownErrorType,
  /// An error occured while loading the ads.
  _PWAdsVideoAdAdLoadingFailed,
  /// An error occured while playing the ads.
  _PWAdsVideoAdAdPlayingFailed,
};

/// Possible error codes raised while loading or playing ads.
typedef NS_ENUM(unsigned int, PWAdsVideoAdErrorCode) {
  /// Unknown error occured while loading or playing the ad.
  _PWAdsVideoAdUnknownErrorCode = 0,
  /// There was an error playing the video ad.
  _PWAdsVideoAdVideoPlayError = 1003,
  /// There was a problem requesting ads from the server.
  _PWAdsVideoAdFailedToRequestAds = 1004,
  /// There was an internal error while loading the ad.
  _PWAdsVideoAdInternalErrorWhileLoadingAds = 2001,
  /// No supported ad format was found.
  _PWAdsVideoAdSupportedAdsNotFound = 2002,
  /// At least one VAST wrapper ad loaded successfully and a subsequent wrapper
  /// or inline ad load has timed out.
  _PWAdsVideoAdVastLoadTimeout = 3001,
  /// At least one VAST wrapper loaded and a subsequent wrapper or inline ad
  /// load has resulted in a 404 response code.
  _PWAdsVideoAdVastInvalidUrl = 3002,
  /// The ad response was not recognized as a valid VAST ad.
  _PWAdsVideoAdVastMalformedResponse = 3003,
  /// A media file of a VAST ad failed to load or was interrupted mid-stream.
  _PWAdsVideoAdVastMediaError = 3004,
  /// The maximum number of VAST wrapper redirects has been reached.
  _PWAdsVideoAdVastTooManyRedirects = 3005,
  /// Assets were found in the VAST ad response, but none of them matched the
  /// video player's capabilities.
  _PWAdsVideoAdVastAssetMismatch = 3006,
  /// No assets were found in the VAST ad response.
  _PWAdsVideoAdVastAssetNotFound = 3007,
  /// Invalid arguments were provided to SDK methods.
  _PWAdsVideoAdInvalidArguments = 3101,
  /// A companion ad failed to load or render.
  _PWAdsVideoAdCompanionAdLoadingFailed = 3102,
  /// The ad response was not understood and cannot be parsed.
  _PWAdsVideoAdUnknownAdResponse = 3103,
  /// An unexpected error occurred while loading the ad.
  _PWAdsVideoAdUnexpectedLoadingError = 3104,
  /// An overlay ad failed to load.
  _PWAdsVideoAdOverlayAdLoadingFailed = 3105,
  /// An overlay ad failed to render.
  _PWAdsVideoAdOverlayAdPlayingFailed = 3106,
};

/**
 @Deprecated
 Surfaces an error that occured during ad loading or playing.
 */
__deprecated_msg("PWAdsVideoAdError has been deprecated.")
@interface PWAdsVideoAdError : NSError

/// The |errorType| accessor provides information about whether the error
/// occured during ad loading or ad playing.
@property (nonatomic, readonly) PWAdsVideoAdErrorType errorType;

- (instancetype)initWithErrorType:(PWAdsVideoAdErrorType) errorType errorCode:(PWAdsVideoAdErrorCode) errorCode NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithError:(NSError *) error errorType:(PWAdsVideoAdErrorType) errorType errorCode:(PWAdsVideoAdErrorCode) errorCode NS_DESIGNATED_INITIALIZER;

@end
