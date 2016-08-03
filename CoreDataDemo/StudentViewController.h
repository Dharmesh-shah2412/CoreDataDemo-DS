//
//  ViewController.h
//  CoreDataDemo
//
//  Created by dharmesh on 8/1/16.
//  Copyright © 2016 dharmesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *filteredArray;
    BOOL isSearching;
}
@property (weak, nonatomic) IBOutlet UITableView *tblview;
- (IBAction)btnAddAction:(id)sender;
@property (strong) NSMutableArray *devices;
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;

- (IBAction)btnBack:(id)sender;

@end

