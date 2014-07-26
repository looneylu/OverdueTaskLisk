//
//  EditTaskViewController.h
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRCTask.h"

@protocol EditTaskViewControllerDelegate <NSObject>

- (void) didEditTask :(LRCTask *) editedTask;

@end

@interface EditTaskViewController : UIViewController

@property (nonatomic, strong) LRCTask *task; 
@property (nonatomic, weak) id <EditTaskViewControllerDelegate> delegate; 

@end
