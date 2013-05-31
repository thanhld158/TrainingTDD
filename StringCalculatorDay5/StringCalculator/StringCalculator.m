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
    __block NSString *delimiter = @",";
    
    switch (length) {
        case 0:
            sum = 0;
            break;
        case 1:
            sum = [numbers intValue];
            break;
        default: {
            NSString *newNumberStr = numbers;
            if ([numbers rangeOfString:@"//"].location != NSNotFound && [numbers rangeOfString:@"//"].location == 0) {
                NSRange lineBreak = [numbers rangeOfString:@"\n"];
                
                delimiter = [numbers substringWithRange:NSMakeRange(2, lineBreak.location - 2)];
                newNumberStr = [numbers substringFromIndex:(lineBreak.location + lineBreak.length)];
            }
            
            numberArray = [newNumberStr componentsSeparatedByString:delimiter];
            [numberArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *currentNumber = (NSString *)obj;
                if ([currentNumber rangeOfString:@"\n"].location == NSNotFound) {
                    if ([currentNumber intValue] < 0) {
                        NSLog(@"negatives not allowed");
                    }else if ([currentNumber intValue] > 1000) {
                        NSLog(@"This number has been ignored because bigger than 1000");
                    }else {
                        sum += [currentNumber intValue];
                    }
                }else {
                    NSArray *lineBreakNumberArr = [currentNumber componentsSeparatedByString:@"\n"];
                    [lineBreakNumberArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        NSString *lineBreakNumber = (NSString *)obj;
                        if ([lineBreakNumber intValue] < 0) {
                            NSLog(@"negatives not allowed");
                        }else if ([lineBreakNumber intValue] > 1000) {
                            NSLog(@"This number has been ignored because bigger than 1000");
                        }else {
                            sum += [lineBreakNumber intValue];
                        }
                    }];
                }
            }];
            break;
        }
    }
    return sum;
}

@end
