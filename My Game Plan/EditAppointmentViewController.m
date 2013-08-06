//
//  AppointmentViewController.m
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import "EditAppointmentViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation EditAppointmentViewController
@synthesize nameInput, dateButton, appointment, isEditing,deleteButton, deleteCell,tableView,noteInput,changedDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSDate *) defaultDate
{
    NSDate *today = [NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    NSDate *tomorrow = [gregorian dateByAddingComponents:components toDate:today options:0];
    
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    components = [gregorian components:unitFlags fromDate:tomorrow];
    components.hour = 12;
    components.minute = 0;
    
    NSDate *tomorrowNoon = [gregorian dateFromComponents:components];
    return tomorrowNoon;

    
    
//    NSDateComponents *time = [[NSCalendar currentCalendar]
//                              components:NSHourCalendarUnit | NSMinuteCalendarUnit
//                              fromDate:today];
//    NSInteger minutes = [time minute];
//    float minuteUnit = ceil((float) minutes / 5.0);
//     minutes = minuteUnit * 5.0;
//    [time setMinute: minutes];
//     return [[NSCalendar currentCalendar] dateFromComponents:time];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setEditing:NO];

    
    if (isEditing) {
        nameInput.text = appointment.name;
        noteInput.text = appointment.note;
        
    } else {
        deleteCell.hidden = YES;       
        appointment = [Appointment newEntity];
        appointment.date = [self defaultDate];
    }

    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM d, yyyy 'at' HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:appointment.date];
    [dateButton setTitle:dateString forState:UIControlStateNormal];


}

-(void)dismissKeyboard {
    [nameInput resignFirstResponder];

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
    if ([nameInput.text isEqualToString:@""]) {
        nameInput.layer.borderWidth = 2.0f;
        nameInput.layer.cornerRadius = 8.0f;
        nameInput.layer.borderColor = [[UIColor redColor] CGColor];
        return;
    }
    
    [appointment setName: nameInput.text];
    [appointment setNote: noteInput.text];
    [Appointment commit];
    
    if (changedDate) {
        [appointment updateReminders];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self performSegueWithIdentifier:@"unwindToAppointments" sender:self];
}
- (void)changeDate:(UIDatePicker *)sender {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM d, yyyy 'at' HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:sender.date];

    [dateButton setTitle:dateString forState:UIControlStateNormal];
    [appointment setDate: sender.date];
    changedDate = YES;
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}

- (void)dismissDatePicker:(id)sender {
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
   
}
- (IBAction)callDp:(id)sender {
    [nameInput resignFirstResponder]; // Close keyboard
    [noteInput resignFirstResponder];
    
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height-216-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    datePicker.tag = 10;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    
    [datePicker setDate:appointment.date];
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
}
- (IBAction)callDelete:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:@"Delete"
                                              otherButtonTitles:nil];
    
    CGRect deleteRect = CGRectMake(0, self.view.bounds.size.height-216-44, 320, 44);
    [sheet showFromRect:deleteRect inView:self.view animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    //// Callback from Delete actionsheet
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        [appointment deleteRemindersFromServer];
        [appointment delete];
        [Appointment commit];
        [self performSegueWithIdentifier:@"unwindToAppointments" sender:self];
    }
}

@end
