//
//  StrategyViewController.m
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import "EditStrategyViewController.h"
#import "Config.h"
#import <QuartzCore/QuartzCore.h>

@implementation EditStrategyViewController
@synthesize nameInput, strategy, isEditing,deleteButton, noteInput, suggestions, suggestionsInput, suggestionPickerView, app, tableView, deleteCell;


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
    NSArray *all_suggestions = [[Config sharedInstance] objectForKey:@"coping_strategies"];
    
//    NSLog(@"loading suggestions from config %i", [suggestions count]);
    suggestions = [[NSMutableArray alloc] initWithArray:all_suggestions];
    NSIndexSet *indexSet = [suggestions indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            NSString *this_title = [obj objectForKey:@"title"];
            NSInteger exists = [[Strategy fetchWithPredicate:[NSPredicate predicateWithFormat:@"name=%@", this_title]] count];
//        NSLog(@"has app %@ ? %i", this_title, exists);
            if (exists > 0) {
                return YES;
            } else {
                return NO;
            }
    }];
    
    [suggestions removeObjectsAtIndexes: indexSet];

    
    if (isEditing) {
        nameInput.text = strategy.name;
        noteInput.text = strategy.note;
        suggestionsInput.hidden = YES;
        nameInput.hidden = NO;

        if (strategy.app_id) {

        }
	//	apps = [[Config sharedInstance] objectForKey:@"coping_strategy_app_labels"];
	//	appInput.text = strategy.app;

    } else {
        strategy = [Strategy newEntity];
        deleteCell.hidden = YES;
        nameInput.hidden = YES;
        strategy.date = [NSDate date];
	//        appInput.text = [apps objectAtIndex:0];
    }
    

//    appPickerView = [[UIPickerView alloc] init];
//    appPickerView.dataSource = self;
//    appPickerView.delegate = self;
//    appPickerView.showsSelectionIndicator = YES;
//    appInput.inputView = appPickerView;

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
    [suggestionsInput resignFirstResponder];
    [nameInput resignFirstResponder];
    [noteInput resignFirstResponder];
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
 //       NSLog(@"required field missing");
        return;
    }
    
    if (!strategy.name || ![strategy.name isEqualToString: nameInput.text]) {

             NSLog(@"saving app info %@, %@", strategy.name, nameInput.text);
        [strategy setApp_id: [app objectForKey:@"id"]];
        [strategy setApp_title: [app objectForKey:@"title"]];
        [strategy setApp_subtitle: [app objectForKey:@"subtitle"]];
        [strategy setApp_url: [app objectForKey:@"url"]];
    }

    [strategy setName: [nameInput text]];
    [strategy setNote: [noteInput text]];

//    NSLog(@"app url %@ and id %@", strategy.app_url, strategy.app_id);
    
    [Strategy commit];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeDate:(UIDatePicker *)sender {
    [strategy setDate: sender.date];
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
        [strategy delete];
        [Strategy commit]; 
        [self performSegueWithIdentifier:@"unwindToStrategies" sender:self];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [suggestions count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[suggestions objectAtIndex:row] objectForKey:@"title"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    suggestionsInput.text = [[suggestions objectAtIndex:row] objectForKey:@"title"];

    if ([suggestionsInput.text isEqual: @"Other"]) {
        nameInput.text = @"";
        nameInput.hidden = NO;
        app = nil;

    } else {
        app = [[[suggestions objectAtIndex:row] objectForKey:@"apps"] objectAtIndex:0];
//        NSLog(@"app %@", [app objectForKey:@"title"]);
        nameInput.text = suggestionsInput.text;

    }
    [suggestionsInput resignFirstResponder];
}

@end
