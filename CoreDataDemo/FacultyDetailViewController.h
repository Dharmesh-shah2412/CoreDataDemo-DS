//
//  FacultyDetailViewController.h
//  CoreDataDemo
//
//  Created by dharmesh on 8/2/16.
//  Copyright © 2016 dharmesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FacultyDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtFdept;
@property (weak, nonatomic) IBOutlet UITextField *txtFname;
@property (weak, nonatomic) IBOutlet UITextField *txtFContactNo;
@property (strong) NSManagedObject *device;
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnSave:(id)sender;
@end
