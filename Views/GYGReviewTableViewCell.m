//
//  GYGReviewTableViewCell.m
//  David
//
//  Created by David Liu on 7/2/19.
//  Copyright © 2019 GetYourGuide. All rights reserved.
//

#import "GYGReviewTableViewCell.h"
@import Cosmos;
#import "GYGProfileAvatarView.h"

@interface GYGReviewTableViewCell()
@property (nonatomic, strong) UILabel *titleLabelView;
@property (nonatomic, strong) UILabel *subLabelView;
@property (nonatomic, strong) GYGProfileAvatarView *avatarView;
@property (nonatomic, strong) CosmosView *ratingView;
@end

@implementation GYGReviewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _setupViews];
    }
    return self;
}

- (void)prepareForReuse
{
    self.titleLabelView.text = nil;
    self.subLabelView.text = nil;
    self.avatarView.name = nil;
    self.ratingView.rating = 0.0;
    
    [super prepareForReuse];
}

- (void)setModel:(GYGReviewModel *)model
{
    if (_model != model) {
        _model = model;
        
        if (model.title.length) {
            self.titleLabelView.text = [NSString stringWithFormat:@"\"%@\"", model.title];
        }
        
        self.subLabelView.text = model.message;
        self.avatarView.name = model.author;
        self.ratingView.rating = [model.rating doubleValue];
    }
}

#pragma mark - Private methods
- (void)_setupViews
{
    self.titleLabelView = [[UILabel alloc] init];
    self.titleLabelView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.titleLabelView.textColor = [[UILabel appearance] textColor];
    self.titleLabelView.backgroundColor = [UIColor clearColor];
    
    self.subLabelView = [[UILabel alloc] init];
    self.subLabelView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.subLabelView.numberOfLines = 0;
    self.subLabelView.lineBreakMode = NSLineBreakByWordWrapping;
    self.subLabelView.textColor = [[UILabel appearance] textColor];
    self.subLabelView.backgroundColor = [UIColor clearColor];
    
    self.avatarView = [[GYGProfileAvatarView alloc] init];
    
    self.ratingView = [[CosmosView alloc] init];
    
    self.titleLabelView.translatesAutoresizingMaskIntoConstraints = NO;
    self.subLabelView.translatesAutoresizingMaskIntoConstraints = NO;
    self.avatarView.translatesAutoresizingMaskIntoConstraints = NO;
    self.ratingView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:self.titleLabelView];
    [self.contentView addSubview:self.subLabelView];
    [self.contentView addSubview:self.avatarView];
    [self.contentView addSubview:self.ratingView];
    
    NSDictionary *views = @{@"tv" : self.titleLabelView,
                            @"sv" : self.subLabelView,
                            @"av" : self.avatarView,
                            @"rv" : self.ratingView};
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tv]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[sv]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tv]-[sv]-[av]-8@500-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[av]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rv]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rv]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [self layoutIfNeeded];
}

@end
