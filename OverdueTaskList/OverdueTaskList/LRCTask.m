//
//  LRCTask.m
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/24/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "LRCTask.h"

@implementation LRCTask

#pragma mark - Initializer

- (id) init
{
    // call custom init method (initWithData)
    self = [self initWithData:nil];
    
    return self;
}

- (id) initWithData:(NSDictionary *)data
// returns instance of self with all of its properties set
{
    self = [super init];
    
    // set properties
    self.title = data[TITLE];
    self.description = data[DESCRIPTION];
    self.date = data[DATE];
    self.date = data[COMPLETION]; 
    
    return self;
}

@end
