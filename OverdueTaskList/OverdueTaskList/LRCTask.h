//
//  LRCTask.h
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/24/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRCTask : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) BOOL completion;

- (id) initWithData:(NSDictionary *)data;

- (NSDictionary *)taskObjectAsAPropertyList;
- (BOOL) isTaskPastDue;

@end
