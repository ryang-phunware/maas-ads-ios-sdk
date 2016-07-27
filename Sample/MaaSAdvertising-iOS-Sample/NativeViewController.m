//
//  NativeViewController.m
//  PWAdvertising
//
//  Created by Hari Kunwar on 4/16/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "NativeViewController.h"
#import <PWAdvertising/PWAdsNativeAdLoader.h>
#import <PWAdvertising/PWAdsRequest.h>
#import <PWAdvertising/PWAdsNativeAdView.h>
#import <PWAdvertising/PWAdsNativeAd.h>
#import "NativeCleanAdUnitView.h"
#import "Native3UpAdUnitView.h"
#import "NativeIconAdUnitView.h"
// Example Zone IDs
static NSString * const kZoneIDNative =  @"64477"; // for example use only, don't use this zone in your app!
static NSString * const kNativeContentStream =  @"Content Stream";
static NSString * const kNativeNewsFeed =  @"News Feed";
static NSString * const kNativeAppWall =  @"App Wall";
static NSString * const kNativeContentWall =  @"Content Wall";
static NSString * const kNativeClean = @"Clean";
static NSString * const kNative3Up = @"3Up";
static NSString * const kNative3UpWith2Ads = @"3UpWith2Ads";
static NSString * const kNative3UpWith1Ad = @"3UpWith1Ad";
static NSString * const kNativeIcon = @"Single Icon";
static NSString * const kNativeIcons = @"Multi Icon";

@interface NativeViewController () <PWAdsNativeAdLoaderDelegate, PWAdsNativeAdViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation NativeViewController {
    __weak IBOutlet UIView *_adView;
    PWAdsNativeAdLoader *_nativeAdLoader;
    __weak IBOutlet UIPickerView *_pickerView;
    NSString *_selectedNativeAd;
    NSArray *_nativeAds;
    NativeAdHorizontalAligment _3UpAdUnitlayoutAligment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectedNativeAd = kNativeContentStream;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    // Create PWAdsNativeAdLoader instance
    _nativeAdLoader = [PWAdsNativeAdLoader new];
    _nativeAdLoader.delegate = self;
    
    _nativeAds = @[kNativeContentStream, kNativeNewsFeed, kNativeAppWall, kNativeContentWall,kNativeIcon,kNativeIcons,kNativeClean,kNative3UpWith1Ad,kNative3UpWith2Ads,kNative3Up];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadAdsButtonPressed:(id)sender {
    // Create ad request instance
    PWAdsRequest *adsRequest = [PWAdsRequest requestWithZoneID:kZoneIDNative];
    
    // Set test mode for request. This will fetch test ads.
    adsRequest.testMode = YES;
    
    // Load native ads request
    [_nativeAdLoader loadAdsRequest:adsRequest];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _nativeAds.count;
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _nativeAds[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedNativeAd = _nativeAds[row];
}

#pragma mark - PWAdsNativeAdLoaderDelegate

//  Called when a new native advertisement is loaded.
- (void)nativeAdLoaderDidLoadAds:(NSArray *)nativeAds {
    NSLog(@"nativeAdLoaderDidLoadAds:");
    
    if ([_selectedNativeAd isEqualToString:kNativeContentStream]) {
        [self showNativeAdContentStream:[nativeAds lastObject]];
    }
    else if ([_selectedNativeAd isEqualToString:kNativeNewsFeed]) {
        [self showNativeAdNewsFeed:[nativeAds lastObject] withYOffset:0];
    }
    else if ([_selectedNativeAd isEqualToString:kNativeAppWall]) {
        [self showNativeAdAppWall:nativeAds];
    }
    else if ([_selectedNativeAd isEqualToString:kNativeContentWall]) {
        [self showNativeAdContentWall:[nativeAds lastObject]];
    }
    else if ([_selectedNativeAd isEqualToString:kNativeClean]) {
        [self showNativeClean:[nativeAds lastObject]];
    }
    else if ([_selectedNativeAd isEqualToString:kNative3Up]) {
        NSMutableArray *showAds = [NSMutableArray arrayWithArray:nativeAds];
        while (showAds.count < 3) {
            [showAds addObjectsFromArray:showAds];
        }
        [self show3UpAdUnit:showAds];
    }
    else if ([_selectedNativeAd isEqualToString:kNative3UpWith2Ads]) {
        NSMutableArray *showAds = [NSMutableArray arrayWithArray:nativeAds];
        if (showAds.count <2) {
            [showAds addObjectsFromArray:showAds];
        }
        [self show3UpAdUnit:showAds];
    }
    else if ([_selectedNativeAd isEqualToString:kNative3UpWith1Ad]){
        [self show3UpAdUnit:nativeAds];
    }
    else if ([_selectedNativeAd isEqualToString:kNativeIcon] || [_selectedNativeAd isEqualToString:kNativeIcons]) {
        NSMutableArray *showAds = [NSMutableArray arrayWithArray:nativeAds];
        if ([_selectedNativeAd isEqualToString:kNativeIcons]) {
            if (showAds.count > 0) {
                while (showAds.count < 3) {
                    [showAds addObjectsFromArray:nativeAds];
                }
            }
        }
        [self showIconsAdUnit:showAds];
    }
}

//  Called when a native advertisement fails to load.
- (void)nativeAdLoader:(PWAdsNativeAdLoader *)loader didFailWithError:(NSError *)error {
    NSLog(@"nativeAdLoader:didFailWithError:");
}

#pragma mark - PWAdsNativeAdViewDelegate

// Called before a native advertisment modal is presented.
- (void)nativeAdViewWillPresentModal:(PWAdsNativeAdView *)nativeAdView {
    NSLog(@"nativeAdViewWillPresentModal:");
}

//  Called after a native advertisment modal is presented.
- (void)nativeAdViewDidPresentModal:(PWAdsNativeAdView *)nativeAdView {
    NSLog(@"nativeAdViewDidPresentModal:");
}

//  Called before a native ad dismisses a modal.
- (void)nativeAdViewWillDissmissModal:(PWAdsNativeAdView *)nativeAdView {
    NSLog(@"nativeAdViewWillDissmissModal:");
}

//  Called after a native ad dismissed a modal view.
- (void)nativeAdViewDidDismissModal:(PWAdsNativeAdView *)nativeAdView {
    NSLog(@"nativeAdViewDidDismissModal:");
}

//  Called before an advertisment modal is presented. This happens when use taps on an advertisment.
- (BOOL)shouldPresentModalForNativeAdView:(PWAdsNativeAdView *)nativeAdView {
    NSLog(@"shouldPresentModalForNativeAdView:");
    return YES;
}

//  Called before user leaves the application. This happens when user taps on an advertisment.
- (BOOL)shouldLeaveApplicationForNativeAdView:(PWAdsNativeAdView *)nativeAdView {
    NSLog(@"shouldLeaveApplicationForNativeAdView:");
    return YES;
}


#pragma mark - Native ad building methods
-(void)showIconsAdUnit:(NSArray *)newAds{
    // Remove all subviews
    for (UIView *view in _adView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat width = 300, height = newAds.count * 90 + 10;
    CGFloat x = CGRectGetMidX(_adView.bounds) - width/2;
    CGFloat y = CGRectGetMidY(_adView.bounds) - height/2;
    NativeIconAdUnitView *iconAdView = [[NativeIconAdUnitView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    iconAdView.delegate = self;
    [iconAdView showIconAdUnit:newAds];
    [_adView addSubview:iconAdView];
}

-(void)showNativeClean:(PWAdsNativeAd *)newAd {
    // Remove all subviews
    for (UIView *view in _adView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat width = 300, height = 70;
    CGFloat x = CGRectGetMidX(_adView.bounds) - width/2;
    CGFloat y = CGRectGetMidY(_adView.bounds) - height/2;
    NativeCleanAdUnitView *cleanAdView = [[NativeCleanAdUnitView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    cleanAdView.delegate = self;
    [cleanAdView showCleanAdUnit:newAd];
    [_adView addSubview:cleanAdView];
}

-(void)show3UpAdUnit:(NSArray *)newAds {
    for (UIView *view in _adView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat width = 300, height = 210;
    CGFloat x = CGRectGetMidX(_adView.bounds) - width/2;
    CGFloat y = CGRectGetMidY(_adView.bounds) - height/2;
    Native3UpAdUnitView *Native3upAdView = [[Native3UpAdUnitView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    Native3upAdView.delegate =self;
    [Native3upAdView show3UpAdUnit:newAds layoutType:_3UpAdUnitlayoutAligment];
    _3UpAdUnitlayoutAligment = (_3UpAdUnitlayoutAligment +1) % 3;
    [_adView addSubview:Native3upAdView];
}


- (void)showNativeAdContentStream:(PWAdsNativeAd *)newAd{
    // Remove all subviews
    for (UIView *view in _adView.subviews) {
        [view removeFromSuperview];
    }
    
    BOOL changeBackgroundColor = FALSE;
    BOOL showBorder = TRUE;
    BOOL showIcon = TRUE;
    
    CGFloat width = 300, height = 200;
    CGFloat x = CGRectGetMidX(_adView.bounds) - width/2;
    CGFloat y = CGRectGetMidY(_adView.bounds) - height/2;
    
    PWAdsNativeAdView *adView = [[PWAdsNativeAdView alloc] initWithFrame:CGRectMake(x,y,width,height)];
    adView.delegate = self;
    adView.nativeAd = newAd;
    adView.tag = 82;
    
    if(changeBackgroundColor) {
        adView.backgroundColor = [UIColor lightGrayColor];
    }
    
    if(showBorder) {
        adView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        adView.layer.borderWidth = 1.0;
        adView.layer.cornerRadius = 10.0;
    }
    
    [_adView addSubview:adView];
    
    
    int startingPointX = 5;
    
    UILabel *sponsoredLabel = [[UILabel alloc] init];
    [sponsoredLabel setFrame:CGRectMake(startingPointX,0,290,20)];
    sponsoredLabel.textColor=[UIColor grayColor];
    sponsoredLabel.userInteractionEnabled=YES;
    sponsoredLabel.font = [UIFont italicSystemFontOfSize:11];
    
    NSString *usableString = self.sponsoredStrings[arc4random_uniform((int)[self.sponsoredStrings count])];
    sponsoredLabel.text = [usableString uppercaseString];
    
    sponsoredLabel.textAlignment = NSTextAlignmentRight;
    [adView addSubview:sponsoredLabel];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(startingPointX,10,300,20)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.userInteractionEnabled=YES;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.text = newAd.adTitle;
    [adView addSubview:titleLabel];
    
    if(newAd.adText) {
        UILabel *textLabel = [[UILabel alloc] init];
        [textLabel setFrame:CGRectMake(startingPointX,30,300,100)];
        textLabel.backgroundColor=[UIColor clearColor];
        textLabel.textColor=[UIColor blackColor];
        textLabel.userInteractionEnabled=YES;
        textLabel.font = [UIFont systemFontOfSize:8];
        textLabel.numberOfLines = 2;
        textLabel.text = newAd.adText;
        [textLabel sizeToFit];
        [adView addSubview:textLabel];
        //[textLabel addGestureRecognizer:tapGestureRecognizer];
    }
    
    if(newAd.adIconURL && showIcon) {
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(startingPointX, 40, 30, 30)];
        iconView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:newAd.adIconURL]]];
        [adView addSubview:iconView];
        startingPointX += 40;
    }
    
    for(int i=0; i < [newAd.adRating intValue]; i++) {
        CGRect ratingFrame = CGRectMake(startingPointX, 45, 20, 20);
        UIImageView *ratingView = [[UIImageView alloc] initWithFrame:ratingFrame];
        ratingView.image = [UIImage imageNamed:@"star"];
        startingPointX = startingPointX + 20;
        [adView addSubview:ratingView];
    }
    if ([newAd.adRating floatValue] > [newAd.adRating intValue]) {
        CGRect ratingFrame = CGRectMake(startingPointX, 45, 20, 20);
        UIImageView *ratingView = [[UIImageView alloc] initWithFrame:ratingFrame];
        ratingView.image = [UIImage imageNamed:@"halfstar"];
        startingPointX = startingPointX + 20;
        [adView addSubview:ratingView];
    }
    
    if(newAd.adCTA) {
        UILabel *CTALabel = [[UILabel alloc] init];
        [CTALabel setFrame:CGRectMake(220,45,70,25)];
        CTALabel.backgroundColor=[UIColor clearColor];
        CTALabel.textColor = [UIColor colorWithRed:0.110f green:0.647f blue:0.122f alpha:1.00f];
        CTALabel.userInteractionEnabled=YES;
        CTALabel.font = [UIFont boldSystemFontOfSize:12];
        CTALabel.numberOfLines = 1;
        CTALabel.text = [newAd.adCTA uppercaseString];
        CTALabel.layer.borderColor = [UIColor colorWithRed:0.110f green:0.647f blue:0.122f alpha:1.00f].CGColor;
        CTALabel.layer.borderWidth = 1.0;
        CTALabel.layer.cornerRadius = 2.5;
        CTALabel.adjustsFontSizeToFitWidth = TRUE;
        CTALabel.minimumScaleFactor = .75;
        CTALabel.textAlignment = NSTextAlignmentCenter;
        [adView addSubview:CTALabel];
        //[CTALabel addGestureRecognizer:tapGestureRecognizer];
    }
    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(40, 70, 220,123)];
    NSString *htmlString;
    
    if(newAd.adHTML) {
        if(changeBackgroundColor) {
            htmlString = [NSString stringWithFormat:@"<html><style>html{background-color:#AAA;}img{width:100%%; padding:0; margin:0;}</style>%@</html>", newAd.adHTML];
        } else {
            htmlString = [NSString stringWithFormat:@"<html><style>html{/*background-color:#AAA;*/}img{width:100%%; padding:0; margin:0;}</style>%@</html>", newAd.adHTML];
        }
        
        [webview loadHTMLString:htmlString baseURL:nil];
        webview.userInteractionEnabled = FALSE;
        webview.backgroundColor = [UIColor lightGrayColor];
        [adView addSubview:webview];
    }
}

- (void)showNativeAdNewsFeed:(PWAdsNativeAd *)newAd withYOffset:(int)offset {
    // Remove all subviews
    for (UIView *view in _adView.subviews) {
        [view removeFromSuperview];
    }
    
    BOOL showBorder = TRUE;
    BOOL showIcon = TRUE;
    
    CGFloat width = 300, height = 70;
    CGFloat x = CGRectGetMidX(_adView.bounds) - width/2;
    CGFloat y = CGRectGetMidY(_adView.bounds) - height/2;
    
    PWAdsNativeAdView *adView = [[PWAdsNativeAdView alloc] initWithFrame:CGRectMake(x,y,width,height)];
    adView.delegate = self;
    adView.nativeAd = newAd;
    
    if(showBorder) {
        adView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        adView.layer.borderWidth = 1.0;
    }
    
    adView.tag = offset+111;
    
    [_adView addSubview:adView];
    
    
    int startingPointX = 5;
    
    
    UILabel *sponsoredLabel = [[UILabel alloc] init];
    [sponsoredLabel setFrame:CGRectMake(startingPointX,0,290,20)];
    sponsoredLabel.textColor=[UIColor grayColor];
    sponsoredLabel.userInteractionEnabled=YES;
    sponsoredLabel.font = [UIFont italicSystemFontOfSize:11];
    
    NSString *usableString = self.sponsoredStrings[arc4random_uniform((int)[self.sponsoredStrings count])];
    sponsoredLabel.text = [usableString uppercaseString];
    
    sponsoredLabel.textAlignment = NSTextAlignmentRight;
    [adView addSubview:sponsoredLabel];
    
    if(newAd.adIconURL && showIcon) {
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(startingPointX, 10, 50, 50)];
        iconView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:newAd.adIconURL]]];
        [adView addSubview:iconView];
        startingPointX = startingPointX + 60;
    }
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(startingPointX,12,300,20)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.userInteractionEnabled=YES;
    titleLabel.font = [UIFont boldSystemFontOfSize:12];
    titleLabel.text = newAd.adTitle;
    [adView addSubview:titleLabel];
    
    for(int i=0; i < [newAd.adRating intValue]; i++) {
        CGRect ratingFrame = CGRectMake(startingPointX, 30, 20, 20);
        UIImageView *ratingView = [[UIImageView alloc] initWithFrame:ratingFrame];
        ratingView.image = [UIImage imageNamed:@"star"];
        startingPointX = startingPointX + 20;
        [adView addSubview:ratingView];
    }
    if ([newAd.adRating floatValue] > [newAd.adRating intValue]) {
        CGRect ratingFrame = CGRectMake(startingPointX, 30, 20, 20);
        UIImageView *ratingView = [[UIImageView alloc] initWithFrame:ratingFrame];
        ratingView.image = [UIImage imageNamed:@"halfstar"];
        startingPointX = startingPointX + 20;
        [adView addSubview:ratingView];
    }
    
    if(newAd.adCTA) {
        UILabel *CTALabel = [[UILabel alloc] init];
        [CTALabel setFrame:CGRectMake(220,30,70,25)];
        CTALabel.backgroundColor=[UIColor clearColor];
        CTALabel.textColor = [UIColor colorWithRed:0.110f green:0.647f blue:0.122f alpha:1.00f];
        CTALabel.userInteractionEnabled=YES;
        CTALabel.font = [UIFont boldSystemFontOfSize:12];
        CTALabel.numberOfLines = 1;
        CTALabel.text = [newAd.adCTA uppercaseString];
        CTALabel.layer.borderColor = [UIColor colorWithRed:0.110f green:0.647f blue:0.122f alpha:1.00f].CGColor;
        CTALabel.layer.borderWidth = 1.0;
        CTALabel.layer.cornerRadius = 2.5;
        CTALabel.adjustsFontSizeToFitWidth = TRUE;
        CTALabel.minimumScaleFactor = .75;
        CTALabel.textAlignment = NSTextAlignmentCenter;
        [adView addSubview:CTALabel];
        //[CTALabel addGestureRecognizer:tapGestureRecognizer];
    }
}


- (void)showNativeAdContentWall:(PWAdsNativeAd *)newAd {
    // Remove all subviews
    for (UIView *view in _adView.subviews) {
        [view removeFromSuperview];
    }
    
    BOOL changeBackgroundColor = FALSE;
    BOOL showBorder = TRUE;
    
    
    CGFloat width = 300, height = 200;
    CGFloat x = CGRectGetMidX(_adView.bounds) - width/2;
    CGFloat y = CGRectGetMidY(_adView.bounds) - height/2;
    
    PWAdsNativeAdView *adView = [[PWAdsNativeAdView alloc] initWithFrame:CGRectMake(x,y,width,height)];
    adView.delegate = self;
    adView.nativeAd = newAd;
    adView.tag = 82;
    
    if(changeBackgroundColor) {
        adView.backgroundColor = [UIColor lightGrayColor];
    }
    
    if(showBorder) {
        adView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        adView.layer.borderWidth = 1.0;
        adView.layer.cornerRadius = 10.0;
    }
    
    [_adView addSubview:adView];
    
    int startingPointX = 5;
    
    if(newAd.adHTML) {
        UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 300,175)];
        
        NSString *htmlString;
        if(changeBackgroundColor) {
            htmlString = [NSString stringWithFormat:@"<html><style>html{background-color:#AAA;}body{margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px;}img{width:100%%; padding:0; margin:0; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;}</style>%@</html>", newAd.adHTML];
        } else {
            htmlString = [NSString stringWithFormat:@"<html><style>html{/*background-color:#AAA;*/} body{margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px;} img{width:100%%; padding:0; margin:0; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;}</style>%@</html>", newAd.adHTML];
        }
        
        [webview loadHTMLString:htmlString baseURL:nil];
        webview.userInteractionEnabled = FALSE;
        webview.backgroundColor = [UIColor lightGrayColor];
        webview.layer.cornerRadius = 10.0;
        [webview setClipsToBounds:TRUE];
        [adView addSubview:webview];
    }
    
    UILabel *sponsoredLabel = [[UILabel alloc] init];
    [sponsoredLabel setFrame:CGRectMake(startingPointX,180,290,20)];
    sponsoredLabel.textColor=[UIColor grayColor];
    sponsoredLabel.userInteractionEnabled=YES;
    sponsoredLabel.font = [UIFont italicSystemFontOfSize:11];
    
    NSString *usableString = self.sponsoredStrings[arc4random_uniform((int)[self.sponsoredStrings count])];
    sponsoredLabel.text = [usableString uppercaseString];
    
    sponsoredLabel.textAlignment = NSTextAlignmentRight;
    [adView addSubview:sponsoredLabel];
    
}

- (void)showNativeAdAppWall:(NSArray *)nativeAds{
    int offset = 0;
    for (PWAdsNativeAd *ad in nativeAds) {
        [self showNativeAdNewsFeed:ad withYOffset:offset];
        offset = offset + 75;
    }
}

- (NSArray *)sponsoredStrings {
    return @[@"advertisement", @"sponsored", @"brought to you by", @"our sponsors", @"sponsored content", @"you may also like"];
}

@end
