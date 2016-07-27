//
//  AdUnit.m
//  PWAdvertising
//
//  Created by Hari Kunwar on 4/15/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import "AdUnit.h"

@implementation AdUnit

- (instancetype)init {
    return [self initWithAdType:AdTypeUnknown name:nil];
}

- (instancetype)initWithAdType:(AdType)type name:(NSString *)name {
    if (self = [super init]) {
        self.adType = type;
        self.adName = name;
    }
    
    return self;
}

+ (NSArray *)ads {
    AdUnit *bannerAd =  [[AdUnit alloc]initWithAdType:AdTypeBanner name:@"Banner Ad"];
    AdUnit *interstitialAd =  [[AdUnit alloc]initWithAdType:AdTypeInterstitial name:@"Interstitial Ad"];
    AdUnit *videoAd =  [[AdUnit alloc]initWithAdType:AdTypeVideo name:@"Video Ad"];
    AdUnit *nativeAd =  [[AdUnit alloc]initWithAdType:AdTypeNative name:@"Native Ad"];
    AdUnit *landingAd = [[AdUnit alloc]initWithAdType:AdTypeLandingPage name:@"Landing Page Ad"];
    return @[bannerAd, interstitialAd, videoAd, nativeAd, landingAd];
}


@end
