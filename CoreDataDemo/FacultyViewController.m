//
//  FacultyViewController.m
//  CoreDataDemo
//
//  Created by dharmesh on 8/2/16.
//  Copyright © 2016 dharmesh. All rights reserved.
//

#import "FacultyViewController.h"
#import <CoreData/CoreData.h>
#import "FacultyTableViewCell.h"
#import "FacultyDetailViewController.h"


@interface FacultyViewController ()

@end

@implementation FacultyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    filteredArray=[[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Faculty"];
    self.facultyArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [_tblView reloadData];
}
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}
#pragma mark Tableview Delegates Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearching)
    {
        return [filteredArray count];
    }
    else
        
        
    {
        return [self.facultyArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FacultyTableViewCell *cell = [_tblView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (isSearching)
    {
        NSManagedObject *device = [filteredArray objectAtIndex:indexPath.row];
        [cell.lblFDept setText:[device valueForKey:@"department"]];
        [cell.lblFContact setText:[device valueForKey:@"contactno"]];
        [cell.lblFname setText:[device valueForKey:@"facultyname"]];
    }
    else
    {
        NSManagedObject *device = [self.facultyArray objectAtIndex:indexPath.row];
        [cell.lblFDept setText:[device valueForKey:@"department"]];
        [cell.lblFContact setText:[device valueForKey:@"contactno"]];
        [cell.lblFname setText:[device valueForKey:@"facultyname"]];
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
//        [context deleteObject:[self.facultyArray objectAtIndex:indexPath.row]];
//        
//        NSError *error = nil;
//        if (![context save:&error]) {
//            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
//            return;
//        }
//        
//        // Remove device from table view
//        [self.facultyArray removeObjectAtIndex:indexPath.row];
//        [self.tblView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
    {
        [context deleteObject:[self.facultyArray objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error])
        {
            NSLog(@"Can't Delete! %@ %@",error,[error localizedDescription]);
            return;
        }
        // Remove device from table view
        [self.facultyArray removeObjectAtIndex:indexPath.row];
        [self.tblView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];}];
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
    for (int i=0; i<[self.facultyArray count]; i++)
    {
        NSPredicate *myPredicate=[NSPredicate predicateWithFormat:@"(facultyname BEGINSWITH[cd] %@) OR (contactno BEGINSWITH[c] %@) OR (department BEGINSWITH[cd] %@)", self.searchbar.text, self.searchbar.text,self.searchbar.text];

        NSArray *tempAry = [self.facultyArray filteredArrayUsingPredicate:myPredicate];
        filteredArray = [NSMutableArray arrayWithArray: tempAry];
        NSLog(@"%@",self.facultyArray);

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
    [self.tblView reloadData];
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
        NSManagedObject *selectedDevice = [self.facultyArray objectAtIndex:[[self.tblView indexPathForSelectedRow] row]];
        FacultyDetailViewController *destViewController = segue.destinationViewController;
        destViewController.device = selectedDevice;
    }
}
- (IBAction)btnBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
