//
//  SignViewController.m
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import "EditSignViewController.h"
#import "Config.h"
#import <QuartzCore/QuartzCore.h>

@implementation EditSignViewController
@synthesize nameInput, sign, isEditing,deleteButton, types,typeInput, noteInput, suggestions, suggestionsInput, typePickerView, suggestionPickerView, deleteCell,nameCell,suggestionsCell, tableView;


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

    [self.tableView setEditing:NO];

   types = [[Config sharedInstance] objectForKey:@"warning_sign_type_labels"];
    suggestions = [[Config sharedInstance] objectForKey:@"warning_signs"];
 
    if (isEditing) {
        nameInput.text = sign.name;
        noteInput.text = sign.note;
        typeInput.text = sign.type;
        suggestionsInput.hidden = YES;
        nameInput.hidden = NO;
	typeInput.text = sign.type;

   } else {
        sign = [Sign newEntity];
        sign.date = [NSDate date];
        deleteCell.hidden = YES;
        nameInput.hidden = YES;
	typeInput.text = [types objectAtIndex:0];
    }
     

 
    typePickerView = [[UIPickerView alloc] init];
    typePickerView.dataSource = self;
    typePickerView.delegate = self;
    typePickerView.showsSelectionIndicator = YES;
    typeInput.inputView = typePickerView;


    suggestionPickerView = [[UIPickerView alloc] init];
    suggestionPickerView.dataSource = self;
    suggestionPickerView.delegate = self;
    suggestionPickerView.showsSelectionIndicator = YES;
    suggestionsInput.inputView = suggestionPickerView;

   UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

}

-(void)dismissKeyboard {
    [nameInput resignFirstResponder];
    [suggestionsInput resignFirstResponder];
    [noteInput resignFirstResponder];
}

- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
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
        suggestionsInput.layer.borderWidth = 1.0f;
        suggestionsInput.layer.borderColor = [[UIColor redColor] CGColor];
        return;
    }

    [sign setName:[nameInput text]];
    [sign setNote: [noteInput text]];
    [sign setType: [typeInput text]];
    [Sign commit];
    

  [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)changeDate:(UIDatePicker *)sender {
    [sign setDate: sender.date];
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
    [nameInput resignFirstResponder];
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
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        [sign delete];
        [self performSegueWithIdentifier:@"unwindToSigns" sender:self];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:typePickerView]) {
        return [types count];
    } else {
        return [[suggestions objectForKey: typeInput.text] count];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if ([pickerView isEqual:typePickerView]) {
        return [types objectAtIndex:row];
    } else {
        return [[[suggestions objectForKey: typeInput.text] objectAtIndex:row] objectForKey:@"title"];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{

    if ([pickerView isEqual:typePickerView]) {
    typeInput.text = [types objectAtIndex:row];
        [typeInput resignFirstResponder]; // Close picker
        
    } else {

        suggestionsInput.text = [[[suggestions objectForKey: typeInput.text] objectAtIndex:row] objectForKey:@"title"];
        if ([suggestionsInput.text isEqual: @"Other"]) {
             nameInput.text = @"";
             nameInput.hidden = NO;
//            [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
         } else {
             nameInput.text = suggestionsInput.text;
         }
        [suggestionsInput resignFirstResponder];
    }
}

@end
