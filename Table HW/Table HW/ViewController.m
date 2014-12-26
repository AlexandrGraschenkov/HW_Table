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
    
    NSMutableArray *temdDataArr = [NSMutableArray new];
    NSArray *selectedRowsFromBottom = [self.bottomTableView indexPathsForSelectedRows];
    if (selectedRowsFromBottom.count > 0)
    {
        NSMutableIndexSet *indexesToDelete = [NSMutableIndexSet new];
        for (NSIndexPath *path in selectedRowsFromBottom)
        {
            [indexesToDelete addIndex:path.row];
            [temdDataArr addObject:[self.bottomDataArr objectAtIndex:path.row]];
        }
        [self.bottomDataArr removeObjectsAtIndexes:indexesToDelete];
        [self.bottomTableView deleteRowsAtIndexPaths:selectedRowsFromBottom withRowAnimation:UITableViewRowAnimationAutomatic];
        
        for (int i=0; i < temdDataArr.count; i++) {
            [self.topTableView beginUpdates];
            [self.topDataArr addObject:temdDataArr[i]];
            
            NSIndexPath *itemIndexPath = [NSIndexPath indexPathForRow:(self.topDataArr.count - 1) inSection:0];
            [self.topTableView insertRowsAtIndexPaths:@[itemIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.topTableView endUpdates];
            
            [self.topTableView scrollToRowAtIndexPath:itemIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            self.topTableView.allowsMultipleSelectionDuringEditing = NO;
            self.bottomTableView.allowsMultipleSelectionDuringEditing = NO;
            self.topTableView.allowsMultipleSelectionDuringEditing = YES;
            self.bottomTableView.allowsMultipleSelectionDuringEditing = YES;
            
            self.topTableView.allowsMultipleSelection = NO;
            self.topTableView.allowsMultipleSelection = YES;
        }
    }
    
}

- (IBAction)downButtonPressed:(id)sender {
    
    NSMutableArray *temdDataArr = [NSMutableArray new];
    NSArray *selectedRowsFromTop = [self.topTableView indexPathsForSelectedRows];
    if (selectedRowsFromTop.count > 0)
    {
        NSMutableIndexSet *indexesToDelete = [NSMutableIndexSet new];
        for (NSIndexPath *path in selectedRowsFromTop)
        {
            [indexesToDelete addIndex:path.row];
            [temdDataArr addObject:[self.topDataArr objectAtIndex:path.row]];
        }
        [self.topDataArr removeObjectsAtIndexes:indexesToDelete];
        [self.topTableView deleteRowsAtIndexPaths:selectedRowsFromTop withRowAnimation:UITableViewRowAnimationAutomatic];
        
        for (int i=0; i < temdDataArr.count; i++) {
            [self.bottomTableView beginUpdates];
            [self.bottomDataArr addObject:temdDataArr[i]];
            
            NSIndexPath *itemIndexPath = [NSIndexPath indexPathForRow:(self.bottomDataArr.count - 1) inSection:0];
            [self.bottomTableView insertRowsAtIndexPaths:@[itemIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.bottomTableView endUpdates];
            
            [self.bottomTableView scrollToRowAtIndexPath:itemIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            self.topTableView.allowsMultipleSelectionDuringEditing = NO;
            self.bottomTableView.allowsMultipleSelectionDuringEditing = NO;
            self.topTableView.allowsMultipleSelectionDuringEditing = YES;
            self.bottomTableView.allowsMultipleSelectionDuringEditing = YES;
            
            self.bottomTableView.allowsMultipleSelection = NO;
            self.bottomTableView.allowsMultipleSelection = YES;
        }
    }
    
}
@end
