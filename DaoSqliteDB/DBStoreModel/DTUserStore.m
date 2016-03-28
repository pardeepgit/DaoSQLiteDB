//
//  DTUserStore.m
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/9/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#import "DTUserStore.h"
#import "DTUser.h"

SYNTHESIZE_SINGLETON_FOR_CLASS(DTUserStore)

@interface DTUserStore ()

@property (strong, nonatomic) NSMutableSet *userIDs;
- (void)cacheAllUserIDs;
@end

@implementation DTUserStore

- (instancetype)init {

    self = [super init];
    if (self) {
        _userIDs = [NSMutableSet set];
        [self cacheAllUserIDs];
    }
    
    return self;
}

- (NSString *)tableName {
    return @"users";
}

- (NSString *)modelName {
    return @"DTUser";
}

- (void)cacheAllUserIDs {
    
    if (![self.database open]) {
        return;
    }
    
    FMResultSet *rs = [self.database executeQuery:kDTQueryAllUserIDs];
    while ([rs next]) {
        
        NSInteger ID = [rs intForColumn:kDTCommonKeyID];
        [self.userIDs addObject:@(ID)];
    }
    
    [self.database close];
}

- (void)getAllUsersOnCompletion:(void (^)(NSArray *users))completion {
    
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *rs = [db executeQuery:kDTQueryAllUsers];
        
        NSMutableArray *users = [NSMutableArray array];
        while ([rs next]) {
            // Build model
            DTUser *user = [[DTUser alloc] init];
            [user importFromResultSet:rs];
            [users addObject:user];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion([users copy]);
        });
    }];
}

- (NSArray *)allUsers {
    
    if (![self.database open]) {
        return nil;
    }
    
    FMResultSet *rs = [self.database executeQuery:kDTQueryAllUsers];
    NSMutableArray *users = [NSMutableArray array];
    while ([rs next]) {
        // Build model
        DTUser *user = [[DTUser alloc] init];
        [user importFromResultSet:rs];
        [users addObject:user];
    }
    [self.database close];
    
    return [users copy];
}

- (DTUser *)userByID:(NSNumber *)userID {
    
    if (![self.database open]) {
        return nil;
    }
    
    FMResultSet *rs = [self.database executeQuery:kDTQueryUserByID, userID];
    DTUser *user = nil;
    while ([rs next]) {
        user = [[DTUser alloc] init];
        [user importFromResultSet:rs];
    }
    
    [self.database close];
    
    return user;
}

- (void)saveUser:(DTUser *)user onCompletion:(void (^)(BOOL, NSError *))completion {
    
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
        BOOL result;
        NSNumber *ID = user.ID;
        
        id gender = [NSNull null];
        if (user.gender != GenderUndefined) {
            gender = @(user.gender);
        }
        
        
        if (user.ID > 0) {
            result = [db executeUpdate:kDTQueryUpdateUser, user.name, user.email, @"heighInInches", @"heightInFeet",  @"weight", gender, @"age", user.training_hours, @(user.training_units), @"date", ID];
        }
        else {
            ID = @([[self.userIDs valueForKeyPath:@"@max.self"] integerValue] + 1);
            result = [db executeUpdate:kDTQueryAddUser, ID, user.name, user.email, @"heighInInches", @"heightInFeet", @"weight", gender, @"age", user.training_hours, @(user.training_units)];
        }
        
        NSError *error = nil;
        if (result) {
            // Update ID list
            [self.userIDs addObject:ID];
            // Update the user object
            DTUser *newUser = [self userByID:ID];
            [user copyFromObject:newUser];
        }
        else {
            error = [db lastError];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(result, error);
        });
    }];
}

- (void)deleteUser:(DTUser *)user
      onCompletion:(void (^)(BOOL, NSError *))completion {
    
    [self.databaseQueue inDatabase:^(FMDatabase *db) {        
        [db executeUpdate:kDTQueryDeleteSwingsByUser, user.ID];
        [db executeUpdate:kDTQueryDeleteSessionsByUser, user.ID];
        BOOL result = [db executeUpdate:kDTQueryDeleteUserByID, user.ID];
        NSError *error = nil;
        if (!result) {
            error = [db lastError];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(result, error);
        });
    }];
}

- (NSArray *)mockUsers {
    
    DTUser *user1 = [[DTUser alloc] init];
    user1.name = @"Hung Pham";
    
    DTUser *user2 = [[DTUser alloc] init];
    user2.name = @"Phuong Le";
    
    return @[user1];
}

@end
