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
}

// Number of rows in the table view (tasks count)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}

// Populate each cell with a task
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.tasks[indexPath.row];
    return cell;
}

// Add task to the array and refresh the table view
- (IBAction)addTask:(id)sender {
    // Get the text from the text field
       NSString *task = self.taskTextField.text;
       
       // Ensure task is not empty
       if (task.length > 0) {
           [self.tasks addObject:task]; // Add task to the tasks array
           self.taskTextField.text = @""; // Clear the text field
           
           [self.tableView reloadData]; // Reload the table view to display the new task
       }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end


