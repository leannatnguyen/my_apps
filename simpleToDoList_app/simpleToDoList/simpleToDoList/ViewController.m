//
//  ViewController.m
//  simpleToDoList
//
//  Created by Leanna Nguyen on 10/12/24.
//

#import "ViewController.h"

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *tasks;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize the tasks array
    self.tasks = [[NSMutableArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Create a UILabel for the date
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, self.view.frame.size.width - 40, 30)];
    // Get the current date
    NSDate *currentDate = [NSDate date];
    
    // Format the date to a readable string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM dd, yyyy"];  // Example: October 16, 2024
    NSString *formattedDate = [dateFormatter stringFromDate:currentDate];
        
    // Set the formatted date as the text of the dateLabel
    dateLabel.text = formattedDate;
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = [UIFont systemFontOfSize:18.0];
        
    // Add the label to the view
    [self.view addSubview:dateLabel];
    
}

// Number of rows in the table view (tasks count)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}

// Populate each cell with a task
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
       
       // Remove any existing subviews (if reusing cells)
       for (UIView *subview in cell.contentView.subviews) {
           [subview removeFromSuperview];
       }

       // Get the task dictionary for this row
       NSDictionary *task = self.tasks[indexPath.row];
       
       // Create the checkbox button
       UIButton *checkboxButton = [UIButton buttonWithType:UIButtonTypeCustom];
       checkboxButton.frame = CGRectMake(10, 10, 30, 30);  // Position the checkbox on the left
       
       // Set checkbox appearance based on task state
       BOOL isChecked = [task[@"isChecked"] boolValue];
       if (isChecked) {
           [checkboxButton setTitle:@"☑️" forState:UIControlStateNormal];
       } else {
           [checkboxButton setTitle:@"⬜️" forState:UIControlStateNormal];
       }

       // Set the tag to identify which row this button belongs to
       checkboxButton.tag = indexPath.row;
       
       // Add action to the checkbox button to handle the tap event
       [checkboxButton addTarget:self action:@selector(toggleCheckbox:) forControlEvents:UIControlEventTouchUpInside];
       
       // Add the checkbox button to the cell's content view
       [cell.contentView addSubview:checkboxButton];

       // Create and set the task label (positioned to the right of the checkbox)
       UILabel *taskLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, cell.contentView.frame.size.width - 60, 30)];
       taskLabel.text = task[@"description"];
       
       // Add the label to the cell's content view
       [cell.contentView addSubview:taskLabel];

       return cell;
}
// Method to toggle the checkbox state
- (void)toggleCheckbox:(UIButton *)sender {
    NSInteger rowIndex = sender.tag;
    
    // Get the task and toggle its "isChecked" state
    NSMutableDictionary *task = [self.tasks[rowIndex] mutableCopy]; // Make a mutable copy of the task dictionary
    BOOL isChecked = [task[@"isChecked"] boolValue];
    task[@"isChecked"] = @(!isChecked); // Toggle the checked state
    
    // Update the tasks array with the modified task
    [self.tasks replaceObjectAtIndex:rowIndex withObject:task];
    
    // Reload the table view row to reflect the change
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

// Add task to the array and refresh the table view
- (IBAction)addTask:(id)sender {
    // Get the text from the text field
        NSString *taskDescription = self.taskTextField.text;
        
        // Ensure task is not empty
        if (taskDescription.length > 0) {
            // Create a task dictionary with description and unchecked state
            NSDictionary *task = @{@"description": taskDescription, @"isChecked": @(NO)};
            
            // Add task to the tasks array
            [self.tasks addObject:task];
            
            // Clear the text field
            self.taskTextField.text = @"";
            
            // Reload the table view to display the new task
            [self.tableView reloadData];
        }
}


@end


