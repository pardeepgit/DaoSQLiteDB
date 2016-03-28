//
//  DTBaseStore.m
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/9/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#import "DTBaseStore.h"
#import "DTDatabaseConfiguration.h"
#import "DTDatabaseQueries.h"
#import "DTBaseModel.h"
#import "DTSetttings.h"

@implementation DTBaseStore

- (instancetype)init {
    self = [super init];
    if (self) {
        _databaseQueue = [DTDatabaseQueue sharedInstance];
        _database = [FMDatabase databaseWithPath:[_databaseQueue path]];
    }
    
    return self;
}


+ (void)migrateDatabase {
    
    CGFloat oldVersion = [[DTSetttings sharedInstance] schemaVersion];
    
    // Read database configuration
    DTDatabaseConfiguration *dbConfig = [[DTDatabaseConfiguration alloc] init];
    CGFloat newVersion = [dbConfig schemaVersion];
    if (newVersion != oldVersion) {
        
        // Read from the SQL file.
        NSString *query = [dbConfig schema];
        if (!query) {
            return;
        }
        
        FMDatabase *database = [FMDatabase databaseWithPath:[[DTDatabaseQueue sharedInstance] path]];
        if (![database open]) {
            NSLog(@"Migration: Opening database failed");
            return;
        }
        
        if ([database executeStatements:query]) {
            [[DTSetttings sharedInstance] storeSchemaVersion:newVersion];
        }
        else {
            NSLog(@"Migration: Executing SQL failed %@", [database lastErrorMessage]);
        }
        
        NSLog(@"Migration succeeded");
        [database close];
    }
}


- (DTBaseModel *)instanceByID:(NSNumber *)ID {
    
    if (![self.database open]) {
        return nil;
    }
    
    NSString *query = [NSString stringWithFormat:kDTQueryObjectByID, self.tableName];
    FMResultSet *rs = [self.database executeQuery:query, ID];
    DTBaseModel *object = nil;
    
    while ([rs next]) {
        object = (DTBaseModel *)[[NSClassFromString(self.modelName) alloc] init];
        [object importFromResultSet:rs];
        break;
    }
    
    [self.database close];
    
    return object;
}

@end
