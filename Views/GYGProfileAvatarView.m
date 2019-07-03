//
//  GYGProfileAvatarView.m
//  David
//
//  Created by David Liu on 7/3/19.
//  Copyright © 2019 GetYourGuide. All rights reserved.
//

#import "GYGProfileAvatarView.h"
#import "David-Swift.h"

@interface GYGProfileAvatarView()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *prefixLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation GYGProfileAvatarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconView = [[UIImageView alloc] init];
        
        self.prefixLabel = [[UILabel alloc] init];
        self.prefixLabel.text = @"reviewed by";
        self.prefixLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        
        self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
        self.prefixLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:self.iconView];
        [self addSubview:self.prefixLabel];
        [self addSubview:self.nameLabel];
        
        NSDictionary *views = @{@"ic" : self.iconView,
                                @"pv" : self.prefixLabel,
                                @"nv" : self.nameLabel};
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[ic(==50)]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[ic]-[pv]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[ic]-[nv]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[pv]-[nv]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.iconView
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1.0
                                                          constant:0.0]];
    }
    return self;
}

- (void)setName:(NSString *)name
{
    if (_name != name) {
        _name = name;
        self.nameLabel.text = name;
        [self.iconView setImageForName:name backgroundColor:nil circular:YES gradient:NO];
    }
}

@end
