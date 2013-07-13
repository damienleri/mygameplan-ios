//
//  SignViewController.h
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sign.h"

@interface EditSignViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>
- (IBAction)CancelButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *typeInput;
@property (weak, nonatomic) IBOutlet UITextField *noteInput;
@property (weak, nonatomic) IBOutlet UITextField *suggestionsInput;
@property(nonatomic) BOOL isEditing;
@property(nonatomic,strong) Sign *sign;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong,nonatomic) NSArray *types;
@property (strong,nonatomic) NSDictionary *suggestions;
@property(strong, nonatomic) UIPickerView *typePickerView;
@property(strong, nonatomic) UIPickerView *suggestionPickerView;
@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *suggestionsCell;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component;

@end
