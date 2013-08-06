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
@synthesize nameInput, sign, isEditing,deleteButton, types,typeInput, noteInput, suggestions, suggestionsInput, typePickerView, suggestionPickerView, deleteCell,suggestionsCell, tableView, suggestionTrigger;


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
        suggestionTrigger = sign.trigger;
        
   } else {
        sign = [Sign newEntity];
        sign.date = [NSDate date];
        deleteCell.hidden = YES;
        nameInput.hidden = YES;
	    typeInput.text = [types objectAtIndex:0];
    }
     

    /// Creating pickerViews here
    


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
        
        suggestionsInput.layer.borderWidth = 2.0f;
        suggestionsInput.layer.cornerRadius = 8.0f;
        suggestionsInput.layer.borderColor = [[UIColor redColor] CGColor];
        return;
    }

    [sign setTrigger: suggestionTrigger];
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
        [Sign commit];
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
        NSDictionary *suggestion = [[suggestions objectForKey: typeInput.text] objectAtIndex:row];
        suggestionsInput.text = [suggestion objectForKey:@"title"];
        
        if ([suggestionsInput.text isEqual: @"Other"]) {
             nameInput.text = @"";
             nameInput.hidden = NO;
            suggestionTrigger = nil;
        } else {
             nameInput.text = suggestionsInput.text;
             suggestionTrigger = [suggestion objectForKey:@"trigger"];

        }
        [suggestionsInput resignFirstResponder];
    }
}

@end
