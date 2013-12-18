//
//  UHNPostModel.m
//  _HackerNews
//
//  Created by Matúš Tomlein on 16/12/13.
//  Copyright (c) 2013 Matus Tomlein. All rights reserved.
//

#import "UHNPostModel.h"

@implementation UHNPostModel

- (id)init
{
    self = [super init];
    if (self) {
        self.read = false;
    }
    return self;
}

@end
