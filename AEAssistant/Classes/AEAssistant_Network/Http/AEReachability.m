//
//  AEReachability.m
//  AEAssistant
//
//  Created by Qian Ye on 16/4/22.
//  Copyright © 2016年 StarDust. All rights reserved.
//

#import "AEReachability.h"
#import <AEAssistant_Network.h>

static AEReachability *_sharedManager = nil;

@interface AEReachability ()

@property (nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;

@end

@implementation AEReachability
@synthesize domain;
@synthesize isNetworkStatusOK = _isNetworkStatusOK;
@synthesize reachabilityManager;
@synthesize status = _status;

- (id)init
{
    self = [super init];
    if (self) {
        //默认有效,因为监控开始时网络状态未知
        _isNetworkStatusOK = YES;
    }
    
    return self;
}



+ (instancetype)sharedInstance
{
    static dispatch_once_t predicate = 0;
    
    dispatch_once(&predicate, ^ (void) {
        _sharedManager = [[AEReachability alloc] init];
    });
    
    return _sharedManager;
}



- (void)startNetworkMonitoringWithStatusChangeBlock:(void (^)(AENetworkStatus))block
{
    //初始化网络状态监控
    if (self.domain && ![self.domain isEqualToString:@""]) {
        self.reachabilityManager = [AFNetworkReachabilityManager managerForDomain:self.domain];
    } else {
        self.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    }
    [self.reachabilityManager startMonitoring];
    
    __weak typeof(self) weakSelf = self;
    [weakSelf.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        AENetworkStatus netStatus = AENetworkStatusUnknown;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                _isNetworkStatusOK = NO;
                _status = AENetworkStatusUnknown;
                netStatus = AENetworkStatusUnknown;
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                _isNetworkStatusOK = NO;
                _status = AENetworkStatusNotReachable;
                netStatus = AENetworkStatusNotReachable;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                _isNetworkStatusOK = YES;
                //os version > 7.0
                CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
                NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;
                if (currentRadioAccessTechnology) {
                    if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                        _status = AENetworkStatusCellType4G;
                        netStatus = AENetworkStatusCellType4G;
                    } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
                        _status = AENetworkStatusCellType2G;
                        netStatus = AENetworkStatusCellType2G;
                    } else {
                        _status = AENetworkStatusCellType3G;
                        netStatus = AENetworkStatusCellType3G;
                    }
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                _isNetworkStatusOK = YES;
                _status = AENetworkStatusReachableViaWiFi;
                netStatus = AENetworkStatusReachableViaWiFi;
            }
                break;
            default:
                break;
        }
        
        if (block) {
            block(netStatus);
        }
    }];
    
}


- (void)stopNetworkStatusMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    
    _isNetworkStatusOK = NO;
}

@end
