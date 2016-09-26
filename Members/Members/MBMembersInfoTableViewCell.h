//
//  MBMembersInfoTableViewCell.h
//  Members
//
//  Created by Tarun on 24/9/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MBMembersInfoTableViewCellDelegate <NSObject>
@required
- (void) noteButtonCLicked:(NSDictionary*)membersInfo;
@end
@interface MBMembersInfoTableViewCell : UITableViewCell

@property (strong, nonatomic) NSMutableDictionary *memberInfoDict;
@property (strong,nonatomic) id <MBMembersInfoTableViewCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *memberProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *memberNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberStateAndCountryLabel;
@property (weak, nonatomic) IBOutlet UIButton *noteButton;
-(void)setMemberInfo:(NSDictionary*)memberInfo;
@end
