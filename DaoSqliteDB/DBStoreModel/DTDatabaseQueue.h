//
//  DTDatabase.h
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/9/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "DTSynthesizeSingleton.h"

@interface DTDatabaseQueue : FMDatabaseQueue

@end

DECLARE_SINGLETON_FOR_CLASS(DTDatabaseQueue)