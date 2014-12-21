//
//  ViewController.m
//  Table HW
//
//  Created by Daniil Novoselov on 22.12.14.
//  Copyright (c) 2014 Daniil Novoselov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property NSMutableArray *topDataArr;
@property NSMutableArray *bottomDataArr;
@property (weak, nonatomic) IBOutlet UITableView *topTableView;
@property (weak, nonatomic) IBOutlet UITableView *bottomTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topDataArr = [NSMutableArray arrayWithObjects:@"Соус", @"Капуста", @"Баклажаны", @"Яблоки", @"Соль", @"Тмин", @"Перец", @"Картофель", @"Макароны", @"Мясо", @"Морковь", @"Рис",  nil];
    self.bottomDataArr = [NSMutableArray arrayWithObjects:@"Чай", @"Кофе", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.topTableView) {
        return self.topDataArr.count;
    } else {
        return self.bottomDataArr.count;
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (tableView == self.topTableView) {
        cell.textLabel.text = [self.topDataArr objectAtIndex:indexPath.row];
    } else if (tableView == self.bottomTableView) {
        cell.textLabel.text = [self.bottomDataArr objectAtIndex:indexPath.row];
    }
    return cell;
}

- (IBAction)upButtonPressed:(id)sender {
    NSMutableArray *tempDataArr = [NSMutableArray new];

    // Deleting items from Bottom
    NSArray *selectedRowsFromBottom = [self.bottomTableView indexPathsForSelectedRows];
    if (selectedRowsFromBottom.count > 0) {
        
        for (NSIndexPath *selectionIndex in selectedRowsFromBottom){
            NSIndexPath *tempIndexPath = [self.bottomDataArr objectAtIndex:selectionIndex.row];
            [tempDataArr addObject:tempIndexPath];
            [self.bottomDataArr removeObjectAtIndex:selectionIndex.row];
        }
        [self.bottomTableView deleteRowsAtIndexPaths:selectedRowsFromBottom withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    // Adding deleted items to the Top
    [self.topDataArr addObjectsFromArray:tempDataArr];
    [self.topTableView reloadData];
}
- (IBAction)downButtonPressed:(id)sender {
    NSMutableArray *tempDataArr = [NSMutableArray new];
    
    // Deleting items from Top
    NSArray *selectedRowsFromTop = [self.topTableView indexPathsForSelectedRows];
    if (selectedRowsFromTop.count > 0) {
        
        for (NSIndexPath *selectionIndex in selectedRowsFromTop){
            NSIndexPath *tempIndexPath = [self.topDataArr objectAtIndex:selectionIndex.row];
            [tempDataArr addObject:tempIndexPath];
            [self.topDataArr removeObjectAtIndex:selectionIndex.row];
        }
        [self.topTableView deleteRowsAtIndexPaths:selectedRowsFromTop withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    // Adding deleted items to the Bottom
    [self.bottomDataArr addObjectsFromArray:tempDataArr];
    [self.bottomTableView reloadData];
}

@end
