//
//  DetailTaskViewController.h
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTaskViewController : UIViewController

@property (nonatomic, strong) NSString *taskTitle;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *date;

@end
