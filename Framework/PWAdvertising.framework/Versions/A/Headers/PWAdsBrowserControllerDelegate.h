//
//  PWAdsBrowserControllerDelegate.h
//  PWAds iOS SDK
//
//
//  Updated by Carl Zornes on 10/24/13.
//  Copyright (c) 2013 PWAds!. All rights reserved.
//

@class PWAdsBrowserController;

/**
 @Deprecated
 This protocol is to be used when trying to handle actions when the user taps on an ad.
 */
__deprecated_msg("PWAdsBrowserControllerDelegate has been deprecated.")
@protocol PWAdsBrowserControllerDelegate <NSObject>

@optional
/**
 Called when the web view fails to load the ad's landing page.

 @param browserController The controller which failed to load content.
 @param withError The error with more information about failure.
 */
- (void)browserControllerFailedToLoad:(PWAdsBrowserController *)browserController withError:(NSError *)error;

/**
 Called when the web view should load the ad's landing page.
 
 @param willLeaveApp Indicates whether the user will leave application.
 */
- (BOOL)browserControllerShouldLoad:(PWAdsBrowserController *)browserController willLeaveApp:(BOOL)willLeaveApp;

/**
 Called once the web view has loaded ad's landing page.
 
 @param browserController The controller which loaded content.
 @param willLeaveApp Indicates whether the user will leave application.
 */
- (void)browserControllerLoaded:(PWAdsBrowserController *)browserController willLeaveApp:(BOOL)willLeaveApp;

/**
 Called before browserController is presented.
 
 @param browserController The controller being presented.
 */
- (void)browserControllerWillPresent:(PWAdsBrowserController *)browserController;

/**
 Called after browserController is presented.
 
 @param browserController The controller that was presented.
 */
- (void)browserControllerDidPresent:(PWAdsBrowserController *)browserController;

/**
 Called when the 'Done' button is pressed on the ad's landing page.
 
 @param browserController The controller being dismissed.
 */
- (void)browserControllerWillDismiss:(PWAdsBrowserController *)browserController;

/**
 Called after the web view is closed.
 
 @param browserController The controller that was dismissed.
 */
- (void)browserControllerDismissed:(PWAdsBrowserController *)browserController;

@end
