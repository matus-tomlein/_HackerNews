//
//  UHNPostModelController.m
//  _HackerNews
//
//  Created by Matúš Tomlein on 16/12/13.
//  Copyright (c) 2013 Matus Tomlein. All rights reserved.
//

#import "UHNPostModelController.h"
#import "UHNPostModel.h"
#import "UHNAppSettings.h"
#import <JSONModel/JSONHTTPClient.h>

@implementation UHNPostModelController

- (id)initWithMasterViewController:(UHNMasterViewController *)masterViewController
{
    self = [super init];

    if (self) {
        _masterViewController = masterViewController;

    }

    return self;
}

- (void)loadFromService
{
    [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@front_page.json", [UHNAppSettings serviceBaseUrl]]
                                  completion:^(NSArray *array, JSONModelError *err) {
                                      NSMutableArray *objects = [[NSMutableArray alloc] init];
                                      for (NSDictionary *postData in array) {
                                          UHNPostModel *post= [[UHNPostModel alloc] init];

                                          post.title = postData[@"title"];
                                          post.url = postData[@"url"];
                                          if ([post.url hasPrefix:@"item"])
                                              post.url = [NSString stringWithFormat:@"https://news.ycombinator.com/%@", post.url];
                                          post.domain = [self getRootDomain:post.url];
                                          post.points = [postData[@"points"] intValue];
                                          NSTimeInterval timeInterval = [postData[@"time"] doubleValue];
                                          post.date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
                                          post.itemId = [postData[@"id"] intValue];

                                          [objects addObject:post];
                                      }
                                      [_masterViewController updatePosts: objects];
                                  }];
}

- (NSString *)getRootDomain:(NSString *)domain
{
    // Return nil if none found.
    NSString * rootDomain = nil;

    // Convert the string to an NSURL to take advantage of NSURL's parsing abilities.
    NSURL * url = [NSURL URLWithString:domain];

    // Get the host, e.g. "secure.twitter.com"
    NSString * host = [url host];
    
    // Separate the host into its constituent components, e.g. [@"secure", @"twitter", @"com"]
    NSArray * hostComponents = [host componentsSeparatedByString:@"."];
    if ([hostComponents count] >=2) {
        // Create a string out of the last two components in the host name, e.g. @"twitter" and @"com"
        rootDomain = [NSString stringWithFormat:@"%@.%@", [hostComponents objectAtIndex:([hostComponents count] - 2)], [hostComponents objectAtIndex:([hostComponents count] - 1)]];
    }
    
    return rootDomain;
}

@end
