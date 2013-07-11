//
//  HomeViewController.m
//  My Game Plan
//
//  Created by Damien Leri on 7/6/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import "HomeViewController.h"
#import "Config.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize photoView;

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
    if (NO)
    {
    NSString *appID = @"284882215";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@&mt=8", appID]]];
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    NSInteger numPhotos = 3;
    NSInteger randomIndex = (arc4random() % numPhotos) + 1;
  //  NSString *randomPath = [array objectAtIndex:arc4random() % [array count]];
  //    NSLog(randomPath);
//    NSLog([[NSString alloc] initWithFormat: @"photo%i.jpg", randomIndex]);
    photoView.image = [UIImage imageNamed: [[NSString alloc] initWithFormat: @"photo%i.jpg", randomIndex] ];
//    photoView.image = [UIImage imageNamed:@"photo2.jpg"];

    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hotlineClick:(id)sender {
    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@", [[Config sharedInstance] objectForKey:@"hotline_phone"]];
				      
//                            [[Config sharedInstance] objectForKey:@"hotline_phone"]];
//    NSLog(phoneNumber);
    NSURL *URL = [NSURL URLWithString:phoneNumber];
    [[UIApplication sharedApplication] openURL:URL];
}

@end
