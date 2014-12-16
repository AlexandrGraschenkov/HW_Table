//
//  ViewController.m
//  HW
//
//  Created by Admin on 14.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView2.allowsMultipleSelectionDuringEditing = YES;
    
    // populate the data array with some example objects
    dataArray = [NSMutableArray new];
    dataArray2 = [NSMutableArray new];
    NSString *itemFormatString = NSLocalizedString(@"Item %d", @"Format string for item");
    for (unsigned int itemNumber = 1; itemNumber <= 12; itemNumber++)
    {
        NSString *itemName = [NSString stringWithFormat:itemFormatString, itemNumber];
        [dataArray addObject:itemName];
    }
    
    [dataArray2 addObject:@"atat"];
    
    // make our view consistent
    
    
    [self.tableView setEditing:YES animated:YES];
    [self.tableView2 setEditing:YES animated:YES];

    
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return dataArray.count;
    } else {
        return dataArray2.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure a cell to show the corresponding string from the array.
    if (tableView == self.tableView) {
        static NSString *kCellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
        cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
        
        return cell;

    } else {
        static NSString *kCellID = @"cellID2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
        cell.textLabel.text = [dataArray2 objectAtIndex:indexPath.row];
        
        return cell;

    }
    }




- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // The user tapped one of the OK/Cancel buttons.
   // Delete what the user selected.
        NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
        BOOL deleteSpecificRows = selectedRows.count > 0;
        if (deleteSpecificRows)
        {
            // Build an NSIndexSet of all the objects to delete, so they can all be removed at once.
            NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];
            for (NSIndexPath *selectionIndex in selectedRows)
            {
                [indicesOfItemsToDelete addIndex:selectionIndex.row];
            }
            // Delete the objects from our data model.
            [dataArray removeObjectsAtIndexes:indicesOfItemsToDelete];
            
            // Tell the tableView that we deleted the objects
            [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        // Exit editing mode after the deletion.
}



- (IBAction)addAction:(id)sender
{
        // Tell the tableView we're going to add (or remove) items.
        [self.tableView beginUpdates];
    
        // Add an item to the array.
        [dataArray addObject:@"New Item"];
    
        // Tell the tableView about the item that was added.
        NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(dataArray.count - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPathOfNewItem]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    
        // Tell the tableView we have finished adding or removing items.
        [self.tableView endUpdates];
    
        // Scroll the tableView so the new item is visible
        [self.tableView scrollToRowAtIndexPath:indexPathOfNewItem
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:YES];
    
        // Update the buttons if we need to.
     //   [self updateButtonsToMatchTableState];
}

- (IBAction)down:(id)sender {
    NSMutableArray *ss = [[NSMutableArray alloc] init];
    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    BOOL deleteSpecificRows = selectedRows.count > 0;
    if (deleteSpecificRows)
    {
        // Build an NSIndexSet of all the objects to delete, so they can all be removed at once.
        NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];
        for (NSIndexPath *selectionIndex in selectedRows)
        {
            [indicesOfItemsToDelete addIndex:selectionIndex.row];
            [ss addObject: dataArray[selectionIndex.row]];
        }
        // Delete the objects from our data model.
        [dataArray removeObjectsAtIndexes:indicesOfItemsToDelete];
        
        // Tell the tableView that we deleted the objects
        [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    
        for (int i = 0; i < ss.count; i++) {

            [self.tableView2 beginUpdates];
            
            // Add an item to the array.
            [dataArray2 addObject:ss[i]];
            
            // Tell the tableView about the item that was added.
            NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(dataArray2.count - 1) inSection:0];
            [self.tableView2 insertRowsAtIndexPaths:@[indexPathOfNewItem]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            
            // Tell the tableView we have finished adding or removing items.
            [self.tableView2 endUpdates];
            
            // Scroll the tableView so the new item is visible
            [self.tableView2 scrollToRowAtIndexPath:indexPathOfNewItem
                                  atScrollPosition:UITableViewScrollPositionBottom
                                          animated:YES];

            
        }
    
    }

    
}

- (IBAction)up:(id)sender {
    
    NSMutableArray *ss = [[NSMutableArray alloc] init];
    NSArray *selectedRows = [self.tableView2 indexPathsForSelectedRows];
    BOOL deleteSpecificRows = selectedRows.count > 0;
    if (deleteSpecificRows)
    {
        // Build an NSIndexSet of all the objects to delete, so they can all be removed at once.
        NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];
        for (NSIndexPath *selectionIndex in selectedRows)
        {
            [indicesOfItemsToDelete addIndex:selectionIndex.row];
            [ss addObject: dataArray2[selectionIndex.row]];
        }
        // Delete the objects from our data model.
        [dataArray2 removeObjectsAtIndexes:indicesOfItemsToDelete];
        
        // Tell the tableView that we deleted the objects
        [self.tableView2 deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        
        for (int i = 0; i < ss.count; i++) {
            
            [self.tableView beginUpdates];
            
            // Add an item to the array.
            [dataArray addObject:ss[i]];
            
            // Tell the tableView about the item that was added.
            NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(dataArray.count - 1) inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPathOfNewItem]
                                   withRowAnimation:UITableViewRowAnimationAutomatic];
            
            // Tell the tableView we have finished adding or removing items.
            [self.tableView endUpdates];
            
            // Scroll the tableView so the new item is visible
            [self.tableView scrollToRowAtIndexPath:indexPathOfNewItem
                                   atScrollPosition:UITableViewScrollPositionBottom
                                           animated:YES];
            
            
        }
        
    }

    
}




@end
