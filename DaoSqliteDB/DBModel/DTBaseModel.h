//
//  DTBaseModel.h
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/10/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTModelKeys.h"

@class FMResultSet;

@protocol ResultSetImportableObject <NSObject>

@required
- (void)importFromResultSet:(FMResultSet *)resultSet;

@end

@protocol JSONImportableObject <NSObject>

@optional
- (void)importFromJSON:(NSDictionary *)JSON;

@end
/**
 *  Key to get the property of the model that has invalid value
 */
extern NSString *const DTInvalidPropertyKey;

@interface DTBaseModel : NSObject <ResultSetImportableObject, JSONImportableObject>

@property (nonatomic, copy) NSNumber *ID;
@property (nonatomic, copy) NSDate *modified;
@property (nonatomic, copy) NSDate *created;

- (BOOL)validatewWithOutError:(NSError **)outError;

@end
