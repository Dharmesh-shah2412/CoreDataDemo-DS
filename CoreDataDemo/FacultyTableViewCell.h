//
//  FacultyTableViewCell.h
//  CoreDataDemo
//
//  Created by dharmesh on 8/2/16.
//  Copyright © 2016 dharmesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacultyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblFDept;
@property (weak, nonatomic) IBOutlet UILabel *lblFname;
@property (weak, nonatomic) IBOutlet UILabel *lblFContact;

@end
