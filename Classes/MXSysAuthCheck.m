//
//  MXSysAuthCheck.m
//  FBSnapshotTestCase
//
//  Created by maxiao on 2021/4/13.
//

#import "MXSysAuthCheck.h"

#import "AddressBookUtils.h"
#import "BiologyUtils.h"
#import "BluetoothUtils.h"
#import "LocationUtils.h"
#import "MediaLibUtils.h"
#import "NotificationUtils.h"

@implementation MXSysAuthCheck

+ (void)checkAuthWithType:(MXSysAuthType)authType completedBlock:(void (^)(int))completedBlock {
    switch (authType) {
        case MXSysAuthTypeAddressBook:
        {
            [AddressBookUtils checkAuthWithCompletedBlock:[completedBlock copy]];
        }
            break;
        case MXSysAuthTypeBiology:
        {
            [BiologyUtils checkAuthWithCompletedBlock:[completedBlock copy]];
        }
            break;
        case MXSysAuthTypeBluetooth:
        {
            [BluetoothUtils checkAuthWithCompletedBlock:[completedBlock copy]];
        }
            break;
        case MXSysAuthTypeLocation:
        {
            [LocationUtils checkAuthWithCompletedBlock:[completedBlock copy]];
        }
            break;
        case MXSysAuthTypePhoto:
        {
            [MediaLibUtils checkPhotoAuthWithCompletedBlock:[completedBlock copy]];
        }
            break;
        case MXSysAuthTypeCamera:
        {
            [MediaLibUtils checkCameraAuthWithCompletedBlock:[completedBlock copy]];
        }
            break;
        case MXSysAuthTypeMicrophone:
        {
            [MediaLibUtils checkMicrophoneAuthWithCompletedBlock:[completedBlock copy]];
        }
            break;
        case MXSysAuthTypeNotification:
        {
            [NotificationUtils checkAuthWithCompletedBlock:[completedBlock copy]];
        }
            break;
        default:
            break;
    }
}

@end
