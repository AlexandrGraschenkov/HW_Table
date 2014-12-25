

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
    
    tableOne = [NSMutableArray new];
    tableTwo = [NSMutableArray new];
    
    [tableOne addObject:@"Яблоки"];
    [tableOne addObject:@"Огурцы"];
    [tableOne addObject:@"Помидоры"];
    [tableOne addObject:@"Мандарины"];
    [tableOne addObject:@"Бананы"];
    
    [self.tableView setEditing:YES animated:NO];
    [self.tableView2 setEditing:YES animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return tableOne.count;
    } else {
        return tableTwo.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        static NSString *kCellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
        cell.textLabel.text = [tableOne objectAtIndex:indexPath.row];
        
        return cell;

    } else {
        static NSString *kCellID = @"cellID2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
        cell.textLabel.text = [tableTwo objectAtIndex:indexPath.row];
        
        return cell;
    }
    }

- (IBAction)PastUp:(id)sender {
    

    NSArray *selectedRows = [self.tableView2 indexPathsForSelectedRows];
    BOOL deleteSpecificRows = selectedRows.count > 0;
    if (deleteSpecificRows)
    {
        
        for (NSIndexPath *rowId in selectedRows)
        {
         
        
            [tableOne addObject:tableTwo[rowId.row]];
            [tableTwo removeObjectAtIndex:rowId.row];
            NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(tableOne.count - 1) inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPathOfNewItem]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        [self.tableView2 deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (IBAction)PastDown:(id)sender {
    
    
    
    
    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    BOOL deleteSpecificRows = selectedRows.count > 0;
    if (deleteSpecificRows)
    {
        
        for (NSIndexPath *rowId in selectedRows)
        {
            
            
            [tableTwo addObject:tableOne[rowId.row]];
            [tableOne removeObjectAtIndex:rowId.row];
            NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(tableTwo.count - 1) inSection:0];
            [self.tableView2 insertRowsAtIndexPaths:@[indexPathOfNewItem]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


@end
