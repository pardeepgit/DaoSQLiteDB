//
//  DTUser.m
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/10/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#import "DTUser.h"
#import "FMResultSet.h"

@interface DTUser ()

@end

@implementation DTUser

- (instancetype)init {

    self = [super init];
    if (self) {
        _gender = GenderUndefined;
        _training_hours = @0;
        _training_units = DTTrainingUnitDay;
    }
    
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"DTUser: ID=%@, name=%@, email=%@, height=%@'%@\", weight=%@, gender=%@, age=%@, training_hours=%@, training_units=%@, modified=%@, created=%@", self.ID, self.name, self.email, self.heighInFeet, self.heighInInches, self.weight, (self.gender) ? @"Male" : @"Female", self.age, self.training_hours, @(self.training_units), self.modified, self.created];
}

- (void)copyFromObject:(DTUser *)user {
    self.ID = user.ID;
    self.name = user.name;
    self.email = user.email;
    self.heighInInches = user.heighInInches;
    self.heighInFeet = user.heighInFeet;
    self.weight = user.weight;
    self.gender = user.gender;
    self.age = user.age;
    self.modified = user.modified;
    self.created = user.created;
    self.training_hours = user.training_hours;
    self.training_units = user.training_units;
}

- (void)importFromResultSet:(FMResultSet *)rs {
    
    [super importFromResultSet:rs];
    self.name = [rs stringForColumn:kDTUserKeyName];
    self.email = [rs stringForColumn:kDTUserKeyEmail];
    self.heighInInches = NilifedObject([rs objectForColumnName:kDTUserKeyHeightInInches]);
    self.heighInFeet = NilifedObject([rs objectForColumnName:kDTUserKeyHeightInFeet]);
    self.weight = NilifedObject([rs objectForColumnName:kDTUserKeyWeight]);
    self.age = NilifedObject([rs objectForColumnName:kDTUserKeyAge]);
    self.training_hours = NilifedObject([rs objectForColumnName:kDTUserKeyTrainingHours]);
    self.training_units = (DTTrainingUnit)[rs intForColumn:kDTUserKeyTrainingUnits];
    
    id gender = NilifedObject([rs objectForColumnName:kDTUserKeyGender]);
    if (!gender) {
        self.gender = GenderUndefined;
    }
    else {
        self.gender = (Gender)[gender intValue];
    }    
}


@end
