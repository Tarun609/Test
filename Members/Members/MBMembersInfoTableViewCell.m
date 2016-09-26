//
//  MBMembersInfoTableViewCell.m
//  Members
//
//  Created by Tarun on 24/9/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

#import "MBMembersInfoTableViewCell.h"
#import "Constants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Utilities.h"
#import "NSDate+Utility.h"
@implementation MBMembersInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

#pragma mark set member info

-(void)setMemberInfo:(NSDictionary*)memberInfo
{
    self.memberInfoDict = [memberInfo mutableCopy];
    self.memberNameLabel.text = [NSString createStringWithString:[memberInfo valueForKey:KUserName]];
    self.memberCityLabel.text = [NSString createStringWithString:[memberInfo valueForKey:KCity]];
    self.memberStateAndCountryLabel.text = [NSString stringWithFormat:@"%@,%@",[memberInfo valueForKey:KState],[memberInfo valueForKey:KCountry]];
    //Set Age
    NSString *dateString = [memberInfo valueForKey:KBirthday];
    if (![NSString stringIsEmpty:dateString]) {
        self.memberAgeLabel.text = [NSString stringWithFormat:@"%lu",[NSDate ageFromBirthday:[NSDate createDateWithDateString:dateString]]];
    }else
    {
        self.memberAgeLabel.text = @"";
    }

    
    [self.memberProfileImageView sd_setImageWithURL:[NSURL URLWithString:[NSString createStringWithString:[memberInfo valueForKey:KProfilePicUrl]]] placeholderImage:[UIImage imageNamed:@"noprofilepic.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            self.memberProfileImageView.image = image;
        }else
        {
            self.memberProfileImageView.image = [UIImage imageNamed:@"noprofilepic.png"];
        }
    }];
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.noteButton.layer.cornerRadius = 10;
    self.noteButton.clipsToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma  mark note button method
- (IBAction)noteButtonClicked:(UIButton *)sender
{
    if(_delegate &&[_delegate respondsToSelector:@selector(noteButtonCLicked:)])
    {
        [_delegate noteButtonCLicked:_memberInfoDict];
    }
}

@end
