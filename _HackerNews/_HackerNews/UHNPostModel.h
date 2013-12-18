//
//  UHNPostModel.h
//  _HackerNews
//
//  Created by Matúš Tomlein on 15/12/13.
//  Copyright (c) 2013 Matus Tomlein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UHNMasterViewController.h"

@interface UHNPostModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *domain;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) int points;
@property (nonatomic) int itemId;
@property (nonatomic) bool read;

@end
