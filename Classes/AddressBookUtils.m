//
//  AddressBookUtils.m
//  FBSnapshotTestCase
//
//  Created by maxiao on 2021/4/13.
//

#import "AddressBookUtils.h"

#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

@implementation AddressBookUtils

+ (void)checkAddressBookAuthWithCompletedBlock:(void (^)(int))completedBlock {
    __block void (^_checkAddressBookAuthCompletedBlock)(int) = [completedBlock copy];
    if (@available(iOS 9.0, *)) {
        //9.0以上
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusNotDetermined:
            {
                //未授权
                CNContactStore *contactStore = [[CNContactStore alloc] init];
                [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!error && granted) {
                            _checkAddressBookAuthCompletedBlock(1);
                            _checkAddressBookAuthCompletedBlock = NULL;
                        }else{
                            _checkAddressBookAuthCompletedBlock(0);
                            _checkAddressBookAuthCompletedBlock = NULL;
                        }
                    });
                }];
            }
                break;
            case CNAuthorizationStatusAuthorized:
            {
                _checkAddressBookAuthCompletedBlock(1);
                _checkAddressBookAuthCompletedBlock = NULL;
            }
                break;
            case CNAuthorizationStatusRestricted:
            {
                _checkAddressBookAuthCompletedBlock(-1);
                _checkAddressBookAuthCompletedBlock = NULL;
            }
                break;
            default:
            {
                _checkAddressBookAuthCompletedBlock(0);
                _checkAddressBookAuthCompletedBlock = NULL;
            }
                break;
        }
    }else{
        //9.0以前
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
            case kABAuthorizationStatusNotDetermined:
            {
                //未授权
                ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
                ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!error && granted) {
                            _checkAddressBookAuthCompletedBlock(1);
                            _checkAddressBookAuthCompletedBlock = NULL;
                        }else{
                            _checkAddressBookAuthCompletedBlock(0);
                            _checkAddressBookAuthCompletedBlock = NULL;
                        }
                    });
                });
            }
                break;
            case kABAuthorizationStatusRestricted:
            {
                _checkAddressBookAuthCompletedBlock(-1);
                _checkAddressBookAuthCompletedBlock = NULL;
            }
                break;
            case kABAuthorizationStatusAuthorized:
            {
                _checkAddressBookAuthCompletedBlock(1);
                _checkAddressBookAuthCompletedBlock = NULL;
            }
                break;
                
            default:
            {
                _checkAddressBookAuthCompletedBlock(0);
                _checkAddressBookAuthCompletedBlock = NULL;
            }
                break;
        }
    }
}


@end
