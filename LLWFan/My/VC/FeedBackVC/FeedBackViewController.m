//
//  FeedBackViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/25.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()<UITextViewDelegate>

@property (strong, nonatomic) MyLinearLayout             *rootLy;
@property (strong, nonatomic) WWMPlaceholderTextView     *feedBackTF;
@property (strong, nonatomic) UIButton                   *conmitFeedBackBtn;
@property (strong, nonatomic) UILabel                    *feedBackNum;

@end

@implementation FeedBackViewController
- (void)sureConmit{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"反馈与建议"];
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    [self.view addSubview:self.rootLy];
    
    MyLinearLayout *topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    topLy.backgroundColor = UIColor.whiteColor;
    topLy.myHorzMargin = 0;
    topLy.myHeight = MyLayoutSize.wrap;
    topLy.layer.cornerRadius = 8;
    topLy.layer.masksToBounds = YES;
    topLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    [self.rootLy addSubview:topLy];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.text = @"反馈与意见";
    title.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    title.textColor = color_3;
    title.myWidth = title.myHeight = MyLayoutSize.wrap;
    [topLy addSubview:title];
    
    MyLinearLayout *textLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    textLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    textLy.layer.cornerRadius = 4;
    textLy.layer.masksToBounds = YES;
    textLy.padding = UIEdgeInsetsMake(0, 8, 12, 8);
    textLy.myHorzMargin = 0;
    textLy.myHeight = 125;
    textLy.myTop = 12;
    [topLy addSubview:textLy];
    
    self.feedBackTF = [[WWMPlaceholderTextView alloc] initWithFrame:CGRectZero];
    self.feedBackTF.font = [UIFont systemFontOfSize:12];
    self.feedBackTF.textColor = color_6;
    self.feedBackTF.myHorzMargin = 0;
    self.feedBackTF.myHeight = 100;
    self.feedBackTF.placeholder = @"您填写的信息越全，问题越可有效解决哟～";
    self.feedBackTF.placeholderColor = [UIColor colorWithHexString:@"#CCCCCC"];
    self.feedBackTF.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.feedBackTF.delegate = self;
    [textLy addSubview:self.feedBackTF];
    
    self.feedBackNum = [BaseLabel CreateBaseLabelStr:@"0/200" Font:[UIFont systemFontOfSize:12] Color:[UIColor colorWithHexString:@"cccccc"] Frame:CGRectZero Alignment:NSTextAlignmentRight Tag:0];
    self.feedBackNum.myHorzMargin = 0;
    self.feedBackNum.myHeight = MyLayoutSize.wrap;
    [textLy addSubview:self.feedBackNum];
    
    UILabel *notice = [[UILabel alloc] initWithFrame:CGRectZero];
    notice.text = @"感谢您的反馈\n\n我们将会定期整理大家的反馈，根据您提供的反馈息见进行优化补充，或客服致电方便您后续使用。";
    notice.myHorzMargin = 0;
    notice.myHeight = MyLayoutSize.wrap;
    notice.myTop = 12;
    notice.textColor = color_9;
    notice.font = [UIFont systemFontOfSize:12];
    [self.rootLy addSubview:notice];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:notice.text];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] range:NSMakeRange(0, 6)];
    [attr addAttribute:NSForegroundColorAttributeName value:color_3 range:NSMakeRange(0, 6)];
    notice.attributedText = attr;
    
    self.conmitFeedBackBtn = [BaseButton CreateBaseButtonTitle:@"确认提交反馈建议" Target:self Action:@selector(sureConmit) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.conmitFeedBackBtn.myHorzMargin = 0;
    self.conmitFeedBackBtn.myHeight = 50;
    self.conmitFeedBackBtn.layer.cornerRadius = 25;
    self.conmitFeedBackBtn.layer.masksToBounds = YES;
    self.conmitFeedBackBtn.myTop = 40;
    [self.rootLy addSubview:self.conmitFeedBackBtn];
    
}
- (void)textViewDidChange:(UITextView *)textView{
    
    self.feedBackNum.text = NSStringFormat(@"%ld/200",textView.text.length);
    
    if (textView.text.length >= 200) {
        
        textView.text = [textView.text substringToIndex:199];
    }
}
@end
