//
//  SignsViewController.h
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHCoreDataTableViewController.h"
#import "SignViewController.h"

//@interface SignsViewController : RHCoreDataTableViewController
@interface SignsViewController : UITableViewController
@property (strong,nonatomic) NSArray *types;
@property (strong,nonatomic) NSMutableArray *signs;
@property (strong,nonatomic) NSMutableArray *sectionLabels;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
