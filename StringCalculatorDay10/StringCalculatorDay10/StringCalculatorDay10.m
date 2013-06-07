//
//  StringCalculatorDay10.m
//  StringCalculatorDay10
//
//  Created by Le Duy Thanh on 07/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StringCalculatorDay10.h"

@implementation StringCalculatorDay10

#define frontOfCharacterDelimiter @"//"
#define afterCharacterDelimiter @"\n"

+ (int)add:(NSString *)numbers {
    int length = numbers.length;
    int sum = 0;
    
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
                NSRange afterCharacterRange = [subStringNumber rangeOfString:afterCharacterDelimiter];
                delimiter = [subStringNumber substringToIndex:afterCharacterRange.location];
                subStringNumberFinal = [subStringNumber substringFromIndex:(afterCharacterRange.location + afterCharacterRange.length)];
                characterSetString = [characterSetString stringByAppendingString:delimiter];
                
            }
            
            NSArray *numbersArray = [subStringNumberFinal componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:characterSetString]];
            
            for (NSString *currentNumber in numbersArray) {
                sum += [currentNumber intValue];
            }
        }
            break;
    }
    return sum;
}

@end
