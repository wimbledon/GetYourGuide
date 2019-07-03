//
//  GYGReviewTableViewCell.h
//  David
//
//  Created by David Liu on 7/2/19.
//  Copyright © 2019 GetYourGuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYGReviewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GYGReviewTableViewCell : UITableViewCell

@property (nonatomic, strong) GYGReviewModel *model;

@end

NS_ASSUME_NONNULL_END
