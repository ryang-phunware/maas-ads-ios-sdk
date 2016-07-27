//
//  NativeIconAdUnitView.m
//  PWAdvertising
//
//  Created by John Zhao on 5/2/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "NativeIconAdUnitView.h"
#import <PWAdvertising/PWAdsNativeAd.h>

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

@implementation NativeIconAdUnitView
{
    NSMutableArray *_nativeAdViews;
    NSTimer *_scheudledWobble;
}

-(void)addAnimationForView:(UIView *)view {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.X";
    animation.byValue =@(view.frame.size.width);
    animation.duration = 1;
    [view.layer addAnimation:animation forKey:@"basic"];
}

-(PWAdsNativeAdView *)createAdViewWithFrame:(CGRect)frame andAd:(PWAdsNativeAd *)nativeAd {
    PWAdsNativeAdView *nativeAdView = [[PWAdsNativeAdView alloc] initWithFrame:frame];
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    logoImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAd.adIconURL]]];
    [nativeAdView addSubview:logoImageView];
    return nativeAdView;
}

-(void)showIconAdUnit:(NSArray *)nativeAds {
    CGFloat width = 80, height = 80;
    CGFloat originalX = 10, originalY = 10;
    CGFloat gap = 10;
    CGFloat startX = - width;
    NSInteger index = 0;
    self.clipsToBounds = YES;
    _nativeAdViews = [NSMutableArray array];
    for (PWAdsNativeAd *ad in nativeAds) {
        PWAdsNativeAdView *nativeAdView = [self createAdViewWithFrame:CGRectMake(startX, originalY, width, height) andAd:ad];
        nativeAdView.delegate = _delegate;
        nativeAdView.nativeAd = ad;
        [self addSubview:nativeAdView];
        [_nativeAdViews addObject:nativeAdView];
        nativeAdView.transform = CGAffineTransformMakeRotation(RADIANS(90));
       [UIView animateWithDuration:0.8 delay:index*0.4 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
           nativeAdView.frame = CGRectMake(originalX, originalY, width, height);
           nativeAdView.transform = CGAffineTransformMakeRotation(RADIANS(0));
       } completion:nil];
        originalY += (gap + height);
        index += 1;
    }
    [self scheduleWobbleView];
}

-(void)scheduleWobbleView {
    _scheudledWobble = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(randomWobbleView) userInfo:nil repeats:NO];
}

-(void)randomWobbleView {
    if (_nativeAdViews.count > 0) {
        NSInteger random = arc4random() % _nativeAdViews.count;
        [self wobbledView:_nativeAdViews[random]];
        [_scheudledWobble invalidate];
        _scheudledWobble = nil;
        [self scheduleWobbleView];
    }
}

-(void)wobbledView:(UIView *)view {
    CGFloat degrees = 10.0;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1.0;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.values = @[@0.0, @(RADIANS(-degrees) * 0.3),
                         @0.0, @(RADIANS(degrees) * 0.6),
                         @0.0, @RADIANS(-degrees),
                         @0.0, @RADIANS(degrees),
                         @0.0, @(RADIANS(-degrees) * 0.6),
                         @0.0, @(RADIANS(degrees) * 0.3),
                         @0.0];
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = YES;
    [view.layer addAnimation:animation forKey:@"wobble"];
}

- (void)removeFromSuperview {
    [_scheudledWobble invalidate];
    _scheudledWobble = nil;
    [super removeFromSuperview];
}

@end
