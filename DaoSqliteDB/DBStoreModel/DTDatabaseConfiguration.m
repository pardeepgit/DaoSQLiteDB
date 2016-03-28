//
//  DTDatabaseConfiguration.m
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 1/6/16.
//  Copyright © 2016 Coach Labs. All rights reserved.
//

#import "DTDatabaseConfiguration.h"

static NSString *const kDTDatabaseConfigFile = @"database";
static NSString *const kDTDatabaseConfigKeyVersion = @"version";
static NSString *const kDTDatabaseConfigKeySchema = @"schema";


@interface DTDatabaseConfiguration ()
@property (strong, nonatomic) NSDictionary *dbConfig;
@end


@implementation DTDatabaseConfiguration

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        // Read database configuration
        NSString *dbConfigFilePath = [[NSBundle mainBundle] pathForResource:kDTDatabaseConfigFile ofType:@"plist"];
        _dbConfig = [NSDictionary dictionaryWithContentsOfFile:dbConfigFilePath];
    }
    
    return self;
}

- (CGFloat)schemaVersion {

#if TEST
    return arc4random_uniform(1000000);
#else
    return [[self.dbConfig objectForKey:kDTDatabaseConfigKeyVersion] floatValue];
#endif
}

- (NSString *)schema {
    
    NSString *schemaFile = [self.dbConfig objectForKey:kDTDatabaseConfigKeySchema];
    NSString *schemaFilePath = [[NSBundle mainBundle] pathForResource:schemaFile
                                                               ofType:@"sql"];
    NSError *error = nil;
    NSString *query = [NSString stringWithContentsOfFile:schemaFilePath
                                                encoding:NSUTF8StringEncoding
                                                   error:&error];
    if (error) {
        NSLog(@"Reading SQL file failed %@", error);
        return nil;
    }
    
    return query;
}

@end
