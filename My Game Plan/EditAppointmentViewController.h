//
//  AppointmentViewController.h
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appointment.h"

@interface EditAppointmentViewController : UIViewController
- (IBAction)CancelButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property(nonatomic) BOOL isEditing;
@property(nonatomic,strong) Appointment *appointment;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@end
