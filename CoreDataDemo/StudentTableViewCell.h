//
//  TableViewCell.h
//  CoreDataDemo
//
//  Created by dharmesh on 8/1/16.
//  Copyright © 2016 dharmesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDept;
@property (weak, nonatomic) IBOutlet UILabel *lblstudentname;
@property (weak, nonatomic) IBOutlet UILabel *lblEnmentNo;


@end
