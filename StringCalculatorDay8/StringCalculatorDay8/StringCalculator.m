//
//  StringCalculator.m
//  StringCalculatorDay8
//
//  Created by Le Duy Thanh on 05/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StringCalculator.h"

@implementation StringCalculator
#define frontOfDelimiterCharacter @"//"
#define afterDelimiterCharacter @"\n"

+ (int)add:(NSString *)numbers {
    int length = numbers.length;
    __block int sum = 0;
    NSString *delimiter;
    
    switch (length) {
        case 0:
            sum = 0;
            break;
            
        default: {
            NSString *subNumberString2 = numbers;
            delimiter = @",";
            if ([numbers rangeOfString:@"//"].location != NSNotFound) {
                NSString *subNumberString1 = [numbers substringFromIndex:2];
                NSRange afterDelimiterCharacterRange = [subNumberString1 rangeOfString:afterDelimiterCharacter];
                delimiter = [subNumberString1 substringToIndex:afterDelimiterCharacterRange.location];
                
                subNumberString2 = [subNumberString1 substringFromIndex:(afterDelimiterCharacterRange.location + afterDelimiterCharacterRange.length)];
            }
            NSArray *numberArray = [subNumberString2 componentsSeparatedByString:delimiter];
            [numberArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *currentNumber = (NSString *)obj;
                if ([currentNumber rangeOfString:@"\n"].location != NSNotFound) {
                    NSArray *lineBreakNumbers = [currentNumber componentsSeparatedByString:@"\n"];
                    [lineBreakNumbers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        NSString *lineBreakNumber = (NSString *)obj;
                        sum += [lineBreakNumber intValue];
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
