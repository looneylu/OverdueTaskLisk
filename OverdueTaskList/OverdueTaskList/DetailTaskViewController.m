//
//  DetailTaskViewController.m
//  OverdueTaskList
//
//  Created by Luis Carbuccia on 7/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "DetailTaskViewController.h"

@interface DetailTaskViewController ()

@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DetailTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.taskTitleLabel.text = self.taskTitle;
    self.descriptionTextField.text = self.description;
    
    // format date to display MM-dd-yyyy
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    self.dateLabel.text = [dateFormat stringFromDate:self.date];

}

#pragma mark - IBAction Methods

- (IBAction)editButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"toEditTaskVC" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
