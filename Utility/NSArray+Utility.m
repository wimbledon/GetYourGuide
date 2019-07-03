//
//  NSArray+Utility.m
//  InterviewJane
//
//  Created by David Liu on 4/16/19.
//  Copyright © 2019 Cave Music Group. All rights reserved.
//

#import "NSArray+Utility.h"

@implementation NSArray (Utility)

- (NSArray *)arrayByManipulationBlock:(id(^)(id obj, NSUInteger ind))manipulationBlock
{
    if (self.count) {
        NSMutableArray *ma = [NSMutableArray arrayWithCapacity:self.count];
        for (NSUInteger i = 0; i < self.count; i++) {
            id mObj = manipulationBlock(self[i], i);
            if (mObj) {
                [ma addObject:mObj];
            }
        }
        return [NSArray arrayWithArray:ma];
    }
    return nil;
}

@end
