//
//  FacultyDetailViewController.m
//  CoreDataDemo
//
//  Created by dharmesh on 8/2/16.
//  Copyright © 2016 dharmesh. All rights reserved.
//

#import "FacultyDetailViewController.h"
#import <CoreData/CoreData.h>

@interface FacultyDetailViewController ()

@end

@implementation FacultyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.device)
    {
        [self.txtFdept setText:[self.device valueForKey:@"department"]];
        [self.txtFname setText:[self.device valueForKey:@"facultyname"]];
        [self.txtFContactNo setText:[self.device valueForKey:@"contactno"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (IBAction)btnCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)btnSave:(id)sender
{
    
    if ([self.txtFdept.text isEqualToString:@""])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter Deparment" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:cancel];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if ([self.txtFname.text isEqualToString:@""])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter Faculty Name" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:cancel];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else if ([self.txtFContactNo.text isEqualToString:@""])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Enter Contact Number" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:cancel];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else if ((self.txtFContactNo.text.length) > 11)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Contact Number should be 10 digit" preferredStyle:UIAlertControllerStyleAlert];
        
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
            [self.device setValue:self.txtFdept.text forKey:@"department"];
            [self.device setValue:self.txtFname.text forKey:@"facultyname"];
            [self.device setValue:self.txtFContactNo.text forKey:@"contactno"];
        }
        else
        {
            // Create a new device
            NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Faculty" inManagedObjectContext:context];
            
            [newDevice setValue:self.txtFdept.text forKey:@"department"];
            [newDevice setValue:self.txtFname.text forKey:@"facultyname"];
            [newDevice setValue:self.txtFContactNo.text forKey:@"contactno"];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error])
        {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }

}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
@end
