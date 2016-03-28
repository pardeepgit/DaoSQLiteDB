//
//  DTSynthesizeSingleton.h
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/9/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#ifndef DuoTrac_DTSynthesizeSingleton_h
#define DuoTrac_DTSynthesizeSingleton_h


#define DECLARE_SINGLETON_FOR_CLASS(classname) \
\
@interface classname (Singleton) \
\
+ (instancetype)sharedInstance; \
\
@end


#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
@implementation classname (Singleton) \
\
+ (instancetype)sharedInstance { \
static classname *instance = nil; \
static dispatch_once_t time = 0; \
dispatch_once(&time, ^{    \
instance = [[self alloc] init]; \
}); \
\
return instance; \
} \
@end

#endif
