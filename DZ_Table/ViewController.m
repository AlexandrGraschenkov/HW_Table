//
//  ViewController.m
//  DZ_Table
//
//  Created by Admin on 27.12.14.
//  Copyright (c) 2014 Aynur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *Table1;
@property (weak, nonatomic) IBOutlet UITableView *Table2;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arrayTop = [[NSMutableArray alloc]init];
    arrayBot = [[NSMutableArray alloc]init];
    [arrayTop addObject:@"Бананы"];
    [arrayTop addObject:@"Коли"];
    [arrayTop addObject:@"Мандаринки"];
    [arrayTop addObject:@"Огурчики"];
    [arrayBot addObject:@"Матлогики"];
    self.Table1.allowsMultipleSelectionDuringEditing = YES;
    self.Table2.allowsMultipleSelectionDuringEditing = YES;
    [self.Table1 setEditing:YES animated:YES];
    [self.Table2 setEditing:YES animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)up:(id)sender {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *selectedRows = [self.Table2 indexPathsForSelectedRows];
    BOOL deleteSpecificRows = selectedRows.count > 0;
    self.Table1.allowsMultipleSelectionDuringEditing = NO;
    self.Table2.allowsMultipleSelectionDuringEditing = NO;
    self.Table1.allowsMultipleSelectionDuringEditing = YES;
    self.Table2.allowsMultipleSelectionDuringEditing = YES;
    if (deleteSpecificRows)
    {
        NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];
        for (NSIndexPath *selectionIndex in selectedRows)
        {
            [indicesOfItemsToDelete addIndex:selectionIndex.row];
            [array addObject: arrayBot[selectionIndex.row]];
        }
        [arrayBot removeObjectsAtIndexes:indicesOfItemsToDelete];
        [self.Table2 deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        for (int i = 0; i < array.count; i++) {
            [self.Table1 beginUpdates];
            [arrayTop addObject:array[i]];
            NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(arrayTop.count - 1) inSection:0];
            [self.Table1 insertRowsAtIndexPaths:@[indexPathOfNewItem]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.Table1 endUpdates];
            [self.Table1 scrollToRowAtIndexPath:indexPathOfNewItem atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
}
- (IBAction)down:(id)sender {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *selectedRows = [self.Table1 indexPathsForSelectedRows];
    BOOL deleteSpecificRows = selectedRows.count > 0;
    self.Table1.allowsMultipleSelectionDuringEditing = NO;
    self.Table2.allowsMultipleSelectionDuringEditing = NO;
    self.Table1.allowsMultipleSelectionDuringEditing = YES;
    self.Table2.allowsMultipleSelectionDuringEditing = YES;
    if (deleteSpecificRows)
    {
        NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];
        for (NSIndexPath *selectionIndex in selectedRows)
        {
            [indicesOfItemsToDelete addIndex:selectionIndex.row];
            [array addObject: arrayTop[selectionIndex.row]];
        }
        [arrayTop removeObjectsAtIndexes:indicesOfItemsToDelete];
        [self.Table1 deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        for (int i = 0; i < array.count; i++) {
            [self.Table2 beginUpdates];
            [arrayBot addObject:array[i]];
            NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(arrayBot.count - 1) inSection:0];
            [self.Table2 insertRowsAtIndexPaths:@[indexPathOfNewItem]
                               withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.Table2 endUpdates];
            [self.Table2 scrollToRowAtIndexPath:indexPathOfNewItem atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.Table1){
        return [arrayTop count];
    }
    else{
        return [arrayBot count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.Table1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.textLabel.text = [arrayTop objectAtIndex:indexPath.row];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell.textLabel.text = [arrayBot objectAtIndex:indexPath.row];
        return cell;
    }
}



@end
