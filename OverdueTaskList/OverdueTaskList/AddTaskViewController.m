//
//  AddTaskViewController.m
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //make sure textField responds to UITextField Delegate methods
    self.textField.delegate = self;
}

#pragma mark - IBAction Methods

- (IBAction)addTaskButtonPressed:(id)sender
{
    // get task information and pass to delegate method and call delegate method
    [self.delegate didAddTask:[self retrieveTaskInformation]]; 
}

- (IBAction)cancelButtonPressed:(id)sender
{
    // call delegate method
    [self.delegate didCancel];
}

#pragma mark - Helper Methods

- (LRCTask *) retrieveTaskInformation
{
    // make a dictionary with user input
    NSDictionary *addedTask = @{TITLE : self.textField.text, DESCRIPTION : self.textView.text, DATE : self.datePicker.date, COMPLETION : @NO};
    
    // make a new task object with information from added task dictionary
    LRCTask *newTask = [[LRCTask alloc] initWithData:addedTask];
    
    return newTask;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
