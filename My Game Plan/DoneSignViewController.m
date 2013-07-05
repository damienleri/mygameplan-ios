//
//  DoneSignViewController.m
//  My Game Plan
//
//  Created by Damien Leri on 7/4/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import "DoneSignViewController.h"

@interface DoneSignViewController ()

@end

@implementation DoneSignViewController

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
- (IBAction)returnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)returnPlanClick:(id)sender {


    [self performSegueWithIdentifier:@"unwindToPlan" sender:self];
}

@end
