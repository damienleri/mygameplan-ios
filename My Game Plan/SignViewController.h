//
//  SignViewController.h
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditSignViewController.h"

@interface SignViewController : UITableViewController <UIActionSheetDelegate>

@property(nonatomic,strong) Sign *sign;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
-(IBAction)showActionSheet:(id)sender;
@end
