//
//  Native3UpAdUnitView.m
//  PWAdvertising
//
//  Created by John Zhao on 4/29/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "Native3UpAdUnitView.h"
#import <PWAdvertising/PWAdsNativeAd.h>

@implementation Native3UpAdUnitView {
    NSArray *_nativeAds;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI {
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.layer setBorderWidth:1.5f];
    self.layer.cornerRadius = 5.0;
    UILabel *sponsoredLabel = [[UILabel alloc] init];
    [sponsoredLabel setFrame:CGRectMake(0,8,280,20)];
    sponsoredLabel.textColor=[UIColor grayColor];
    sponsoredLabel.font = [UIFont systemFontOfSize:11.0];
    NSString *usableString = self.sponsoredStrings[arc4random_uniform((u_int32_t)[self.sponsoredStrings count])];
    sponsoredLabel.text = [usableString uppercaseString];
    sponsoredLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:sponsoredLabel];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createUI];
    }
    return self;
}

-(PWAdsNativeAdView *)createAdViewWithFrame:(CGRect)frame andAd:(PWAdsNativeAd *)nativeAd {
    PWAdsNativeAdView *nativeAdView = [[PWAdsNativeAdView alloc] initWithFrame:frame];
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    logoImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAd.adIconURL]]];
    logoImageView.layer.cornerRadius = 10.0;
    logoImageView.layer.masksToBounds = YES;
    [nativeAdView addSubview:logoImageView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 80, 30)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    titleLabel.numberOfLines = 0;
    titleLabel.text = nativeAd.adTitle;
    [nativeAdView addSubview:titleLabel];
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 80, 20)];
    descriptionLabel.backgroundColor=[UIColor clearColor];
    descriptionLabel.textColor=[UIColor grayColor];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.font = [UIFont systemFontOfSize:11.0];
    descriptionLabel.text = nativeAd.adText;
    [descriptionLabel sizeToFit];
    [nativeAdView addSubview:descriptionLabel];
    UILabel *CATLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,150,80,20)];
    CATLabel.backgroundColor = [UIColor whiteColor];
    CATLabel.textColor = [UIColor blueColor];
    CATLabel.userInteractionEnabled=YES;
    CATLabel.font = [UIFont boldSystemFontOfSize:11.0];
    CATLabel.numberOfLines = 1;
    CATLabel.layer.masksToBounds = YES;
    CATLabel.layer.borderWidth = 1.0;
    CATLabel.layer.cornerRadius = 2.5;
    CATLabel.layer.borderColor = [[UIColor blueColor] CGColor];
    CATLabel.adjustsFontSizeToFitWidth = TRUE;
    CATLabel.minimumScaleFactor = .75;
    CATLabel.textAlignment = NSTextAlignmentCenter;
    CATLabel.text = [nativeAd.adCTA uppercaseString];
    [nativeAdView addSubview:CATLabel];
    return nativeAdView;
}

-(void)show3UpAdUnit:(NSArray *)nativeAds layoutType:(NativeAdHorizontalAligment)aligment {
    if (nativeAds.count >0) {
        _nativeAds = nativeAds;
        CGFloat width = 100;
        CGFloat height = 200;
        CGFloat originalX = 0;
        CGFloat originalY = 20;
        CGFloat gap = 0;
        if (nativeAds.count < 3) {
            switch (aligment) {
                case NativeAdHorizontalAligmentLeft:
                    break;
                case NativeAdHorizontalAligmentCenter:
                {
                    NSInteger count = nativeAds.count;
                    gap = (300 - width * count) / (count + 1);
                    originalX = gap;
                }
                    break;
                case NativeAdHorizontalAligmentRight:
                {
                    NSInteger count = nativeAds.count;
                    originalX = (count == 1) ? 200 : 100;
                }
                    break;
                default:
                    break;
            }
        }
        int current = 0;
        for (PWAdsNativeAd *ad in nativeAds) {
            current += 1;
            if (current > 3) {
                break;
            }
            PWAdsNativeAdView *nativeAdView = [self createAdViewWithFrame:CGRectMake(originalX, originalY, width, height) andAd:ad];
            nativeAdView.delegate = _delegate;
            nativeAdView.nativeAd = ad;
            [self addSubview:nativeAdView];
            originalX += (width + gap);
        }
    }
}

- (NSArray *)sponsoredStrings {
    return @[@"advertisement", @"sponsored", @"brought to you by", @"our sponsors", @"sponsored content", @"you may also like"];
}

@end
