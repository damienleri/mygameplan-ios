//
//  DoneSignViewController.m
//  My Game Plan
//
//  Created by Damien Leri on 7/4/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import "DoneSignViewController.h"
#import "Config.h"
@interface DoneSignViewController ()

@end

@implementation DoneSignViewController
@synthesize tableView;

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
- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self performSegueWithIdentifier:@"unwindToStrategies" sender:self];

        
    } else if (indexPath.section == 1 && indexPath.row == 1) {
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self performSegueWithIdentifier:@"unwindToContacts" sender:self];

        
    } else     if (indexPath.section == 1 && indexPath.row == 2) {

        
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@", [[Config sharedInstance] objectForKey:@"hotline_phone"]];
        
        NSURL *URL = [NSURL URLWithString:phoneNumber];
        [[UIApplication sharedApplication] openURL:URL];
        
    }
}

@end
