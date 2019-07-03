//
//  NSArray+Utility.h
//  InterviewJane
//
//  Created by David Liu on 4/16/19.
//  Copyright © 2019 Cave Music Group. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Utility)

- (NSArray *)arrayByManipulationBlock:(id(^)(id obj, NSUInteger ind))manipulationBlock;

@end

NS_ASSUME_NONNULL_END
