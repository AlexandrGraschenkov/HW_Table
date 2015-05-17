//
//  ViewController.h
//  Table
//
//  Created by Admin on 18.05.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *TopTable;
@property (weak, nonatomic) IBOutlet UITableView *BottomTable;

- (IBAction)addToBottom;
- (IBAction)addToTop;

@end

