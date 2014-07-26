//
//  DetailTaskViewController.m
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "DetailTaskViewController.h"
#import "EditTaskViewController.h"

@interface DetailTaskViewController () <EditTaskViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *statusButton;

@end

@implementation DetailTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.taskTitleLabel.text = self.task.title;
    self.descriptionTextField.text = self.task.description;
    
    // format date to display MM-dd-yyyy
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    self.dateLabel.text = [dateFormat stringFromDate:self.task.date];
    
    // set status button color
    [self setStatusButtonColor];
}

#pragma mark - IBAction Methods

- (IBAction)editButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"toEditTaskVC" sender:nil];
}

- (IBAction)statusButtonPressed:(id)sender
{
    // allows user to change status of task
    [self changeStatusButtonColor];
}

#pragma mark - Delegate Methods

- (void) didEditTask:(LRCTask *)editedTask
{
    // replace task's edited information
    
    // if the task's title changed update information for task object
    // and taskTitle label
    if (![self.task.title isEqualToString:editedTask.title])
    {
        self.task.title = editedTask.title;
        self.taskTitleLabel.text = self.task.title;
    }
    
    // if the description changed, update task and label
    if (![self.task.description isEqualToString:editedTask.description])
    {
        self.task.description = editedTask.description;
        self.descriptionTextField.text = editedTask.description;
    }
    
    // if the date changed, update task and dateLabel
    if (self.task.date != editedTask.date)
    {
        self.task.date = editedTask.date;
        
        //format date for label
        NSDateFormatter *formattedDate = [[NSDateFormatter alloc] init];
        [formattedDate setDateStyle:NSDateFormatterMediumStyle];
        self.dateLabel.text = [formattedDate stringFromDate:self.task.date];
    }
    
    if (self.task.completion != editedTask.completion)
    {
        self.task.completion = editedTask.completion; 
        [self setStatusButtonColor];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    // call delgate method and pass information back to previous view controller
    [self.delegate taskPropertyChanged:self.task :self.taskIndex]; 
}

#pragma mark - Helper Methods

- (void) changeStatusButtonColor
{
    // the button will be green if the task is completed
    // the button will be yellow if it is pending
    // the button will be red if it's past due
    if (self.task.completion && ![self.task isTaskPastDue])
    {
        self.statusButton.backgroundColor = [UIColor yellowColor];
        [self.statusButton setTitle:@"Pending" forState:UIControlStateNormal];
        self.task.completion = NO;
    } else if (self.task.completion && [self.task isTaskPastDue])
    {
        self.statusButton.backgroundColor = [UIColor redColor];
        [self.statusButton setTitle:@"Past Due" forState:UIControlStateNormal];
        self.task.completion = NO;
    } else
    {
        self.statusButton.backgroundColor = [UIColor greenColor];
        [self.statusButton setTitle:@"Completed" forState:UIControlStateNormal];
        self.task.completion = YES;
    }
    
    // call delegate method to pass information to previous view
    [self.delegate taskPropertyChanged:self.task :self.taskIndex];
}

- (void) setStatusButtonColor
{
    // the button will be green if the task is completed
    // the button will be yellow if it is pending
    // the button will be red if it's past due
    if (self.task.completion){
        self.statusButton.backgroundColor = [UIColor greenColor];
        [self.statusButton setTitle:@"Complete" forState:UIControlStateNormal];
    } else if (!self.task.completion && ![self.task isTaskPastDue])
    {
        self.statusButton.backgroundColor = [UIColor yellowColor];
        [self.statusButton setTitle:@"Pending" forState:UIControlStateNormal];
    } else
    {
        self.statusButton.backgroundColor = [UIColor redColor];
        [self.statusButton setTitle:@"Past Due" forState:UIControlStateNormal];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[EditTaskViewController class]])
    {
        EditTaskViewController *editTaskVC = segue.destinationViewController;
        editTaskVC.task = self.task;
        
        editTaskVC.delegate = self;
    }
}


@end
