//
//  StringCalculatorDay10.m
//  StringCalculatorDay10
//
//  Created by Le Duy Thanh on 07/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StringCalculatorDay10.h"

@implementation StringCalculatorDay10

+ (int)add:(NSString *)numbers {
    int length = numbers.length;
    int sum = 0;
    
    switch (length) {
        case 0:
            sum = 0;
            break;
            
        default: {
            return 1;
        }
            break;
    }
    return sum;
}

@end
