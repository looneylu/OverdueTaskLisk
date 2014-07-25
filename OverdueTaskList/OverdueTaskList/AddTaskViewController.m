//
//  AddTaskViewController.m
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //make sure textField and textView respond to Delegate methods
    self.textField.delegate = self;
    self.textView.delegate = self;
    
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

#pragma mark - Delegate Methods

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // hide keyboard
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    } else
        return YES; 
}

#pragma mark - Helper Methods

- (LRCTask *) retrieveTaskInformation
{
    // make a new task object with information from user input
    LRCTask *newTask = [[LRCTask alloc] init];
    newTask.title = self.textField.text;
    newTask.date = self.datePicker.date;
    newTask.description = self.textView.text;
    newTask.completion = NO; 
    
    return newTask;
}


@end
