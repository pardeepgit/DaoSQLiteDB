//
//  DTDatabaseConfiguration.h
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 1/6/16.
//  Copyright © 2016 Coach Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface DTDatabaseConfiguration : NSObject

/**
 *  Returns the current database schema version of the app.
 *
 *  @return Schema version.
 */
- (CGFloat)schemaVersion;

/**
 *  Returns the current database schema of the app.
 *
 *  @return Database schema.
 */
- (NSString *)schema;

@end
