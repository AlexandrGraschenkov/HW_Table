//
//  main.m
//  HW_Table
//
//  Created by Admin on 28.12.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ViewController.h"
/*sdghggdgabshrgasdhgafshrga*/

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView2.allowsMultipleSelectionDuringEditing = YES;
    
    data_up = [NSMutableArray new];
    data_down = [NSMutableArray new];
    
    [data_up addObject:@"Бананы"];
    [data_up addObject:@"Огурцы"];
    [data_up addObject:@"Помидоры"];
    [data_up addObject:@"Яблоки"];
    [data_up addObject:@"Мандарины"];
    
    
    [self.tableView setEditing:YES animated:YES];
    [self.tableView2 setEditing:YES animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return data_up.count;
    } else {
        return data_down.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        static NSString *kCellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
        cell.textLabel.text = [data_up objectAtIndex:indexPath.row];
        
        return cell;

    } else {
        static NSString *kCellID = @"cellID2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
        cell.textLabel.text = [data_down objectAtIndex:indexPath.row];
        
        return cell;
    }
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
            [ss addObject: data_up[selectionIndex.row]];
        }
        // Delete the objects from our data model.
        [data_up removeObjectsAtIndexes:indicesOfItemsToDelete];
        
        // Tell the tableView that we deleted the objects
        [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    
        for (int i = 0; i < ss.count; i++) {

            [self.tableView2 beginUpdates];
            
            // Add an item to the array.
            [data_down addObject:ss[i]];
            
            // Tell the tableView about the item that was added.
            NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(data_down.count - 1) inSection:0];
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
            [ss addObject: data_down[selectionIndex.row]];
        }
        // Delete the objects from our data model.
        [data_down removeObjectsAtIndexes:indicesOfItemsToDelete];
        
        // Tell the tableView that we deleted the objects
        [self.tableView2 deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        
        for (int i = 0; i < ss.count; i++) {
            
            [self.tableView beginUpdates];
            
            // Add an item to the array.
            [data_up addObject:ss[i]];
            
            // Tell the tableView about the item that was added.
            NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(data_up.count - 1) inSection:0];
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
