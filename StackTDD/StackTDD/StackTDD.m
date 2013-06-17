//
//  StackTDD.m
//  StackTDD
//
//  Created by Le Duy Thanh on 17/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StackTDD.h"

@implementation StackTDD

- (id)init {
    self = [super init];
    if (!self) {
        _stringArray = [[NSMutableString alloc] initWithCapacity:0];
    }
    return self;
}

- (NSNumber *)size {
    return [NSNumber numberWithInt:0];
}

@end
