//
//  ViewController.m
//  AddressBook
//
//  Created by Igor on 7/22/15.
//  Copyright © 2015 Steelkiwi. All rights reserved.
//

#import "ViewController.h"
@import AddressBook;
@import Contacts;


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

//- (IBAction)petTapped:(UIButton *)sender
//{
//    
//    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
//        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted)
//    {
//        UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot Add Contact"
//                                                                      message: @"You must give the app permission to add the contact first."
//                                                                     delegate: nil
//                                                            cancelButtonTitle: @"OK"
//                                                            otherButtonTitles: nil];
//        [cantAddContactAlert show];
//    }
//    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
//    {
//        [self addPetToContacts:sender];
//    }
//    else
//    {
//        //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
//        //3
//        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (!granted){
//                    //4
//                    UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot Add Contact"
//                                                                                  message: @"You must give the app permission to add the contact first."
//                                                                                 delegate:nil
//                                                                        cancelButtonTitle: @"OK"
//                                                                        otherButtonTitles: nil];
//                    [cantAddContactAlert show];
//                    return;
//                }
//                //5
//                [self addPetToContacts:sender];
//            });
//        });
//    }
//}
//
//- (void)addPetToContacts: (UIButton *) petButton
//{
//    NSString *petFirstName;
//    NSString *petLastName;
//    NSString *petPhoneNumber;
//    NSData   *petImageData;
//    
//    if (petButton.tag == 1)
//    {
//        petFirstName   = @"Cheesy";
//        petLastName    = @"Cat";
//        petPhoneNumber = @"2015552398";
//        petImageData   = UIImageJPEGRepresentation([UIImage imageNamed:@"contact_Cheesy.jpg"], 0.7f);
//    }
//    else if (petButton.tag == 2)
//    {
//        petFirstName   = @"Freckles";
//        petLastName    = @"Dog";
//        petPhoneNumber = @"3331560987";
//        petImageData   = UIImageJPEGRepresentation([UIImage imageNamed:@"contact_Freckles.jpg"], 0.7f);
//    }
//    else if (petButton.tag == 3)
//    {
//        petFirstName   = @"Maxi";
//        petLastName    = @"Dog";
//        petPhoneNumber = @"5438880123";
//        petImageData   = UIImageJPEGRepresentation([UIImage imageNamed:@"contact_Maxi.jpg"], 0.7f);
//    }
//    else if (petButton.tag == 4)
//    {
//        petFirstName   = @"Shippo";
//        petLastName    = @"Dog";
//        petPhoneNumber = @"7124779070";
//        petImageData   = UIImageJPEGRepresentation([UIImage imageNamed:@"contact_Shippo.jpg"], 0.7f);
//    }
//    
//    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
//    ABRecordRef pet = ABPersonCreate();
//    
//    ABRecordSetValue(pet, kABPersonFirstNameProperty, (__bridge CFStringRef)petFirstName, nil);
//    ABRecordSetValue(pet, kABPersonLastNameProperty, (__bridge CFStringRef)petLastName, nil);
//    
//    ABMutableMultiValueRef phoneNumbers = ABMultiValueCreateMutable(kABMultiStringPropertyType);
//    
//    ABMultiValueAddValueAndLabel(phoneNumbers, (__bridge CFStringRef)petPhoneNumber, kABPersonPhoneMainLabel, NULL);
//    ABRecordSetValue(pet, kABPersonPhoneProperty, phoneNumbers, NULL);
//    
//    ABPersonSetImageData(pet, (__bridge CFDataRef)petImageData, nil);
//    //Get all contacts
//    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
//    
//    for (id record in allContacts){
//        ABRecordRef thisContact = (__bridge ABRecordRef)record;
//        if (CFStringCompare(ABRecordCopyCompositeName(thisContact), ABRecordCopyCompositeName(pet), 0) == kCFCompareEqualTo)
//        {
//            //The contact already exists!
//            UIAlertView *contactExistsAlert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"There can only be one %@", petFirstName]
//                                                                        message:nil
//                                                                       delegate:nil
//                                                              cancelButtonTitle:@"OK"
//                                                              otherButtonTitles: nil];
//            [contactExistsAlert show];
//            return;
//        }
//    }
//    
//    ABAddressBookAddRecord(addressBookRef, pet, nil);
//    ABAddressBookSave(addressBookRef, nil);
//}

- (IBAction)petTapped:(UIButton *)sender
{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Cannot Add Contact"
                                                                                 message:@"You must give the app permission to add the contact first."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"CANCEL"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
        [alertController addAction:ok];
        UIAlertAction *settings = [UIAlertAction actionWithTitle:@"SETTINGS"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * __nonnull action) {
                                                             //////block begin///////
                                                             if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]])
                                                             {
                                                                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                                             }
                                                             /////block end//////////
                                                         }];
        [alertController addAction:settings];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (status == CNAuthorizationStatusAuthorized)
    {
        [self addPetToContacts:sender];
    }
    else //status == CNAuthorizationStatusNotDetermined
    {
        [[[CNContactStore alloc]init] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * __nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //////block begin///////
                if (!granted)
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Cannot Add Contact"
                                                                                             message:@"You must give the app permission to add the contact first."
                                                                                      preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"CANCEL"
                                                                 style:UIAlertActionStyleCancel
                                                               handler:nil];
                    [alertController addAction:ok];
                    UIAlertAction *settings = [UIAlertAction actionWithTitle:@"SETTINGS"
                                                                 style:UIAlertActionStyleDefault
                                                                     handler:^(UIAlertAction * __nonnull action) {
                                                                         //////block begin///////
                                                                         if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]])
                                                                         {
                                                                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                                                         }
                                                                         /////block end//////////
                                                                     }];
                    [alertController addAction:settings];
                    [self presentViewController:alertController animated:YES completion:nil];
                    return ;
                }
                else
                {
                    NSLog(@"Authorized");
                    [self addPetToContacts:sender];
                }
                /////block end//////////
            });
            
        }];
    }
    
}

- (void)addPetToContacts: (UIButton *) petButton
{
    NSString *petFirstName;
    NSString *petLastName;
    NSString *petPhoneNumber;
    NSData   *petImageData;

    if (petButton.tag == 1)
    {
        petFirstName   = @"Cheesy";
        petLastName    = @"Cat";
        petPhoneNumber = @"2015552398";
        petImageData   = UIImageJPEGRepresentation([UIImage imageNamed:@"contact_Cheesy.jpg"], 0.7f);
    }
    else if (petButton.tag == 2)
    {
        petFirstName   = @"Freckles";
        petLastName    = @"Dog";
        petPhoneNumber = @"3331560987";
        petImageData   = UIImageJPEGRepresentation([UIImage imageNamed:@"contact_Freckles.jpg"], 0.7f);
    }
    else if (petButton.tag == 3)
    {
        petFirstName   = @"Maxi";
        petLastName    = @"Dog";
        petPhoneNumber = @"5438880123";
        petImageData   = UIImageJPEGRepresentation([UIImage imageNamed:@"contact_Maxi.jpg"], 0.7f);
    }
    else if (petButton.tag == 4)
    {
        petFirstName   = @"Shippo";
        petLastName    = @"Dog";
        petPhoneNumber = @"7124779070";
        petImageData   = UIImageJPEGRepresentation([UIImage imageNamed:@"contact_Shippo.jpg"], 0.7f);
    }
    
    CNMutableContact *contact = [[CNMutableContact alloc]init];
    contact.imageData = petImageData;
    contact.givenName = petFirstName;
    contact.familyName = petLastName;
    contact.phoneNumbers = @[
                             [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile
                                                             value:[CNPhoneNumber phoneNumberWithStringValue:petPhoneNumber]],
                             [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone
                                                             value:[CNPhoneNumber phoneNumberWithStringValue:@"0980400218"]]
                             ];
    CNContactStore *store = [[CNContactStore alloc] init];
    CNSaveRequest  *request = [[CNSaveRequest alloc] init];
    
    NSPredicate *predicate = [CNContact predicateForContactsMatchingName:petFirstName];
    
    NSArray *keysToFetch = @[CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey,[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName]];//CNContactFormatter
    
    NSArray<CNContact*> *fetchedContacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keysToFetch error:nil];
    
    if (fetchedContacts && [fetchedContacts count] > 0)
    {
        
        for (CNContact *contact in fetchedContacts)
        {
            NSLog(@"first name : %@", contact.givenName);
            NSLog(@"last name : %@", contact.familyName);
            NSLog(@"full name : %@", [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName]);
            NSArray<CNLabeledValue<CNPhoneNumber*>*> *phoneNumbers = contact.phoneNumbers;
            NSLog(@"Phone numbers:");
            for (CNLabeledValue *lvalue in phoneNumbers)
            {
                 NSLog(@"%@ number : %@", [CNLabeledValue localizedStringForLabel:lvalue.label], ((CNPhoneNumber*)lvalue.value).stringValue);
            }
           
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Contact"
                                                                                 message:@"Contact allready exist."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        [request addContact:contact toContainerWithIdentifier:nil];
        if ([store executeSaveRequest:request error:nil])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Contact saved"
                                                                                     message:@"Contact was saved."
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }

}

@end
