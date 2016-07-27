//
//  NativeCleanAdUnitView.m
//  PWAdvertising
//
//  Created by John on 4/28/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "NativeCleanAdUnitView.h"
#import <PWAdvertising/PWAdsNativeAd.h>
@implementation NativeCleanAdUnitView {
    UILabel *_titleLabel;
    UILabel *_descriptionLabel;
    UIImageView *_logoImage;
    UILabel *_CATLabel;
}

-(void)loadUI {
    _logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [self addSubview:_logoImage];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 230, 20)];
    _titleLabel.backgroundColor=[UIColor clearColor];
    _titleLabel.textColor=[UIColor blackColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [self addSubview:_titleLabel];
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 28, 130, 30)];
    _descriptionLabel.backgroundColor=[UIColor clearColor];
    _descriptionLabel.textColor=[UIColor grayColor];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.font = [UIFont systemFontOfSize:11.0];
    [self addSubview:_descriptionLabel];
    _CATLabel = [[UILabel alloc] initWithFrame:CGRectMake(200,36,90,25)];
    UIColor *green = [UIColor colorWithRed:46./250. green:206./250. blue:113./250. alpha:1.00f];
    _CATLabel.backgroundColor = green;
    _CATLabel.textColor = [UIColor whiteColor];
    _CATLabel.userInteractionEnabled=YES;
    _CATLabel.font = [UIFont boldSystemFontOfSize:12];
    _CATLabel.numberOfLines = 1;
    _CATLabel.layer.masksToBounds = YES;
    _CATLabel.layer.borderWidth = 1.0;
    _CATLabel.layer.cornerRadius = 2.5;
    _CATLabel.layer.borderColor = [green CGColor];
    _CATLabel.adjustsFontSizeToFitWidth = TRUE;
    _CATLabel.minimumScaleFactor = .75;
    _CATLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_CATLabel];
    self.backgroundColor = [UIColor whiteColor];
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.layer setBorderWidth:1.5f];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
    self.layer.cornerRadius = 5.0;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self loadUI];
    }
    return self;
}

-(void)showCleanAdUnit:(PWAdsNativeAd *)nativeAd; {
    self.nativeAd = nativeAd;
    _titleLabel.text = nativeAd.adTitle;
    _logoImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAd.adIconURL]]];
    _descriptionLabel.text = nativeAd.adText;
    _CATLabel.text = [nativeAd.adCTA uppercaseString];
    [_descriptionLabel sizeToFit];
}

@end
