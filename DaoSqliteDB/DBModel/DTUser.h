//
//  DTUser.h
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/10/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#import "DTBaseModel.h"

/**
 *  Nilified object
 */
#define NilifedObject(obj) ((![obj isEqual:[NSNull null]]) ? obj : nil)


typedef NS_ENUM(NSInteger, Gender) {
    GenderUndefined = -1,
    GenderMale,
    GenderFemale
};

typedef NS_ENUM(NSInteger, DTTrainingUnit) {
    DTTrainingUnitDay = 0,
    DTTrainingUnitWeek,
    DTTrainingUnitMonth
};

@interface DTUser : DTBaseModel

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic) NSNumber *heighInInches;
@property (copy, nonatomic) NSNumber *heighInFeet;
@property (copy, nonatomic) NSNumber *weight;
@property (copy, nonatomic) NSNumber *age;
@property (copy, nonatomic) NSNumber *training_hours;
@property (assign, nonatomic) DTTrainingUnit training_units;
@property (assign, nonatomic) Gender gender;

- (void)copyFromObject:(DTUser *)user;

@end
