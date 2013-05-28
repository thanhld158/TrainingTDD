//
//  StringCalculatorTests.m
//  StringCalculatorTests
//
//  Created by Le Duy Thanh on 27/05/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StringCalculatorTests.h"
#import "StringCalculator.h"

@implementation StringCalculatorTests

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
    STAssertEquals([StringCalculator add:nil], 0, nil);
    STAssertEquals([StringCalculator add:@""], 0, nil);
    STAssertEquals([StringCalculator add:@"1"], 1, nil);
    STAssertEquals([StringCalculator add:@"1,2"], 3, nil);
}



@end
