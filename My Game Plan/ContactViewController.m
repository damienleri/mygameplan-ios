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
@synthesize firstNameLabel, lastNameLabel, nameLabel, noteLabel, phoneLabel, contact;

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
//        NSLog(@"setting label %@", nameLabel.text);
        
        // Get person's name and number from the Address Book
        ABRecordRef *person = ABAddressBookGetPersonWithRecordID(ABAddressBookCreate(), (ABRecordID) [contact.addressBookID intValue]);
        [self displayPerson:person];
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 2) {
        NSString *phone = phoneLabel.text;
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
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"editContact"]) {
        EditContactViewController *nextView = segue.destinationViewController;
        nextView.contact = contact;
//        nextView.isEditing = YES;
    }
}



@end
