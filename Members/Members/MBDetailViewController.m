//
//  MBDetailViewController.m
//  Members
//
//  Created by Tarun on 25/09/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

#import "MBDetailViewController.h"
#import "MBMembersUtility.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Constants.h"
#import "NSString+Utilities.h"
#import "NSDate+Utility.h"

@interface MBDetailViewController ()
@end

@implementation MBDetailViewController

@synthesize id_selected,membersListdict,dict_notes;

#pragma mark view methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _activityIndicator.hidden = YES;
    
    dict_notes=[[NSMutableDictionary alloc]init];
    
   
    // checking for the notes
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"notes"])
    {
        dict_notes = [[[NSUserDefaults standardUserDefaults]valueForKey:@"notes"] mutableCopy];
    }
    

    // Border for textview
    
    [[_textview_note layer] setBorderColor:[[UIColor blueColor] CGColor]];
    [[_textview_note layer] setBorderWidth:1];
    [_textview_note setClipsToBounds: YES];
    
    // checking and showing the notes in notes

    if([dict_notes valueForKey:[NSString stringWithFormat:@"%@",[membersListdict valueForKey:KId]]])
    {
        _textview_note.text=[dict_notes valueForKey:[NSString stringWithFormat:@"%@",[membersListdict valueForKey:KId]]];
    }
    
    // Setting the values accoding to the member selected
    
    [self.lbl_realname setText:[NSString stringWithFormat:@"Name : %@",[NSString createStringWithString:[membersListdict valueForKey:KRealName]]]];
    
    [self.lbl_username setText:[NSString createStringWithString:[membersListdict valueForKey:KUserName]]];
    
    [self.lbl_city setText:[NSString createStringWithString:[membersListdict valueForKey:KCity]]];
    
    [self.lbl_state setText:[NSString stringWithFormat:@"%@ ,",[NSString createStringWithString:[membersListdict valueForKey:KState]]]];
    
    [self.lbl_country setText:[NSString createStringWithString:[membersListdict  valueForKey:KCountry]]];
    
    // calculate Age
    
    NSString *dateString = [membersListdict  valueForKey:KBirthday];
    if (![NSString stringIsEmpty:dateString])
    {
        self.lbl_age.text = [NSString stringWithFormat:@"Age: %lu",[NSDate ageFromBirthday:[NSDate createDateWithDateString:dateString]]];
    }
    else
    {
        self.lbl_age.text = @"Age : N/A";
    }
    
    
    NSString *height=[NSString createStringWithString:[membersListdict valueForKey:KHeight]];
    
    NSMutableString *mu = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",height]];
   
    [mu insertString:@"'" atIndex:1];
    [mu insertString:@"''" atIndex:3];

    
    [self.lbl_height setText:[NSString stringWithFormat:@"Height : %@",mu]];
    
    
     [self.lbl_weight setText:[NSString stringWithFormat:@"Weight : %@ lbs",[NSString createStringWithString:[membersListdict valueForKey:KWeight]]]];
    
     [self.lbl_bodyfat setText:[NSString stringWithFormat:@"Body Fat : %@ %@",[NSString createStringWithString:[membersListdict valueForKey:KBodyfat]],@"%"]];
    
    [self.img_profile sd_setImageWithURL:[NSURL URLWithString:[NSString createStringWithString:[membersListdict  valueForKey:KProfilePicUrl]]] placeholderImage:[UIImage imageNamed:@"noprofilepic.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            self.img_profile.image = image;
        }else
        {
            self.img_profile.image = [UIImage imageNamed:@"noprofilepic.png"];
        }
    }];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

#pragma mark - keyboard movements
- (void)keyboardDidShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.1 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        self.view.frame = f;
    }];
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.1 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

#pragma mark clear button action

- (IBAction)action_clearbtn:(UIButton *)sender
{
    _textview_note.text=@"";
    [dict_notes removeObjectForKey:[NSString stringWithFormat:@"%@",[membersListdict valueForKey:KId]]];
        [[NSUserDefaults standardUserDefaults] setValue:dict_notes forKey:@"notes"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Deleted" message:@"Note Deleted" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];

    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark save button action

- (IBAction)action_savebtn:(UIButton *)sender
{
    if(_textview_note.text.length >0)
    {
        [dict_notes setObject:_textview_note.text forKey:[NSString stringWithFormat:@"%@",[membersListdict valueForKey:KId]]];
        [[NSUserDefaults standardUserDefaults] setValue:dict_notes forKey:@"notes"];
        
        // alert for notifying note saved
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Saved" message:@"Note Saved" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


#pragma mark UITextView Delegates


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    
    return YES;
}


-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}
@end
