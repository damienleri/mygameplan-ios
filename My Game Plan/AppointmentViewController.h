//
//  AppointmentViewController.h
//  My Game Plan
//
//  Created by damien on 7/1/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditAppointmentViewController.h"

@interface AppointmentViewController : UIViewController
@property(nonatomic,strong) Appointment *appointment;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end
