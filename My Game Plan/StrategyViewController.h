//
//  StrategyViewController.h
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditStrategyViewController.h"

@interface StrategyViewController : UITableViewController
@property(nonatomic,strong) Strategy *strategy;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
//@property (weak, nonatomic) IBOutlet UITableViewSection *appSection;
@property (weak, nonatomic) IBOutlet UITableViewCell *appCell;
@property (strong, nonatomic) IBOutlet UITableView *_tableView;

@end
