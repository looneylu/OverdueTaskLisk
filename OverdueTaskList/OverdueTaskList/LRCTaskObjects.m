//
//  LRCTaskObjects.m
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/25/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "LRCTaskObjects.h"

@implementation LRCTaskObjects



#pragma mark - Lazy Instantiation

- (NSMutableArray *) taskObjects
{
    if (!_taskObjects)
        _taskObjects = [[NSMutableArray alloc] init];
    
    return _taskObjects;
}

- (NSMutableArray *) tasksAsPLists
{
    if (!_tasksAsPLists)
        _tasksAsPLists = [[NSMutableArray alloc] init];
    
    return _tasksAsPLists;
}

@end
