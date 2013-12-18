//
//  UHNMasterViewController.m
//  _HackerNews
//
//  Created by Matúš Tomlein on 15/12/13.
//  Copyright (c) 2013 Matus Tomlein. All rights reserved.
//

#import "UHNMasterViewController.h"

#import "UHNDetailViewController.h"
#import "UHNPostModel.h"
#import "UHNPostModelController.h"
#import "UHNPostCell.h"
#import <JSONModel/JSONHTTPClient.h>

@interface UHNMasterViewController () {
    NSMutableArray *_objects;
    UHNPostModelController *_postModelController;
}
@end

@implementation UHNMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _postModelController = [[UHNPostModelController alloc] initWithMasterViewController:self];

    [_postModelController loadFromService];

    _objects = [[NSMutableArray alloc] init];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UHNPostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    UHNPostModel *post = _objects[indexPath.row];
    if (!post)
        return nil;

    [cell.titleTextLabel setText:post.title];
    [cell.URLTextLabel setText:post.domain];
    [cell.dateTextLabel setText:[self timeIntervalWithDate:post.date]];
    [cell.pointsTextLabel setText:[NSString stringWithFormat:@"%d points", post.points]];
    cell.titleTextLabel.textColor = post.read ? [UIColor grayColor] : nil;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

        UHNPostModel *post = _objects[indexPath.row];
        post.read = true;
        [[segue destinationViewController] setDetailItem:post];

        UHNPostCell *cell = (UHNPostCell *)sender;
        cell.titleTextLabel.textColor = [UIColor grayColor];
    }
}

- (void)updatePosts:(NSMutableArray *)posts
{
    _objects = posts;
    [self.tableView reloadData];
}

//Constants
#define SECOND 1
#define MINUTE (60 * SECOND)
#define HOUR (60 * MINUTE)
#define DAY (24 * HOUR)
#define MONTH (30 * DAY)

- (NSString*)timeIntervalWithDate:(NSDate*)d1
{
    //Calculate the delta in seconds between the two dates
    NSTimeInterval delta = [[NSDate date] timeIntervalSinceDate:d1];

    if (delta < 1 * MINUTE)
    {
        return delta == 1 ? @"one second ago" : [NSString stringWithFormat:@"%d seconds ago", (int)delta];
    }
    if (delta < 2 * MINUTE)
    {
        return @"a minute ago";
    }
    if (delta < 45 * MINUTE)
    {
        int minutes = floor((double)delta/MINUTE);
        return [NSString stringWithFormat:@"%d minutes ago", minutes];
    }
    if (delta < 90 * MINUTE)
    {
        return @"an hour ago";
    }
    if (delta < 24 * HOUR)
    {
        int hours = floor((double)delta/HOUR);
        return [NSString stringWithFormat:@"%d hours ago", hours];
    }
    if (delta < 48 * HOUR)
    {
        return @"yesterday";
    }
    if (delta < 30 * DAY)
    {
        int days = floor((double)delta/DAY);
        return [NSString stringWithFormat:@"%d days ago", days];
    }
    if (delta < 12 * MONTH)
    {
        int months = floor((double)delta/MONTH);
        return months <= 1 ? @"one month ago" : [NSString stringWithFormat:@"%d months ago", months];
    }
    else
    {
        int years = floor((double)delta/MONTH/12.0);
        return years <= 1 ? @"one year ago" : [NSString stringWithFormat:@"%d years ago", years];
    }
}

@end
