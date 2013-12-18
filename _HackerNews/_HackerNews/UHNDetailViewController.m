//
//  UHNDetailViewController.m
//  _HackerNews
//
//  Created by Matúš Tomlein on 15/12/13.
//  Copyright (c) 2013 Matus Tomlein. All rights reserved.
//

#import "UHNDetailViewController.h"
#import "UHNAppSettings.h"

@interface UHNDetailViewController ()
- (void)configureView;
@end

@implementation UHNDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.navigationItem.title = self.detailItem.title;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailItem.url]]];
    }
}

- (void)updateButtons
{
    self.back.enabled = self.webView.canGoBack;
    [self showRefresh:!self.webView.loading];
}

- (void)showRefresh:(bool)show
{
    if (show)
        [self showButton:self.refresh andHide:self.stop];
    else
        [self showButton:self.stop andHide:self.refresh];
}

- (void)showButton:(id)buttonToShow andHide:(id)buttonToHide
{
    NSMutableArray *toolbarButtons = [[self.toolbar items] mutableCopy];

    if ([toolbarButtons containsObject:buttonToHide])
        [toolbarButtons removeObject:buttonToHide];

    if (![toolbarButtons containsObject:buttonToShow])
        [toolbarButtons insertObject:buttonToShow atIndex:2];

    [self.toolbar setItems:toolbarButtons animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.webView.delegate = self;
    [self configureView];

    self.share.target = self;
    [self.share setAction: @selector(shareButtonWasPressed:)];
    self.reader.target = self;
    [self.reader setAction: @selector(readerButtonWasPressed:)];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}

- (IBAction)shareButtonWasPressed:(UIBarButtonItem*)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:self.detailItem.url delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share", @"Open in Safari", @"View Comments", nil];

    actionSheet.actionSheetStyle = UIActionSheetStyleDefault; [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0: // Share
            [self openShareMenu];
            break;
        case 1: // Open in Safari
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.detailItem.url]];
            break;
        case 2: // View Comments
            [self.webView loadRequest:
             [NSURLRequest requestWithURL:
              [NSURL URLWithString:[NSString stringWithFormat:@"https://news.ycombinator.com/item?id=%d", self.detailItem.itemId]]]];
            break;
    }
}

- (void)openShareMenu
{
    NSArray *activityItems = [NSArray arrayWithObjects:self.detailItem.title, [NSURL URLWithString:self.detailItem.url], nil];

    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)readerButtonWasPressed:(UIBarButtonItem*)sender
{
    NSString* urlString = [NSString stringWithFormat:@"%@reader.php?url=%@", [UHNAppSettings serviceBaseUrl], [self.detailItem.url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
