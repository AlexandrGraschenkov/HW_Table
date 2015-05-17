//
//  ViewController.m
//  Table
//
//  Created by Admin on 18.05.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSMutableArray *arr1;
    NSMutableArray *arr2;
    NSMutableIndexSet *tmp1;
    NSMutableIndexSet *tmp2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tmp1 = [[NSMutableIndexSet alloc] init];
    tmp2 = [[NSMutableIndexSet alloc] init];
    
    arr1 = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", nil];
    arr2 = [[NSMutableArray alloc] initWithObjects:@"5", @"6", @"7", @"8", nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UITableViewCell *cell;
    if (tableView == self.TopTable) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TopCell" forIndexPath:indexPath];
        if (indexPath.row < arr1.count) {
            cell.textLabel.text = [arr1 objectAtIndex:indexPath.row];
        } else {
            cell.textLabel.text = @"";
        }
        if ([tmp1 containsIndex:indexPath.row]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"BottomCell" forIndexPath:indexPath];
        if (indexPath.row < arr2.count) {
            cell.textLabel.text = [arr2 objectAtIndex:indexPath.row];
        } else {
            cell.textLabel.text = @"";
        }
        if ([tmp2 containsIndex:indexPath.row]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView == self.TopTable) {
        if (indexPath.row < arr1.count) {
            if (![tmp1 containsIndex:indexPath.row]) {
                [tmp1 addIndex:indexPath.row];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                [tmp1 removeIndex:indexPath.row];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
    if (tableView == self.BottomTable) {
        if (indexPath.row < arr2.count) {
            if (![tmp2 containsIndex:indexPath.row]) {
                [tmp2 addIndex:indexPath.row];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                [tmp2 removeIndex:indexPath.row];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
}


- (IBAction)addToBottom {
    __block NSInteger counter = 0;
    [tmp1 enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [arr2 addObject:[arr1 objectAtIndex:idx-counter]];
        [arr1 removeObjectAtIndex:idx-counter];
        counter++;
    }];
    [tmp1 removeAllIndexes];
    [self.TopTable reloadData];
    [self.BottomTable reloadData];
}

- (IBAction)addToTop {
    __block NSInteger counter = 0;
    [tmp2 enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [arr1 addObject:[arr2 objectAtIndex:idx-counter]];
        [arr2 removeObjectAtIndex:idx-counter];
        counter++;
    }];
    [tmp2 removeAllIndexes];
    [self.TopTable reloadData];
    [self.BottomTable reloadData];
}

@end
