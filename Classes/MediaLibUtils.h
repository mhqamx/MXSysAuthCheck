//
//  MediaLibUtils.h
//  FBSnapshotTestCase
//
//  Created by maxiao on 2021/4/13.
//

#import "MXSysAuthUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface MediaLibUtils : MXSysAuthUtils

/// 检查相册是否授权
/// @param completedBlock 回调
+ (void)checkPhotoAuthWithCompletedBlock:(void (^)(int status))completedBlock;

/// 检查相册是否授权
/// @param completedBlock 回调
+ (void)checkCameraAuthWithCompletedBlock:(void (^)(int status))completedBlock;

/// 检查麦克风是否授权
/// @param completedBlock 回调
+ (void)checkMicrophoneAuthWithCompletedBlock:(void (^)(int status))completedBlock;

@end

NS_ASSUME_NONNULL_END
