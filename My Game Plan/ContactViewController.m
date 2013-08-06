//
//  ContactViewController.m
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import "ContactViewController.h"
#import "EditContactViewController.h"
@interface ContactViewController ()

@end

@implementation ContactViewController
@synthesize firstNameLabel, lastNameLabel, nameLabel, noteLabel, phoneLabel, contact, tableView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];


}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (contact) {
        nameLabel.text = contact.name;
        noteLabel.text = contact.note;
        [nameLabel sizeToFit];
        noteLabel.frame = CGRectMake(noteLabel.frame.origin.x, noteLabel.frame.origin.y, 200, 40);

        [noteLabel sizeToFit];
        CGSize size = [contact.note sizeWithFont:noteLabel.font forWidth:200.0 lineBreakMode:NSLineBreakByWordWrapping];
        noteLabel.frame = CGRectMake(noteLabel.frame.origin.x, noteLabel.frame.origin.y, size.width, size.height);

        if ([contact.addressBookID intValue] > 0) {
            ABRecordRef person = ABAddressBookGetPersonWithRecordID(ABAddressBookCreate(), (ABRecordID) [contact.addressBookID intValue]);
            if (person) {
             [self displayPerson:person];
             CFRelease(person);
            }
        }
        [self.tableView reloadData]; // In case the number of sections (below) has changed since modal dismissal
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([contact.addressBookID intValue] > 0) {
        NSLog(@"address book %@", contact.addressBookID);
        return 2;
    }
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 2) {
        NSString *phone = phoneLabel.text;
        phone = [[phone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];

        NSString *phoneURL = [NSString stringWithFormat:@"tel://%@", phone];
        NSURL *URL = [NSURL URLWithString:phoneURL];
        [[UIApplication sharedApplication] openURL:URL];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)displayPerson:(ABRecordRef)person
{
    
    NSString* firstName = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                         kABPersonFirstNameProperty);
    NSString* lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                        kABPersonLastNameProperty);
    
    self.firstNameLabel.text = firstName;
    self.lastNameLabel.text = lastName;
    [self.firstNameLabel sizeToFit];
    [self.lastNameLabel sizeToFit];

    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"";
    }
    self.phoneLabel.text = phone;
    [self.phoneLabel sizeToFit];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"editContact"]) {
        EditContactViewController *nextView = segue.destinationViewController;
        nextView.contact = contact;
//        [nextView setDelegate:self];
    }
}



@end
