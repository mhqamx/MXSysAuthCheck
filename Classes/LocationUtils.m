//
//  LocationUtils.m
//  FBSnapshotTestCase
//
//  Created by maxiao on 2021/4/13.
//

#import "LocationUtils.h"

#import <CoreLocation/CoreLocation.h>

@interface LocationUtils ()<CLLocationManagerDelegate>

/// 定位函数
@property(nonatomic, strong)  CLLocationManager *manager;

@property(nonatomic, copy)  void (^checkAuthWithCompletedBlock)(int state);

@end

@implementation LocationUtils

- (instancetype)init {
    if (self = [super init]) {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
    }
    return self;
}

+ (instancetype)sharedInstance {
    static LocationUtils *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LocationUtils alloc] init];
    });
    return instance;
}

+ (void)checkAuthWithCompletedBlock:(void (^)(int))completedBlock {
    void (^_checkAuthWithCompletedBlock)(int) = [completedBlock copy];
    if (![CLLocationManager locationServicesEnabled]) {
        _checkAuthWithCompletedBlock(-1);
        _checkAuthWithCompletedBlock = NULL;
        return;
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            [LocationUtils sharedInstance].checkAuthWithCompletedBlock = [completedBlock copy];
            [[LocationUtils sharedInstance].manager requestWhenInUseAuthorization];
        }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            _checkAuthWithCompletedBlock(-1);
            _checkAuthWithCompletedBlock = NULL;
        }
            break;
        case kCLAuthorizationStatusDenied:
        {
            _checkAuthWithCompletedBlock(0);
            _checkAuthWithCompletedBlock = NULL;
        }
            break;
            
        default:
        {
            _checkAuthWithCompletedBlock(1);
            _checkAuthWithCompletedBlock = NULL;
        }
            break;
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"询问定位是否开启");
        }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            self.checkAuthWithCompletedBlock(-1);
            self.checkAuthWithCompletedBlock = NULL;
        }
            break;
        case kCLAuthorizationStatusDenied:
        {
            self.checkAuthWithCompletedBlock(0);
            self.checkAuthWithCompletedBlock = NULL;
        }
            break;
            
        default:
        {
            self.checkAuthWithCompletedBlock(1);
            self.checkAuthWithCompletedBlock = NULL;
        }
            break;
    }
}
- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            
        }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            self.checkAuthWithCompletedBlock(-1);
            self.checkAuthWithCompletedBlock = NULL;
        }
            break;
        case kCLAuthorizationStatusDenied:
        {
            self.checkAuthWithCompletedBlock(0);
            self.checkAuthWithCompletedBlock = NULL;
        }
            break;
            
        default:
        {
            self.checkAuthWithCompletedBlock(1);
            self.checkAuthWithCompletedBlock = NULL;
        }
            break;
    }
}

@end
