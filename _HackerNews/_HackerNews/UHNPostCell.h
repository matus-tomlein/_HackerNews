//
//  UHNPostCell.h
//  _HackerNews
//
//  Created by Matúš Tomlein on 15/12/13.
//  Copyright (c) 2013 Matus Tomlein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UHNPostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *URLTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsTextLabel;

@end
