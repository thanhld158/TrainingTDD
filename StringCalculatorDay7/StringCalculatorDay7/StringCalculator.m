//
//  StringCalculator.m
//  StringCalculatorDay7
//
//  Created by Le Duy Thanh on 04/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StringCalculator.h"

@implementation StringCalculator

+ (int )add:(NSString *)numbers {
    int length = numbers.length;
    __block int sum = 0;
    switch (length) {
        case 0:
            sum = 0;
            break;
            
        default:
        {
            NSArray *numberArray = [numbers componentsSeparatedByString:@","];
            [numberArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *currentNumber = (NSString *)obj;
                if ([currentNumber rangeOfString:@"\n"].location != NSNotFound) {
                    NSArray *lineBreakNumbers = [currentNumber componentsSeparatedByString:@"\n"];
                    [lineBreakNumbers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        NSString *currentLineBreakNum = (NSString *)obj;
                        sum += [currentLineBreakNum intValue];
                    }];
                }else {
                    sum += [currentNumber intValue];
                }
            }];
        }
            break;
    }
    
    return sum;
}

@end
