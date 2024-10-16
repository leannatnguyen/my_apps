//
//  ViewController.h
//  simpleToDoList
//
//  Created by Leanna Nguyen on 10/12/24.
//
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (void)toggleCheckbox:(UIButton *)sender;
- (IBAction)addTask:(id)sender;


@end

