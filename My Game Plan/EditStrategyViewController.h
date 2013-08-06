//
//  StrategyViewController.h
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Strategy.h"

@interface EditStrategyViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>
- (IBAction)CancelButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *noteInput;
@property (weak, nonatomic) IBOutlet UITextField *suggestionsInput;
@property(nonatomic) BOOL isEditing;
@property(nonatomic,strong) Strategy *strategy;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property(nonatomic,strong) NSDictionary *app;
@property (strong,nonatomic) NSMutableArray *suggestions;
@property(strong, nonatomic) UIPickerView *suggestionPickerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;

@property (weak, nonatomic) IBOutlet UITextField *appInput;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component;

@end
