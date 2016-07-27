//
//  AdUnit.h
//  PWAdvertising
//
//  Created by Hari Kunwar on 4/15/16.
//  Copyright © 2016 Phunware, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AdType) {
    AdTypeUnknown = -1,
    AdTypeBanner = 1,
    AdTypeInterstitial = 2,
    AdTypeVideo = 3,
    AdTypeNative = 4,
    AdTypeLandingPage = 5
};

@interface AdUnit : NSObject

@property (nonatomic, assign) AdType adType;
@property (nonatomic, strong) NSString *adName;

- (instancetype)initWithAdType:(AdType)type name:(NSString *)name NS_DESIGNATED_INITIALIZER;
+ (NSArray *)ads;

@end
