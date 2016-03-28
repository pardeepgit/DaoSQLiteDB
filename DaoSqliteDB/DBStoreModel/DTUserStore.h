//
//  DTUserStore.h
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/9/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#import "DTBaseStore.h"
#import "DTUser.h"

@interface DTUserStore : DTBaseStore

/**
 *  Gets a user with provided userID.
 */
- (DTUser *)userByID:(NSNumber *)userID;

/**
 *  Saves or updates a user.
 */
- (void)saveUser:(DTUser *)user
    onCompletion:(void(^)(BOOL result, NSError *error))completion;

/**
 *  Gets all users.
 */
- (NSArray *)allUsers;

/**
 *  Deletes an existing user.
 */
- (void)deleteUser:(DTUser *)user
      onCompletion:(void(^)(BOOL result, NSError *error))completion;

@end

DECLARE_SINGLETON_FOR_CLASS(DTUserStore)
