//
//  FacultyViewController.h
//  CoreDataDemo
//
//  Created by dharmesh on 8/2/16.
//  Copyright © 2016 dharmesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacultyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableArray *filteredArray;
    BOOL isSearching;
}
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (strong) NSMutableArray *facultyArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
- (IBAction)btnBack:(id)sender;
@end
