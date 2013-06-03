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
    STFail(@"Unit tests are not implemented yet in StringCalculatorDay6Tests");
}

- (void)TestAddFunction {
    STAssertEquals([StringCalculator add:@""] , 0, nil);
}

@end
