//
//  LRCViewController.m
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "LRCViewController.h"
#import "AddTaskViewController.h"

@interface LRCViewController () <AddTaskViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *taskObjects;

@end

@implementation LRCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Lazy Instantiation 

- (NSMutableArray *) taskObjects
{
    if (!_taskObjects)
        _taskObjects = [[NSMutableArray alloc] init];
    
    return _taskObjects;
}

#pragma mark - IBAction Methods

- (IBAction)addButtonPressed:(id)sender
{
    // perform segue
    [self performSegueWithIdentifier:@"toAddTaskVS" sender:sender];
}

- (IBAction)reorderButtonPressed:(id)sender
{

}

#pragma mark - Delegate Methods

- (void)didAddTask:(LRCTask *)task
{
    // add task to taskObjects array
    [self.taskObjects addObject:task];
    
    // create a mutable array to save to NSUser defaults
    // first check to see if there is NUserDefaults already has an array of of Task Objects
    NSMutableArray *addedTasks = [[[NSUserDefaults standardUserDefaults] arrayForKey:USER_TASKS] mutableCopy];
    // if addTasks is an empty array
    if (!addedTasks)
        addedTasks = [[NSMutableArray alloc] init];
    
    // add task object to addedTasks method
    [addedTasks addObject:[self taskObjectAsAPropertyList:task]];
    
    // persist addedTasks to NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:addedTasks forKey: USER_TASKS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //dismiss AddTaskViewController
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // reload table view
    [self.tableView reloadData];
    
}

- (void)didCancel
{
    // dismiss the AddTaskVieController without saving any information
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper Methods

- (NSDictionary *)taskObjectAsAPropertyList: (LRCTask *)taskObject
{
    // make a new dictionary from the taskObject information
    NSDictionary *task = @{TITLE : taskObject.title, DESCRIPTION : taskObject.description, DATE : taskObject.date, COMPLETION :@(taskObject.completion)};
    
    return task;
}

# pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // determine if the destinationViewController is the appropriate class
    // if it is, create a variable of the class and set value equal to segue.destinationViewController
    
    // AddTaskViewController
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]])
    {
        // create a variable of the class and set its delegate property to self
        AddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
}


@end
