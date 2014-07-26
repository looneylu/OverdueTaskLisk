//
//  EditTaskViewController.m
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (strong, nonatomic) IBOutlet UILabel *completionLabel;

@property (strong, nonatomic) IBOutlet UISwitch *completionSwitch;

@end

@implementation EditTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // make sure textField responds to delegate methods
    self.textField.delegate = self;
    self.textView.delegate = self;
    
    // display current task information
    self.textField.text = self.task.title;
    self.textView.text = self.task.description;
    self.datePicker.date = self.task.date;
    
    self.completionSwitch.on = self.task.completion; 
    
}

#pragma mark - IBAction Methods

- (IBAction)saveButtonPressed:(id)sender
{
    LRCTask *editedTask = [[LRCTask alloc] init];
    
    // update task information
    editedTask.title = self.textField.text;
    editedTask.description = self.textView.text;
    editedTask.date = self.datePicker.date;
    
    // call delegate method 
    [self.delegate didEditTask:editedTask];
}
- (IBAction)completionSwitch:(id)sender
{
    if (self.completionSwitch.on)
        self.task.completion = YES;
    else
        self.task.completion = NO;
}

#pragma mark - Delegate Methods

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // hide keyboard
    [textField resignFirstResponder];
    
    // if textField or textView are empty, disable save button
    if (textField.text.length > 0)
        self.saveButton.enabled = YES;
    else
        self.saveButton.enabled = NO;
    
    return YES;
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


@end
