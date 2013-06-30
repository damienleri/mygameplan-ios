//
//  AppointmentViewController.m
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import "AppointmentViewController.h"
#import "Appointment.h"

@interface AppointmentViewController ()

@end

@implementation AppointmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)SaveButton:(id)sender {

    Appointment *appointment = [Appointment newEntity];
    [appointment setName:@"test 2"];
    [appointment setDate:[NSDate date]];
    [Appointment commit];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
