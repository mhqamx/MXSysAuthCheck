//
//  BluetoothUtils.m
//  FBSnapshotTestCase
//
//  Created by maxiao on 2021/4/13.
//

#import "BluetoothUtils.h"

#import <CoreBluetooth/CoreBluetooth.h>

@interface BluetoothUtils ()<CBCentralManagerDelegate>

@property(nonatomic, strong)  CBCentralManager *manager;

@property(nonatomic, copy)  void (^checkAuthWithCompletedBlock)(int status);

@end

@implementation BluetoothUtils

- (instancetype)init {
    if (self = [super init]) {
        _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static BluetoothUtils *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BluetoothUtils alloc] init];
    });
    return instance;
}

+ (void)checkAuthWithCompletedBlock:(void (^)(int))completedBlock {
    [BluetoothUtils sharedInstance].checkAuthWithCompletedBlock = [completedBlock copy];
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    int state = 0;
    switch (central.state) {
        case CBManagerStateUnsupported:
        {
            state = -1;
        }
            break;
        case CBManagerStateUnauthorized:
        {
            state = 0;
        }
            break;
        default:
        {
            state = 1;
        }
            break;
    }
    if (self.checkAuthWithCompletedBlock) {
        self.checkAuthWithCompletedBlock(state);
    }
}

@end
