//
//  DTBaseModel.m
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/10/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#import "DTBaseModel.h"
#import "FMResultSet.h"

NSString *const DTInvalidPropertyKey = @"DTInvalidPropery";

@implementation DTBaseModel

- (BOOL)validatewWithOutError:(NSError *__autoreleasing *)outError {
    
    if (outError != NULL) {
        *outError = nil;
    }
    return YES;
}

- (void)importFromResultSet:(FMResultSet *)rs {
    
    self.ID = [rs objectForColumnName:kDTCommonKeyID];
}

@end
