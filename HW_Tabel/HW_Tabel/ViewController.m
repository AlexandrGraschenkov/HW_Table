

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (weak, nonatomic) IBOutlet UITableView *tabelView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabelView.allowsMultipleSelectionDuringEditing = YES;
    self.tabelView2.allowsMultipleSelectionDuringEditing = YES;
    
    array = [NSMutableArray new];
    array1 = [NSMutableArray new];
    
    [array addObject:@"Obivan Kenobi"];
    [array1 addObject:@"Dard Veider"];
    [array1 addObject:@"Dark Moll"];
    [array addObject:@"Leya"];
    [array addObject:@"Luk Skyvoker"];
    [array1 addObject:@"Imperator"];
    [array addObject:@"Yoda"];
    
    [self.tabelView setEditing:YES animated:YES];
    [self.tabelView2 setEditing:YES animated:YES];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tabelView) {
        return array.count;
    } else {
        return array1.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tabelView) {
        static NSString *CellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        cell.textLabel.text = [array objectAtIndex:indexPath.row];
        
        return cell;
        
    } else {
        static NSString *CellID = @"cellID2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        cell.textLabel.text = [array1 objectAtIndex:indexPath.row];
        
        return cell;
    }
}

- (IBAction)down:(id)sender {
    NSMutableArray *ss = [[NSMutableArray alloc] init];
    NSArray *selectedRows = [self.tabelView indexPathsForSelectedRows];
    BOOL deleteSpecificRows = selectedRows.count > 0;
    if (deleteSpecificRows)
    {
        // Build an NSIndexSet of all the objects to delete, so they can all be removed at once.
        NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];
        for (NSIndexPath *selectionIndex in selectedRows)
        {
            [indicesOfItemsToDelete addIndex:selectionIndex.row];
            [ss addObject: array[selectionIndex.row]];
        }
        // Delete the objects from our data model.
        [array removeObjectsAtIndexes:indicesOfItemsToDelete];
        
        // Tell the tableView that we deleted the objects
        [self.tabelView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        
        for (int i = 0; i < ss.count; i++) {
            
            [self.tabelView2 beginUpdates];
            
            // Add an item to the array.
            [array1 addObject:ss[i]];
            
            // Tell the tableView about the item that was added.
            NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(array1.count - 1) inSection:0];
            [self.tabelView2 insertRowsAtIndexPaths:@[indexPathOfNewItem]
                                   withRowAnimation:UITableViewRowAnimationAutomatic];
            
            // Tell the tableView we have finished adding or removing items.
            [self.tabelView2 endUpdates];
            
            // Scroll the tableView so the new item is visible
            [self.tabelView2 scrollToRowAtIndexPath:indexPathOfNewItem
                                   atScrollPosition:UITableViewScrollPositionBottom
                                           animated:YES];
            
        }
        
    }
    
    
}

- (IBAction)up:(id)sender {
    
    NSMutableArray *ss = [[NSMutableArray alloc] init];
    NSArray *selectedRows = [self.tabelView2 indexPathsForSelectedRows];
    BOOL deleteSpecificRows = selectedRows.count > 0;
    if (deleteSpecificRows)
    {
        // Build an NSIndexSet of all the objects to delete, so they can all be removed at once.
        NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];
        for (NSIndexPath *selectionIndex in selectedRows)
        {
            [indicesOfItemsToDelete addIndex:selectionIndex.row];
            [ss addObject: array1[selectionIndex.row]];
        }
        // Delete the objects from our data model.
        [array1 removeObjectsAtIndexes:indicesOfItemsToDelete];
        
        // Tell the tableView that we deleted the objects
        [self.tabelView2 deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        
        for (int i = 0; i < ss.count; i++) {
            
            [self.tabelView beginUpdates];
            
            // Add an item to the array.
            [array addObject:ss[i]];
            
            // Tell the tableView about the item that was added.
            NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(array.count - 1) inSection:0];
            [self.tabelView insertRowsAtIndexPaths:@[indexPathOfNewItem]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            
            // Tell the tableView we have finished adding or removing items.
            [self.tabelView endUpdates];
            
            // Scroll the tableView so the new item is visible
            [self.tabelView scrollToRowAtIndexPath:indexPathOfNewItem
                                  atScrollPosition:UITableViewScrollPositionBottom
                                          animated:YES];
            
        }
    }
}

@end
