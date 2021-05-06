//
//  NotificationUtils.m
//  FBSnapshotTestCase
//
//  Created by maxiao on 2021/4/13.
//

#import "NotificationUtils.h"

#import <UserNotifications/UserNotifications.h>

@implementation NotificationUtils

+ (void)checkAuthWithCompletedBlock:(void (^)(int))completedBlock{
    __block void (^_checkAuthCompletedBlock)(int) = [completedBlock copy];
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            _checkAuthCompletedBlock((granted && !error) ? 1:0);
            _checkAuthCompletedBlock = NULL;
        }];
    }else {
//        UIUserNotificationType type = [UIApplication sharedApplication].currentUserNotificationSettings.types;
//         _checkAuthCompletedBlock(UIUserNotificationTypeNone == type ? 1:0);
//         _checkAuthCompletedBlock = NULL;
    }
}

@end
