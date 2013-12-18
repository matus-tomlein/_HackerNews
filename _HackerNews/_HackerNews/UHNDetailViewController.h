//
//  UHNDetailViewController.h
//  _HackerNews
//
//  Created by Matúš Tomlein on 15/12/13.
//  Copyright (c) 2013 Matus Tomlein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UHNPostModel.h"

@interface UHNDetailViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) UHNPostModel *detailItem;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reader;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *stop;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *share;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

- (void)updateButtons;
- (void)showRefresh:(bool)show;
- (IBAction)shareButtonWasPressed:(UIBarButtonItem*)sender;
- (IBAction)readerButtonWasPressed:(UIBarButtonItem*)sender;

@end
