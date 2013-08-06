//
//  AppointmentViewController.h
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appointment.h"
#import "Parse/Parse.h"

@interface EditAppointmentViewController : UITableViewController <UIActionSheetDelegate>
- (IBAction)CancelButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property(nonatomic) BOOL isEditing;
@property(nonatomic,strong) Appointment *appointment;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;
@property (weak, nonatomic) IBOutlet UITextField *noteInput;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property(nonatomic) BOOL changedDate;
@end
