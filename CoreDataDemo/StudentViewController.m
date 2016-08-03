//
//  ViewController.m
//  CoreDataDemo
//
//  Created by dharmesh on 8/1/16.
//  Copyright © 2016 dharmesh. All rights reserved.
//

#import "StudentViewController.h"
#import <CoreData/CoreData.h>
#import "StudentTableViewCell.h"
#import "StudentDetailViewController.h"

@interface StudentViewController ()

@end

@implementation StudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    filteredArray=[[NSMutableArray alloc]init];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAddAction:(id)sender{
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
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Device"];
    self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [_tblview reloadData];
}

#pragma mark tableview delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearching) {
        return [filteredArray count];
    }
    else {
        return [self.devices count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableViewCell";
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    StudentTableViewCell *cell = (StudentTableViewCell *)[self.tblview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (isSearching)
    {
        NSManagedObject *device = [filteredArray objectAtIndex:indexPath.row];
        [cell.lblDept setText:[device valueForKey:@"department"]];
        [cell.lblEnmentNo setText:[device valueForKey:@"enrollmentno"]];
        [cell.lblstudentname setText:[device valueForKey:@"studentname"]];
    }
    else
    {
        NSManagedObject *device = [self.devices objectAtIndex:indexPath.row];
        [cell.lblDept setText:[device valueForKey:@"department"]];
        [cell.lblEnmentNo setText:[device valueForKey:@"enrollmentno"]];
        [cell.lblstudentname setText:[device valueForKey:@"studentname"]];
    }
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSManagedObjectContext *context = [self managedObjectContext];
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete object from database
//        [context deleteObject:[self.devices objectAtIndex:indexPath.row]];
//        
//        NSError *error = nil;
//        if (![context save:&error]) {
//            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
//            return;
//        }
//        
//        // Remove device from table view
//        [self.devices removeObjectAtIndex:indexPath.row];
//        [self.tblview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
    {
        [context deleteObject:[self.devices objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error])
        {
        NSLog(@"Can't Delete! %@ %@",error,[error localizedDescription]);
        return;
        }
        // Remove device from table view
        [self.devices removeObjectAtIndex:indexPath.row];
        [self.tblview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];}];
    delete.backgroundColor = [UIColor redColor];
    
    UITableViewRowAction *more = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Edit " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
        {
            [self performSegueWithIdentifier:@"Update" sender:self];
        }];
    more.backgroundColor = [UIColor colorWithRed:0.188 green:0.514 blue:0.984 alpha:1];
    
    return @[delete, more];
    
}
#pragma mark Searchbar Delegates Method

- (void)searchTableList
{
    for (int i=0; i<[self.devices count]; i++)
    {
        NSPredicate *myPredicate=[NSPredicate predicateWithFormat:@"(department BEGINSWITH[cd] %@) OR (studentname BEGINSWITH[c] %@) OR (enrollmentno BEGINSWITH[cd] %@)", self.searchbar.text, self.searchbar.text,self.searchbar.text];
        
        NSArray *tempAry = [self.devices filteredArrayUsingPredicate:myPredicate];
        filteredArray = [NSMutableArray arrayWithArray: tempAry];
        NSLog(@"%@",self.devices);
        
    }
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",isSearching);
    
    //Remove all objects first.
    [filteredArray removeAllObjects];
    
    if([searchText length] != 0) {
        isSearching = YES;
        [self searchTableList];
    }
    else {
        isSearching = NO;
    }
    [self.tblview reloadData];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Update"]) {
        NSManagedObject *selectedDevice = [self.devices objectAtIndex:[[self.tblview indexPathForSelectedRow] row]];
        StudentDetailViewController *destViewController = segue.destinationViewController;
        destViewController.device = selectedDevice;
    }
}
- (IBAction)btnBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
