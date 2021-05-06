//
//  BiologyUtils.m
//  FBSnapshotTestCase
//
//  Created by maxiao on 2021/4/13.
//

#import "BiologyUtils.h"

#import <LocalAuthentication/LocalAuthentication.h>

@implementation BiologyUtils

+ (void)checkAuthWithCompletedBlock:(void (^)(int))completedBlock {
    __block void (^_checkAuthWithCompletedBlock)(int) = [completedBlock copy];
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    BOOL status = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (status && !error) {
        _checkAuthWithCompletedBlock(1);
        _checkAuthWithCompletedBlock = NULL;
        return;
    }
    _checkAuthWithCompletedBlock(0);
    _checkAuthWithCompletedBlock = NULL;
}


@end
