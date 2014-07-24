//
//  AddTaskViewController.h
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRCTask.h"

@protocol AddTaskViewControllerDelegate <NSObject>

@required

- (void) didCancel;
- (void) didAddTask:(LRCTask *)task;

@end

@interface AddTaskViewController : UIViewController

@property (weak, nonatomic) id <AddTaskViewControllerDelegate> delegate;

@end
