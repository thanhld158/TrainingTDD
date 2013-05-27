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
    int sum = 0;
    
    switch (length) {
        case 0:
            sum = 0;
            break;
        case 1:
            sum = [numbers intValue];
            break;
        default: {
            
            break;
        }
    }
    return sum;
}

@end
