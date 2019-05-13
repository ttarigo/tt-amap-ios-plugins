//
//  WXMapSearchModule.m
//  WeexDemo
//
//  Created by lidong on 2018/3/1.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "WXMapSearchModule.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface WXMapSearchModule () <AMapSearchDelegate>

@property (nonatomic, strong) AMapSearchAPI* api;
@property (nonatomic, strong) WXModuleKeepAliveCallback callback;

@end

@implementation WXMapSearchModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(search:city:options:callback:))
WX_EXPORT_METHOD(@selector(unsearch))

- (void)unsearch{
    if (self.api) self.api = nil;
    if (self.callback) self.callback = nil;
}

- (void)search:(NSString *)text city:(NSString *)city options:(NSDictionary *)options callback:(WXModuleKeepAliveCallback)callback
{
    self.callback = callback;
    if (!self.api) {
        [AMapServices sharedServices].apiKey = [options[@"sdkKey"] objectForKey:@"ios"] ? : @"";
        self.api = [[AMapSearchAPI alloc] init];
        self.api.delegate = self;
    }
    AMapInputTipsSearchRequest *request = [[AMapInputTipsSearchRequest alloc] init];
    request.keywords = text;
    request.city = city;
    [self.api AMapInputTipsSearch:request];
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    if (self.callback) {
        self.callback(@{@"result":@"failed",@"data":@"查询出错"}, NO);
        self.callback = nil;
    }
    if (self.api) self.api = nil;
}

- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    if (self.callback) {
        
        NSMutableArray * arr = [NSMutableArray array];
        for (AMapTip *tip in response.tips) {
            
            [arr addObject:@{
              @"name" : tip.name,
              @"district" : tip.district,
              @"uid": tip.uid,
              @"adcode" : tip.adcode,
              @"address" : tip.address,
              @"location" : @{
                      @"longitude" : [NSString stringWithFormat:@"%f", tip.location.longitude],
                      @"latitude" : [NSString stringWithFormat:@"%f",  tip.location.latitude]
                               }
              }];
        }
        
        self.callback(@{@"result":@"success",@"data":arr}, NO);
    }
}

@end
