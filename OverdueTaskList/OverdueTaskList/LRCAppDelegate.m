//
//  LRCAppDelegate.m
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "LRCAppDelegate.h"
#import "LRCTask.h"

@implementation LRCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSMutableArray *tasksAsPLists = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:USER_TASKS]];
    
    [self setBadgeNumber:tasksAsPLists];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSMutableArray *tasksAsPLists = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:USER_TASKS]];
    
    [self setBadgeNumber:tasksAsPLists];
}

#pragma mark - Helper Methods

- (LRCTask *)retrieveDefaults:(NSDictionary *)dictionary
{
    // retrieve task object from dictionary key values

    LRCTask *task = [[LRCTask alloc] init];
    task.title = [dictionary objectForKey:TITLE];
    task.description = [dictionary objectForKey:DESCRIPTION];
    task.date = [dictionary objectForKey:DATE];
    task.completion = [[dictionary objectForKey:COMPLETION] boolValue];
    
    return task;
}

- (void) setBadgeNumber:(NSMutableArray *) dictionaries
{
    int count = 0;
    
    // iterate through tasks in dictionaries, and if any are past due, increase count number
    for (NSDictionary *PList in dictionaries)
    {
        LRCTask *task = [self retrieveDefaults:PList];
        
        if ([task isTaskPastDue] && !task.completion)
            count++;
    }
    
    // set badge number;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}

@end
