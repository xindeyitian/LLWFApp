//
//  ShareBGCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/6.
//

#import "ShareBGCell.h"

@interface ShareBGCell()

@property (strong, nonatomic) UILabel *inviteCode;

@end

@implementation ShareBGCell
- (void)copyInviteCode{
    
}
- (void)inviteWXFriend{
    
}
- (void)btnClicked:(UIButton *)sender{
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCusCell];
    }
    return self;
}
- (void)initCusCell{
    
    MyLinearLayout *backLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    backLy.myHorzMargin = 0;
    backLy.myHeight = 500;
    backLy.gravity = MyGravity_Horz_Center;
    backLy.backgroundImage = IMAGE_NAMED(@"shareBG");
    [self.contentView addSubview:backLy];
    backLy.layer.zPosition = 0;
    
    MyLinearLayout *copyLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    copyLy.myWidth = MyLayoutSize.wrap;
    copyLy.myHeight = 25;
    copyLy.layer.cornerRadius = 12.5;
    copyLy.layer.masksToBounds = YES;
    copyLy.backgroundColor = [UIColor colorWithHexString:@"#EB192F"];
    copyLy.gravity = MyGravity_Vert_Center;
    copyLy.padding = UIEdgeInsetsMake(5, 15, 5, 15);
    copyLy.myTop = 320;
    copyLy.subviewHSpace = 8;
    [backLy addSubview:copyLy];
    
    self.inviteCode = [BaseLabel CreateBaseLabelStr:@"123321123" Font:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.inviteCode.myWidth = self.inviteCode.myHeight = MyLayoutSize.wrap;
    [copyLy addSubview:self.inviteCode];
    
    UIButton *copyBtn = [BaseButton CreateBaseButtonTitle:@"复制邀请码" Target:self Action:@selector(copyInviteCode) Font:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium] BackgroundColor:UIColor.clearColor Color:[UIColor colorWithHexString:@"#FCBF24"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    copyBtn.myWidth = copyBtn.myHeight = MyLayoutSize.wrap;
    [copyLy addSubview:copyBtn];
    //中划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:copyBtn.titleLabel.text attributes:attribtDic];
    // 赋值
    [copyBtn.titleLabel setAttributedText:attribtStr];
    
    UIButton *invitePersonBtn = [BaseButton CreateBaseButtonTitle:@"立即邀请微信好友" Target:self Action:@selector(inviteWXFriend) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    invitePersonBtn.myHorzMargin = 44;
    invitePersonBtn.myHeight = 50;
    ViewBorderRadius(invitePersonBtn, 25, 1, [UIColor colorWithHexString:@"FFFFFF"]);
    invitePersonBtn.myTop = 30;
    [backLy addSubview:invitePersonBtn];
    
    MyLinearLayout *shareBtnLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    shareBtnLy.myHorzMargin = 37;
    shareBtnLy.myHeight = MyLayoutSize.wrap;
    shareBtnLy.gravity = MyGravity_Vert_Center;
    shareBtnLy.myTop = 32;
    [backLy addSubview:shareBtnLy];
    
    UIButton *shareFriendCycleBtn = [BaseButton CreateBaseButtonTitle:@"分享到朋友全" Target:self Action:@selector(btnClicked:) Font:[UIFont systemFontOfSize:15] BackgroundColor:UIColor.clearColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    shareFriendCycleBtn.myWidth = shareFriendCycleBtn.myHeight = MyLayoutSize.wrap;
    [shareFriendCycleBtn setImage:IMAGE_NAMED(@"shareFriendCycle") forState:UIControlStateNormal];
    shareFriendCycleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    [shareBtnLy addSubview:shareFriendCycleBtn];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    [shareBtnLy addSubview:nilView];
    
    UIButton *saveQRCodeBtn = [BaseButton CreateBaseButtonTitle:@"保存二维码" Target:self Action:@selector(btnClicked:) Font:[UIFont systemFontOfSize:15] BackgroundColor:UIColor.clearColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    saveQRCodeBtn.myWidth = saveQRCodeBtn.myHeight = MyLayoutSize.wrap;
    [saveQRCodeBtn setImage:IMAGE_NAMED(@"saveQRCode") forState:UIControlStateNormal];
    saveQRCodeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    [shareBtnLy addSubview:saveQRCodeBtn];
    
}
@end
