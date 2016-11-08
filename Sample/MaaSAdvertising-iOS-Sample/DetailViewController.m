//
//  DetailViewController.m
//  PWAdvertisingQA
//
//  Created by Hari Kunwar on 4/15/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "DetailViewController.h"
#import "AdUnit.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}

/**
 *  Loads the specific view controller for the selected Ad Unit.
 */
- (void)configureView {
    // Remove current child view controller
    UIViewController *childViewController = [self.childViewControllers lastObject];
    [childViewController.view removeFromSuperview];
    [childViewController removeFromParentViewController];
    
    UIViewController *viewController = nil;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    switch (_adObject.adType) {
        case AdTypeBanner:
            viewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"bannerTabBarController"];
            break;
        case AdTypeInterstitial:
            viewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"interstitialViewController"];
            break;
        case AdTypeVideo:
            viewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"videoViewController"];
            break;
        case AdTypeRewardedVideo:
            viewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"rewardedVideoViewController"];
            break;
        case AdTypeNative:
            viewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"nativeViewController"];
            break;
        case AdTypeLandingPage:
            viewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"landingPageViewController"];
            break;
        default:
            break;
    }
    
    if (viewController != nil) {
        /// Add new child view controller
        self.title = _adObject.adName;
        [self addChildViewController:viewController];
        viewController.view.frame = self.view.frame;
        [self.view addSubview:viewController.view];
        [viewController didMoveToParentViewController:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
