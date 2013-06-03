//
//  StringCalculatorDay6Tests.m
//  StringCalculatorDay6Tests
//
//  Created by Le Duy Thanh on 03/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StringCalculatorDay6Tests.h"
#import "StringCalculator.h"

@implementation StringCalculatorDay6Tests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    
}

- (void)testAddFunction {
    STAssertEquals(1, 1, nil);
    STAssertEquals([StringCalculator add:@""] , 0, nil);
    STAssertEquals([StringCalculator add:@"1"] , 1, nil);
    STAssertEquals([StringCalculator add:@"1,2"], 3, nil);
    STAssertEquals([StringCalculator add:@"1,2,3,4"] , 10, nil);
}

@end
