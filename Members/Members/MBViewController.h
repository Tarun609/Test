//
//  ViewController.h
//  Members
//
//  Created by Tarun on 23/9/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMembersInfoTableViewCell.h"

@interface MBViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *membersListTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

