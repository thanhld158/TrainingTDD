//
//  StringCalculator.m
//  StringCalculator
//
//  Created by Le Duy Thanh on 27/05/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StringCalculator.h"

@implementation StringCalculator

+ (int )add:(NSString *)numbers {
    int length = numbers.length;
    __block int sum = 0;
    NSArray *numberArray;
    
    switch (length) {
        case 0:
            sum = 0;
            break;
        case 1:
            sum = [numbers intValue];
            break;
        default: {
            numberArray = [numbers componentsSeparatedByString:@","];
            [numberArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *currentNumber = (NSString *)obj;
                sum += [currentNumber intValue];
            }];
            break;
        }
    }
    return sum;
}

@end
