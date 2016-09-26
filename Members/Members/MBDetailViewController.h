//
//  MBDetailViewController.h
//  Members
//
//  Created by Tarun on 25/09/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBDetailViewController : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSMutableDictionary *membersListdict;

@property (nonatomic, strong) NSMutableDictionary *dict_notes;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_constraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsave_bottomconstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txtview_bottomconstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txtview_bottomconstraintcler;

@property (assign, nonatomic) NSInteger id_selected;

@property (weak, nonatomic) IBOutlet UILabel *lbl_username;

@property (weak, nonatomic) IBOutlet UILabel *lbl_city;
@property (weak, nonatomic) IBOutlet UILabel *lbl_state;

@property (weak, nonatomic) IBOutlet UILabel *lbl_country;
@property (weak, nonatomic) IBOutlet UIImageView *img_profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_realname;
@property (weak, nonatomic) IBOutlet UILabel *lbl_age;
@property (weak, nonatomic) IBOutlet UILabel *lbl_height;
@property (weak, nonatomic) IBOutlet UILabel *lbl_weight;
@property (weak, nonatomic) IBOutlet UILabel *lbl_bodyfat;
@property (weak, nonatomic) IBOutlet UITextView *textview_note;
@property (weak, nonatomic) IBOutlet UIButton *btn_save;
@property (weak, nonatomic) IBOutlet UIButton *btn_clear;

@end
