//
//  ContactsViewController.h
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHCoreDataTableViewController.h"
#import "ContactViewController.h"

@interface ContactsViewController : RHCoreDataTableViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
