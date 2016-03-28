//
//  DTBaseStore.h
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/9/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "DTDatabaseQueue.h"
#import "DTDatabaseQueries.h"

@class DTBaseModel;
@class FMResultSet;

@interface DTBaseStore : NSObject

@property (strong, nonatomic) DTDatabaseQueue *databaseQueue;
@property (strong, nonatomic) FMDatabase *database;

@property (readonly, nonatomic) NSString *tableName;
@property (readonly, nonatomic) NSString *modelName;

+ (void)migrateDatabase;

- (DTBaseModel *)instanceByID:(NSNumber *)ID;

@end
