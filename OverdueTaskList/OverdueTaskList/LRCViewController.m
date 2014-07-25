//
//  LRCViewController.m
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "LRCViewController.h"
#import "AddTaskViewController.h"

@interface LRCViewController () <AddTaskViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *taskObjects;
@property (nonatomic, strong) NSMutableArray *tasksAsPLists;

@end

@implementation LRCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 
    // set tableview data source and delegate to self
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // retrieve user defaults
    [self.tasksAsPLists addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:USER_TASKS]];
    
    // retrieve user defaults
    [self retrieveDefaults:self.tasksAsPLists];
    
}

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

#pragma mark - IBAction Methods

- (IBAction)addButtonPressed:(id)sender
{
    // perform segue to AddTaskViewController
    [self performSegueWithIdentifier:@"toAddTaskVC" sender:sender];
}

- (IBAction)reorderButtonPressed:(id)sender
{

}

#pragma mark - Delegate Methods

- (void)didAddTask:(LRCTask *)task
{
    // add task to taskObjects array
    [self.taskObjects addObject:task];
    
    // make a dictionary (PList) with data from task and add it to tasksAsPLists
    NSMutableDictionary *addedTask = [[self taskObjectAsAPropertyList:task] mutableCopy];
    [self.tasksAsPLists addObject:addedTask];

    
    // persist self.taskAsPLists to NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:self.tasksAsPLists forKey: USER_TASKS];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // count the number of task objects in taskObjects array and return value
    return [self.taskObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // configure cell
    // cell text label displays the task title
    // cell detail label displays the date it needs to be completed
    LRCTask *task = [self.taskObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = task.title;
    
    // format date to display MM-dd-yyyy
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    cell.detailTextLabel.text = [dateFormat stringFromDate:task.date];
    
    // check to see if task is past due
    // if task is past due, the cell's background should be red
    // otherwise, the the cell's background is yellow
    // but if task is completed, color should be green regardless
    if (task.completion)
        cell.backgroundColor = [UIColor greenColor];
    else if ([self isTaskPastDue:task.date])
        cell.backgroundColor = [UIColor redColor];
    else
        cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    // if accessory button is tapped, segue to DetailTaskViewController
    [self performSegueWithIdentifier:@"toDetailTaskVC" sender:nil];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get task from row at indexPath
    LRCTask *task = [self.taskObjects objectAtIndex:indexPath.row];
    
    // change completion status
    if (task.completion)
        task.completion = NO;
    else
        task.completion = YES;
    
    // update user defaults
    [self updateTaskCompletionForUserDefaults:task forIndexPath:indexPath];
    
    // update tableView
    [tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // allow cell to be edit
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // update taskObjects with deletion
    [self.taskObjects removeObjectAtIndex:indexPath.row];
    
    // update tasksAsPLists with deletion
    [self.tasksAsPLists removeObjectAtIndex:indexPath.row];
    
    // update user defaults
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TASKS];
    [[NSUserDefaults standardUserDefaults] setObject:self.tasksAsPLists forKey:USER_TASKS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Helper Methods

- (NSDictionary *)taskObjectAsAPropertyList: (LRCTask *)taskObject
{
    // make a new dictionary from the taskObject information
    NSDictionary *task = @{TITLE : taskObject.title, DESCRIPTION : taskObject.description, DATE : taskObject.date, COMPLETION : @(taskObject.completion)};
    
    return task;
}

- (void)retrieveDefaults:(NSMutableArray *)tasks
{
    // iterate through tasks array and retrieve dictionary key values for task objects
    for (NSDictionary *dictionary in tasks)
    {
        LRCTask *task = [[LRCTask alloc] init];
        task.title = [dictionary objectForKey:TITLE];
        task.description = [dictionary objectForKey:DESCRIPTION];
        task.date = [dictionary objectForKey:DATE];
        task.completion = [[dictionary objectForKey:COMPLETION] boolValue];

        // add task object to taskObjects array
        [self.taskObjects addObject:task];
    }
}

- (BOOL) isTaskPastDue:(NSDate *) date;
{
    // get current date
    NSDate *currentDate = [NSDate date];
    
    // compare date using timeIntervalSince1970 method
    if ([currentDate timeIntervalSince1970] > [date timeIntervalSince1970])
        return YES;
    else
        return NO;
}

- (void) updateTaskCompletionForUserDefaults: (LRCTask *)task forIndexPath: (NSIndexPath *)indexPath
{
    // update tasksAsPLists
    NSMutableDictionary *taskAsPList = [self.tasksAsPLists objectAtIndex:indexPath.row];
    [taskAsPList setObject:@(task.completion) forKey:COMPLETION];
    
    // update user defaults
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TASKS];
    [[NSUserDefaults standardUserDefaults] setObject:self.tasksAsPLists forKey:USER_TASKS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

#pragma mark - Navigation

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
