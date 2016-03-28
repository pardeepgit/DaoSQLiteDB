//
//  DTSetttings.h
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/11/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTSynthesizeSingleton.h"
#import <CoreGraphics/CoreGraphics.h>


@interface DTSetttings : NSObject

- (CGFloat)schemaVersion;
- (void)storeSchemaVersion:(CGFloat)version;
- (void)removeSchemaVersion;

- (NSUUID *)sensorUUID;
- (void)storeSensorUUID:(NSUUID *)uuid;
- (void)removeSensorUUID;

@end

DECLARE_SINGLETON_FOR_CLASS(DTSetttings)