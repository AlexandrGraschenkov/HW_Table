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

    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView2.allowsMultipleSelectionDuringEditing = YES;
    
    dataArray = [NSMutableArray new];
    dataArray2 = [NSMutableArray new];
    
    [dataArray addObject:@"Бананы"];
    [dataArray addObject:@"Огурцы"];
    [dataArray addObject:@"Помидоры"];
    [dataArray addObject:@"Яблоки"];
    [dataArray addObject:@"Мандарины"];
    [dataArray2 addObject:@"Помидоры"];
    
    [self.tableView setEditing:YES animated:YES];
    [self.tableView2 setEditing:YES animated:YES];
}

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
            self.tableView.allowsMultipleSelectionDuringEditing = NO;
            self.tableView2.allowsMultipleSelectionDuringEditing = NO;
            self.tableView.allowsMultipleSelectionDuringEditing = YES;
            self.tableView2.allowsMultipleSelectionDuringEditing = YES;
            
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
            self.tableView.allowsMultipleSelectionDuringEditing = NO;
            self.tableView2.allowsMultipleSelectionDuringEditing = NO;
            self.tableView.allowsMultipleSelectionDuringEditing = YES;
            self.tableView2.allowsMultipleSelectionDuringEditing = YES;
        }
    }
}
@end
