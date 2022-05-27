//
//  AllPopNoticeView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/22.
//

#import "AllPopNoticeView.h"

@interface AllPopNoticeView()
{
    NSString *_title, *_content, *_rightBtnTitle, *_expressageCompany;
}
@property (strong, nonatomic) UILabel        *noticeLable, *contentLable;
@property (strong, nonatomic) UIButton       *knowBtn, *sureBtn;
@property (strong, nonatomic) UITextField    *expressageCompTF ,*expressageIdTF, *textField;

@end

@implementation AllPopNoticeView
- (void)knowNotice:(UIButton *)sender{
    
    if (sender.tag == 1) {
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickRightBtn)]) {
            [self.delegate clickRightBtn];
        }
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(fahuoClickedWithCompName:AndExpreId:)]) {
            if (!self.expressageCompTF.text.length) {
                [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请输入快递公司" AndType:warning IsHideBg:YES AnddataBlock:nil];
                return;
            }
            if (!self.expressageIdTF.text) {
                [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请输入快递单号" AndType:warning IsHideBg:YES AnddataBlock:nil];
                return;
            }
            [self.delegate fahuoClickedWithCompName:self.expressageCompTF.text AndExpreId:self.expressageIdTF.text];
        }
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(changeUserRealName:)]) {
            [self.delegate changeUserRealName:self.textField.text];
        }
    }else{
        
        if (self.block) {
            self.block();
        }
    }
    if (self.block) {
        self.block();
    }
}
- (instancetype)initWithFrame:(CGRect)frame AndTitle:(NSString *)title AndContent:(NSString *)content
{
    self = [super initWithFrame:frame];
    if (self) {
        _title = title;
        _content = content;
        [self initCusViewWithType:0];
    }
    return self;
}
- (instancetype) initWithFrame:(CGRect)frame AndrightBtnTitle:(NSString *)rightTtile AndTitle:(NSString *)title AndContent:(NSString *)content{
    
    self = [super initWithFrame:frame];
    if (self) {
        _title = title;
        _content = content;
        _rightBtnTitle = rightTtile;
        [self initCusViewWithType:1];
    }
    return self;
}
- (instancetype) initTextFieldPopWithFrame:(CGRect)frame AndTitle:(NSString *)title{
    
    self = [super initWithFrame:frame];
    if (self) {
        _title = title;
        _content = @"";
        _rightBtnTitle = @"确认";
        [self initCusViewWithType:3];
    }
    return self;
}
- (instancetype) initFaHuoTextFieldPopViewWithFrame:(CGRect )frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        _title = @"填写信息";
        _content = @"";
        _rightBtnTitle = @"发货";
        [self initCusViewWithType:2];
    }
    return self;
}
- (void)initCusViewWithType:(NSInteger )type{
    
    self.backView = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.backView.myWidth = ScreenWidth - 100;
    self.backView.myHeight = MyLayoutSize.wrap;
    self.backView.layer.cornerRadius = 8;
    self.backView.layer.masksToBounds = YES;
    self.backView.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.backView];
    
    self.noticeLable = [BaseLabel CreateBaseLabelStr:_title Font:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.noticeLable.numberOfLines = 0;
    self.noticeLable.myHorzMargin = 12;
    self.noticeLable.myHeight = MyLayoutSize.wrap;
    self.noticeLable.myTop = 20;
    [self.backView addSubview:self.noticeLable];
    
    self.contentLable = [BaseLabel CreateBaseLabelStr:_content Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.contentLable.numberOfLines = 0;
    self.contentLable.myHorzMargin = 12;
    self.contentLable.myHeight = MyLayoutSize.wrap;
    self.contentLable.myTop = 20;
    [self.backView addSubview:self.contentLable];
    
    if (!_content.length) {
        self.contentLable.visibility = MyVisibility_Gone;
    }
    
    if (type == 2) {
        
        MyLinearLayout *expressageCompanyLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
        expressageCompanyLy.myHorzMargin = 12;
        expressageCompanyLy.myHeight = MyLayoutSize.wrap;
        expressageCompanyLy.gravity = MyGravity_Vert_Center;
        expressageCompanyLy.myTop = 12;
        [self.backView addSubview:expressageCompanyLy];
        
        UILabel *expressageCompanyTitle = [BaseLabel CreateBaseLabelStr:@"快递公司" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
        expressageCompanyTitle.myWidth = MyLayoutSize.wrap;
        expressageCompanyTitle.myHeight = MyLayoutSize.wrap;
        [expressageCompanyLy addSubview:expressageCompanyTitle];
        
        self.expressageCompTF = [[UITextField alloc] initWithFrame:CGRectZero];
        self.expressageCompTF.weight = 1;
        self.expressageCompTF.myHeight = 25;
        self.expressageCompTF.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        self.expressageCompTF.placeholder = @"请输入快递公司";
        self.expressageCompTF.textAlignment = NSTextAlignmentRight;
        self.expressageCompTF.layer.cornerRadius = 4;
        self.expressageCompTF.layer.masksToBounds = YES;
        self.expressageCompTF.font = [UIFont systemFontOfSize:13];
        self.expressageCompTF.myLeft = 12;
        [expressageCompanyLy addSubview:self.expressageCompTF];
        
        UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
        right.myWidth = right.myHeight = 18;
        [expressageCompanyLy addSubview:right];
        
        MyLinearLayout *expressageIDLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
        expressageIDLy.myHorzMargin = 12;
        expressageIDLy.myHeight = MyLayoutSize.wrap;
        expressageIDLy.gravity = MyGravity_Vert_Center;
        expressageIDLy.subviewHSpace = 12;
        expressageIDLy.myTop = 12;
        [self.backView addSubview:expressageIDLy];
        
        UILabel *expressageIDTitle = [BaseLabel CreateBaseLabelStr:@"快递单号" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
        expressageIDTitle.myWidth = MyLayoutSize.wrap;;
        expressageIDTitle.myHeight = MyLayoutSize.wrap;
        [expressageIDLy addSubview:expressageIDTitle];
        
        self.expressageIdTF = [[UITextField alloc] initWithFrame:CGRectZero];
        self.expressageIdTF.weight = 1;
        self.expressageIdTF.myHeight = 25;
        self.expressageIdTF.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        self.expressageIdTF.placeholder = @"请输入快递单号";
        self.expressageIdTF.textAlignment = NSTextAlignmentRight;
        self.expressageIdTF.layer.cornerRadius = 4;
        self.expressageIdTF.layer.masksToBounds = YES;
        self.expressageIdTF.font = [UIFont systemFontOfSize:13];
        [expressageIDLy addSubview:self.expressageIdTF];
        
    }else if (type == 3){
        
        MyLinearLayout *textFieldLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        textFieldLy.myHorzMargin = 12;
        textFieldLy.myHeight = MyLayoutSize.wrap;
        textFieldLy.gravity = MyGravity_Vert_Center;
        textFieldLy.myTop = 12;
        textFieldLy.layer.cornerRadius = 8;
        textFieldLy.layer.masksToBounds = YES;
        textFieldLy.padding = UIEdgeInsetsMake(10, 10, 10, 10);
        textFieldLy.backgroundColor = color_f5;
        [self.backView addSubview:textFieldLy];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.textField.myHorzMargin = 0;
        self.textField.myHeight = 25;
        self.textField.backgroundColor = color_f5;
        self.textField.placeholder = @"请输入昵称";
        self.textField.textAlignment = NSTextAlignmentLeft;
        self.textField.font = [UIFont systemFontOfSize:13];
        [textFieldLy addSubview:self.textField];
    }
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectZero];
    line.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    line.myHorzMargin = 0;
    line.myHeight = 0.5;
    line.myTop = 20;
    [self.backView addSubview:line];
    
    MyLinearLayout *btnLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    btnLy.myHorzMargin = 0;
    btnLy.myHeight = 50;
    btnLy.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    btnLy.subviewHSpace = 0.5;
    [self.backView addSubview:btnLy];
    
    if (type) {
        
        self.knowBtn = [BaseButton CreateBaseButtonTitle:@"取消" Target:self Action:@selector(knowNotice:) Font:[UIFont systemFontOfSize:18] BackgroundColor:UIColor.whiteColor Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
        self.knowBtn.weight = 1;
        self.knowBtn.myHeight = 50;
        [btnLy addSubview:self.knowBtn];
        
        self.sureBtn = [BaseButton CreateBaseButtonTitle:_rightBtnTitle Target:self Action:@selector(knowNotice:) Font:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium] BackgroundColor:UIColor.whiteColor Color:[UIColor colorNamed:@"color-red"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
        self.sureBtn.weight = 1;
        self.sureBtn.myHeight = 50;
        [btnLy addSubview:self.sureBtn];
        
    }else{
        
        self.knowBtn = [BaseButton CreateBaseButtonTitle:@"我知道了" Target:self Action:@selector(knowNotice:) Font:[UIFont systemFontOfSize:18] BackgroundColor:UIColor.whiteColor Color:[UIColor colorNamed:@"color-red"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
        self.knowBtn.weight = 1;
        self.knowBtn.myHeight = 50;
        [btnLy addSubview:self.knowBtn];
    }
    
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.backView sizeThatFits:targetSize];
}
@end
