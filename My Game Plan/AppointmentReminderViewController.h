//
//  AppointmentReminderViewController.h
//  My Game Plan
//
//  Created by damien on 7/18/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Appointment.h"
@class AppointmentViewController;

@interface AppointmentReminderViewController : UITableViewController
@property(nonatomic,strong) Appointment *appointment;
@property (strong, nonatomic) IBOutlet UITableView *_tableView;
@property (strong,nonatomic) NSArray *intervals;
@property (strong,nonatomic) NSMutableIndexSet *selectedIndexes;
@property(strong,nonatomic) AppointmentViewController *parentVC;
@end
