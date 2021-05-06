//
//  MXSysAuthCheck.h
//  FBSnapshotTestCase
//
//  Created by maxiao on 2021/4/13.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    //系统禁用
    MXSysAuthStatusDisabled = -1,
    //用户拒绝
    MXSysAuthStatusDenied = 0,
    //用户已授权
    MXSysAuthStatusAuthorized = 1
} MXSysAuthStatus;

typedef enum : NSUInteger {
    MXSysAuthTypeAddressBook,
    MXSysAuthTypeBiology,
    MXSysAuthTypeBluetooth,
    MXSysAuthTypeLocation,
    MXSysAuthTypePhoto,
    MXSysAuthTypeCamera,
    MXSysAuthTypeMicrophone,
    MXSysAuthTypeNotification
} MXSysAuthType;

NS_ASSUME_NONNULL_BEGIN

@interface MXSysAuthCheck : NSObject

/// 检查权限是否开启
/// @param authType 权限类型
/// @param completedBlock 回调
+ (void)checkAuthWithType:(MXSysAuthType)authType completedBlock:(void (^)(int status))completedBlock;

@end

NS_ASSUME_NONNULL_END
