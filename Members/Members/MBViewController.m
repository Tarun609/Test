//
//  ViewController.m
//  Members
//
//  Created by Tarun on 23/9/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

#import "MBViewController.h"
#import "MBMembersUtility.h"
#import "MBMembersInfoTableViewCell.h"
#import "MBDetailViewController.h"
#import "Constants.h"
@interface MBViewController ()<MBMembersInfoTableViewCellDelegate>
@property (nonatomic, strong) NSMutableArray *membersListArray;
@property NSMutableDictionary *dict_notes;
@property int count;
@end

@implementation MBViewController

#pragma mark view methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    _membersListTableView.hidden = YES;
    _activityIndicator.hidden = NO;
    [self.view bringSubviewToFront:_activityIndicator];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _membersListArray=[[NSMutableArray alloc]init];
    [self getMembersListwithlimit:7];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self.view viewWithTag:1010]removeFromSuperview];
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"notes"])
    {
        _dict_notes = [[[NSUserDefaults standardUserDefaults]valueForKey:@"notes"] mutableCopy];
    }
    [_membersListTableView reloadData];
}


#pragma mark getmemberlist

-(void)getMembersListwithlimit : (int)limit
{
    [[MBMembersUtility sharedUtility]getAllMembersListWithLimit:limit ResponceBlock:^(NSArray *responceArray, NSError *error)
    {
        _membersListTableView.hidden = NO;
        _activityIndicator.hidden = YES;
        if (error==nil&& responceArray!=nil) {
            [_membersListArray addObjectsFromArray:[responceArray mutableCopy]];
            [_membersListTableView reloadData];
            
            NSLog(@"%@",_membersListArray);
        }

    }];
}

-(void)getMembersListwithlimit : (int)limit withSkip:(int)skip
{
    [[MBMembersUtility sharedUtility]getAllMembersListWithLimit:limit andSkip:skip ResponceBlock:^(NSArray *responceArray, NSError *error)
    {
        _membersListTableView.hidden = NO;
        _activityIndicator.hidden = YES;
        if (error==nil&& responceArray!=nil) {
            [_membersListArray addObjectsFromArray:[responceArray mutableCopy]];
            [_membersListTableView reloadData];
            
            NSLog(@"%@",_membersListArray);
        }
    }];
}

-(void)getMembersListwithsorting : (int)limit withSkip:(int)skip
{
    [[MBMembersUtility sharedUtility]getAllMembersListWithSortByUserNameInASCorderWithLimit:limit andSkip:skip ResponceBlock:^(NSArray *responceArray, NSError *error) {
        _activityIndicator.hidden = YES;
        if (error==nil&& responceArray!=nil) {
            [_membersListArray addObjectsFromArray:[responceArray mutableCopy]];
            [_membersListTableView reloadData];
            
            NSLog(@"%@",_membersListArray);
        }
    }];
}
     




#pragma mark - Table View Data source


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
            if (indexPath.row == [_membersListArray count] - 1 )
        {
            [self getMembersListwithlimit:7 withSkip:(int)_membersListArray.count];
           
            // API for sorting with names given below :
            //[self getMembersListwithsorting:7 withSkip:(int)_membersListArray.count];
        }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section
{
    return _membersListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"mbmembersinfotableviewcell";
    
    MBMembersInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[MBMembersInfoTableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if([_dict_notes valueForKey:[NSString stringWithFormat:@"%@",[[_membersListArray objectAtIndex:indexPath.row]valueForKey:KId]]])
    {
        cell.noteButton.hidden=FALSE;
        cell.noteButton.tag=indexPath.row;
        [cell.noteButton addTarget:self action:@selector(noteButtonCLicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
       cell.noteButton.hidden=TRUE;
    }

    [cell setMemberInfo:[_membersListArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    
    NSLog(@"Section:%ld Row:%ld selected and its data is %@",
          (long)indexPath.section,(long)indexPath.row,cell.textLabel.text);
    
   
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    MBDetailViewController*detailview  = [storyboard instantiateViewControllerWithIdentifier:@"MBDetailViewController"];
    detailview.membersListdict=[_membersListArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailview animated:TRUE];
   
}

#pragma mark - note button clicked

- (void) noteButtonCLicked :(id)sender
{
    NSInteger tag=[sender tag];
    
    UIView *view_note=[[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    
    [view_note setBackgroundColor:[UIColor grayColor]];
    view_note.tag=1010;

    view_note.alpha=0.5;
    
    
   UITextView *noteView=[[UITextView alloc] initWithFrame:CGRectMake(view_note.bounds.origin.x, view_note.bounds.origin.y, 40, 40)];
    
    [UIView animateWithDuration:0.25 animations:^{
        noteView.frame =  CGRectMake(view_note.frame.size.width/2, view_note.frame.size.height/2,120 ,120);
        [noteView setCenter:view_note.center];
    }];
    
    [noteView setBackgroundColor:[UIColor blackColor]];
    [noteView setTextColor:[UIColor whiteColor]];
    [noteView setFont:[UIFont boldSystemFontOfSize:15]];
    
    noteView.editable=false;
    
    noteView.text=[_dict_notes valueForKey:[NSString stringWithFormat:@"%@",[[_membersListArray objectAtIndex:tag]valueForKey:KId]]];
    
    // Border for textview
    
    [[noteView layer] setBorderColor:[[UIColor blueColor] CGColor]];
    [[noteView layer] setBorderWidth:1];
    [noteView setClipsToBounds: YES];
    
    UIButton *btn_cancel=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_cancel setFrame:CGRectMake(view_note.frame.size.width/2,noteView.frame.origin.y-30,noteView.frame.size.width/2 ,25)];
    [btn_cancel setBackgroundColor:[UIColor blackColor]];
    [btn_cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btn_cancel addTarget:self action:@selector(clearButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    
    [view_note addSubview:btn_cancel];
    
    [view_note addSubview:noteView];
    
    [self.view addSubview:view_note];
    
    
}

-(void)clearButtonSelected
{
    [[self.view viewWithTag:1010]removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
