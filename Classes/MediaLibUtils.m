//
//  MediaLibUtils.m
//  FBSnapshotTestCase
//
//  Created by maxiao on 2021/4/13.
//

#import "MediaLibUtils.h"

#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>

@implementation MediaLibUtils

+ (void)checkAuthWithCompletedBlock:(void (^)(int))completedBlock {}

+ (void)checkPhotoAuthWithCompletedBlock:(void (^)(int))completedBlock {
    __block void (^_checkPhotoAuthCompletedBlock)(int) = [completedBlock copy];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusNotDetermined:
            {
                NSLog(@"询问相册权限是否开启");
            }
                break;
            case PHAuthorizationStatusRestricted:
            {
                _checkPhotoAuthCompletedBlock(-1);
                _checkPhotoAuthCompletedBlock = NULL;
            }
                break;
            case PHAuthorizationStatusDenied:
            {
                _checkPhotoAuthCompletedBlock(0);
                _checkPhotoAuthCompletedBlock = NULL;
            }
                break;
            default:
            {
                _checkPhotoAuthCompletedBlock(1);
                _checkPhotoAuthCompletedBlock = NULL;
            }
                break;
        }
    }];
}

+ (void)checkCameraAuthWithCompletedBlock:(void (^)(int))completedBlock {
    __block void (^_checkCameraAuthCompletedBlock)(int) = [completedBlock copy];
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        _checkCameraAuthCompletedBlock(granted ? 1:0);
        _checkCameraAuthCompletedBlock = NULL;
    }];
}

+ (void)checkMicrophoneAuthWithCompletedBlock:(void (^)(int))completedBlock {
    __block void (^_checkMicrophoneAuthCompletedBlock)(int) = [completedBlock copy];
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        _checkMicrophoneAuthCompletedBlock(granted ? 1:0);
        _checkMicrophoneAuthCompletedBlock = NULL;
    }];
}

@end
