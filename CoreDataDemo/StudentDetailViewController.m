//
//  DetailViewController.m
//  CoreDataDemo
//
//  Created by dharmesh on 8/1/16.
//  Copyright © 2016 dharmesh. All rights reserved.
//

#import "StudentDetailViewController.h"
#import <CoreData/CoreData.h>

@interface StudentDetailViewController ()
@end

@implementation StudentDetailViewController
@synthesize device;
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.device)
    {
        [self.txtDept setText:[self.device valueForKey:@"department"]];
        [self.txtStudname setText:[self.device valueForKey:@"studentname"]];
        [self.txtEnrollNo setText:[self.device valueForKey:@"enrollmentno"]];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnSave:(id)sender
{
    if ([self.txtDept.text isEqualToString:@""])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter Deparment" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:cancel];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if ([self.txtStudname.text isEqualToString:@""])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter Student Name" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:cancel];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
    else if ([self.txtEnrollNo.text isEqualToString:@""])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter Enrollment Number" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:cancel];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
    else if ((self.txtEnrollNo.text.length) < 12)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Enrollment should be 12 digit" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:cancel];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }

    else
    {
        NSManagedObjectContext *context = [self managedObjectContext];
    
        if (self.device)
        {
            // Update existing device
            [self.device setValue:self.txtDept.text forKey:@"department"];
            [self.device setValue:self.txtStudname.text forKey:@"studentname"];
            [self.device setValue:self.txtEnrollNo.text forKey:@"enrollmentno"];
        }
        else
        {
        // Create a new device
            NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
            
            [newDevice setValue:self.txtDept.text forKey:@"department"];
            [newDevice setValue:self.txtStudname.text forKey:@"studentname"];
            [newDevice setValue:self.txtEnrollNo.text forKey:@"enrollmentno"];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error])
        {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}
- (IBAction)btnCancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

//-(BOOL)textFieldShouldReturn:(UITextField*)textField
//{
//    NSInteger nextTag = textField.tag + 1;
//    // Try to find next responder
//    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
//    if (nextResponder) {
//        // Found next responder, so set it.
//        [nextResponder becomeFirstResponder];
//    } else {
//        // Not found, so remove keyboard.
//        [textField resignFirstResponder];
//    }
//    return NO; // We do not want UITextField to insert line-breaks.
//}
@end
