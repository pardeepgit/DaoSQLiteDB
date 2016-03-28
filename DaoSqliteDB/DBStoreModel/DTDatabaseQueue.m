//
//  DTDatabase.m
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/9/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#import "DTDatabaseQueue.h"

static NSString *const kDTDataFileName = @"pcjs.sqlite";
SYNTHESIZE_SINGLETON_FOR_CLASS(DTDatabaseQueue)


@implementation DTDatabaseQueue

+ (NSString *)dataFilePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataFilePath = [documentsDirectory stringByAppendingPathComponent:kDTDataFileName];
    
    NSLog(@"Data file path: %@", dataFilePath);
    return dataFilePath;
}

- (instancetype)init {

    self = [super initWithPath:[[self class] dataFilePath]];
    return self;
}

@end
