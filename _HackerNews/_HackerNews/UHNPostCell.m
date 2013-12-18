//
//  UHNPostCell.m
//  _HackerNews
//
//  Created by Matúš Tomlein on 15/12/13.
//  Copyright (c) 2013 Matus Tomlein. All rights reserved.
//

#import "UHNPostCell.h"

@implementation UHNPostCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleTextLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:_dateTextLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0.0f]];
}

@end
