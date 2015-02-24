//
//  ViewController.h
//  HW
//
//  Created by Евгений Сергеев on 24.02.15.
//  Copyright (c) 2015 Евгений Сергеев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *table1;
@property (weak, nonatomic) IBOutlet UITableView *table2;

- (IBAction)addBot;
- (IBAction)addTop;


@end

