//
//  StringCalculator.m
//  StringCalculatorDay9
//
//  Created by Le Duy Thanh on 06/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StringCalculator.h"

@implementation StringCalculator

#define frontOfCharacterDelimiter @"//"
#define afterCharacterDelimiter @"\n"

+ (int)add:(NSString *)numbers {
    int length = numbers.length;
    int sum = 0;
    NSMutableArray *negativesNumberArr = [NSMutableArray arrayWithCapacity:0];
    
    switch (length) {
        case 0:
            sum = 0;
            break;
            
        default: {
            NSString *subStringNumber;
            NSString *subStringNumberFinal;
            NSString *delimiter;
            NSString *characterSetString = @",\n";
            
            subStringNumber = subStringNumberFinal = numbers;
            
            if ([numbers rangeOfString:frontOfCharacterDelimiter].location != NSNotFound) {
                subStringNumber = [numbers substringFromIndex:2];
                NSRange characterAfterDelimiterRange = [subStringNumber rangeOfString:afterCharacterDelimiter];
                delimiter = [subStringNumber substringToIndex:characterAfterDelimiterRange.location];
                subStringNumberFinal = [subStringNumber substringFromIndex:(characterAfterDelimiterRange.location + characterAfterDelimiterRange.length)];
                characterSetString = [characterSetString stringByAppendingString:delimiter];
            }
            
            NSArray *numberArray = [numbers componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:characterSetString]];
            
            for (NSString *currentNumberStr in numberArray) {
                if ([currentNumberStr intValue] < 0) {
                    [negativesNumberArr addObject:currentNumberStr];
                    NSLog(@"negatives not allowed");
                    continue;
                }else if ([currentNumberStr intValue] > 1000) {
                    NSLog(@"This number bigger than 1000!");
                    continue;
                }else {
                    sum += [currentNumberStr intValue];
                }
            }
        }
            break;
    }
    NSLog(@"negatives not allowed: %@", [negativesNumberArr description]);
    return sum;
}


NSString *characterSetString = @",";

NSArray *numbersArray = [numbers componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:characterSetString]];

for (NSString *currentNumber in numbersArray) {
    
}
@end
