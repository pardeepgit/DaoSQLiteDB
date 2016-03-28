//
//  DTSetttings.m
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/11/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#import "DTSetttings.h"

static NSString *const kDTSettingKeySchemaVersion = @"kDTSettingKeySchemaVersion";
static NSString *const kDTSettingKeySensorUUID = @"kDTSettingKeySensorUUID";

SYNTHESIZE_SINGLETON_FOR_CLASS(DTSetttings)

@implementation DTSetttings

- (CGFloat)schemaVersion {
    
    return [[NSUserDefaults standardUserDefaults] floatForKey:kDTSettingKeySchemaVersion];
}

- (void)storeSchemaVersion:(CGFloat)version {
    
    [[NSUserDefaults standardUserDefaults] setFloat:version
                                             forKey:kDTSettingKeySchemaVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeSchemaVersion {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDTSettingKeySchemaVersion];
}

#pragma mark - Sensor UUID

- (void)storeSensorUUID:(NSUUID *)uuid {
    
    [[NSUserDefaults standardUserDefaults] setObject:[uuid UUIDString]
                                             forKey:kDTSettingKeySensorUUID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSUUID *)sensorUUID {
    
    NSString *uuidString = [[NSUserDefaults standardUserDefaults] stringForKey:kDTSettingKeySensorUUID];
    
    if (uuidString) {
        return [[NSUUID alloc] initWithUUIDString:uuidString];
    }
    return nil;
}

- (void)removeSensorUUID {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDTSettingKeySensorUUID];
}

@end
