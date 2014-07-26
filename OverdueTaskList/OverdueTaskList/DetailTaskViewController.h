//
//  DetailTaskViewController.h
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRCTask.h"

@protocol DetailTaskViewDelegate

@required

- (void) taskPropertyChanged:(LRCTask *) task :(NSIndexPath *) indexPath;

@end

@interface DetailTaskViewController : UIViewController

@property (nonatomic,strong) NSIndexPath *taskIndex;
@property (nonatomic, strong) LRCTask *task;
@property (weak, nonatomic) id <DetailTaskViewDelegate> delegate; 

@end
