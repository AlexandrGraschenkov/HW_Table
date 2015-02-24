//
//  ViewController.m
//  HW_Table
//
//  Created by Евгений Сергеев on 05.02.15.
//  Copyright (c) 2015 Евгений Сергеев. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *arr1;
    NSMutableArray *arr2;
    NSMutableIndexSet *ind1;
    NSMutableIndexSet *ind2;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ind1 = [[NSMutableIndexSet alloc] init];
    ind2 = [[NSMutableIndexSet alloc] init];
    
    arr1 = [[NSMutableArray alloc] initWithObjects:@"Апельсины", @"Яблоки", @"Мандарины", nil];
    arr2 = [[NSMutableArray alloc] initWithObjects:@"Лук", @"Помидоры", @"Капуста", nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr1.count + arr2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView == self.table1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1" forIndexPath:indexPath];
        if (indexPath.row < arr1.count)
            cell.textLabel.text = [arr1 objectAtIndex:indexPath.row];
        else
            cell.textLabel.text = @"";
        
        if ([ind1 containsIndex:indexPath.row])
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
        if (indexPath.row < arr2.count)
            cell.textLabel.text = [arr2 objectAtIndex:indexPath.row];
        else
            cell.textLabel.text = @"";
        
        if ([ind2 containsIndex:indexPath.row])
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView == self.table1) {
        if (indexPath.row < arr1.count) {
            if (![ind1 containsIndex:indexPath.row]) {
                [ind1 addIndex:indexPath.row];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                [ind1 removeIndex:indexPath.row];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
    if (tableView == self.table2) {
        if (indexPath.row < arr2.count) {
            if (![ind2 containsIndex:indexPath.row]) {
                [ind2 addIndex:indexPath.row];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                [ind2 removeIndex:indexPath.row];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
}


- (IBAction)addBot {
    __block NSInteger counter = 0;
    [ind1 enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [arr2 addObject:[arr1 objectAtIndex:idx-counter]];
        [arr1 removeObjectAtIndex:idx-counter];
        counter++;
    }];
    [ind1 removeAllIndexes];
    [self.table1 reloadData];
    [self.table2 reloadData];
}

- (IBAction)addTop {
    __block NSInteger counter = 0;
    [ind2 enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [arr1 addObject:[arr2 objectAtIndex:idx-counter]];
        [arr2 removeObjectAtIndex:idx-counter];
        counter++;
    }];
    [ind2 removeAllIndexes];
    [self.table1 reloadData];
    [self.table2 reloadData];
}
@end
