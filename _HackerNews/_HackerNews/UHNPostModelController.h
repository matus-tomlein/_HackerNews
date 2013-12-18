//
//  UHNPostModelController.h
//  _HackerNews
//
//  Created by Matúš Tomlein on 16/12/13.
//  Copyright (c) 2013 Matus Tomlein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UHNMasterViewController.h"

@interface UHNPostModelController : NSObject
{
    UHNMasterViewController *_masterViewController;
}

@property (strong, nonatomic) NSMutableArray *readArticles;

- (id)initWithMasterViewController:(UHNMasterViewController *)masterViewController;

- (void)loadFromService;

@end
