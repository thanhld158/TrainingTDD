//
//  StringCalculator.m
//  StringCalculatorDay6
//
//  Created by Le Duy Thanh on 03/06/2013.
//  Copyright (c) 2013 Qsoft. All rights reserved.
//

#import "StringCalculator.h"

@implementation StringCalculator

+ (int )add:(NSString *)numbers {
    int length = numbers.length;
    
    switch (length) {
        case 0:
            return 0;
            break;
            
        default:
            return 1;
            break;
    }
}
@end
