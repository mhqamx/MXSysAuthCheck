//
//  MXSysAuthUtils.h
//  FBSnapshotTestCase
//
//  Created by maxiao on 2021/4/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXSysAuthUtils : NSObject

/// 检查是否授权
/// @param completedBlock 回调
+ (void)checkAuthWithCompletedBlock:(void (^)(int status))completedBlock;

@end

NS_ASSUME_NONNULL_END
