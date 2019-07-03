//
//  GYGReviewModel.h
//  David
//
//  Created by David Liu on 7/2/19.
//  Copyright © 2019 GetYourGuide. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface GYGReviewModel : JSONModel

@property (nonatomic, strong) NSString *review_id;
@property (nonatomic, strong) NSString *rating;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *author;

@end

NS_ASSUME_NONNULL_END
