//
//  StringCalculatorDay7Tests.m
//  StringCalculatorDay7Tests
//
//  Created by Le Duy Thanh on 04/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StringCalculatorDay7Tests.h"
#import "StringCalculator.h"

@implementation StringCalculatorDay7Tests

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

- (void)testStringCalculator {
    STAssertEquals(1, 1, nil);
    STAssertEquals([StringCalculator add:@""], 0, nil);
    STAssertEquals([StringCalculator add:@"1"], 1, nil);
    STAssertEquals([StringCalculator add:@"12"], 12, nil);
    STAssertEquals([StringCalculator add:@"1,2"], 3, nil);
    STAssertEquals([StringCalculator add:@"1,2,5"], 8, nil);
    STAssertEquals([StringCalculator add:@"1\n2,3"], 6, nil);
    STAssertEquals([StringCalculator add:@"1\n2,3\n4"], 10, nil);
}

@end
