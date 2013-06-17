//
//  StackTDDTests.m
//  StackTDDTests
//
//  Created by Le Duy Thanh on 17/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "Kiwi.h"
#import "StackTDD.h"

SPEC_BEGIN(TestStackTDD)

describe(@"Test Stack TDD", ^{
    //__block StackTDD *stackTDD;
    
    context(@"Test operations with stack", ^{
        it(@"Test create a stack with size is 0", ^{
            StackTDD *stack = [[StackTDD alloc] init];
            NSNumber *sizeExpec = [NSNumber numberWithInt:0];
            [[[stack size] should] equal:sizeExpec];
        });
    });
});

SPEC_END
