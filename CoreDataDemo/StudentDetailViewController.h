//
//  DetailViewController.h
//  CoreDataDemo
//
//  Created by dharmesh on 8/1/16.
//  Copyright © 2016 dharmesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface StudentDetailViewController : UIViewController
- (IBAction)btnCancel:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtDept;
@property (weak, nonatomic) IBOutlet UITextField *txtStudname;

@property (weak, nonatomic) IBOutlet UITextField *txtEnrollNo;
- (IBAction)btnSave:(id)sender;
@property (strong) NSManagedObject *device;
@end
