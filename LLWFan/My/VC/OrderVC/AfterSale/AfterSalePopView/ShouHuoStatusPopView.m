//
//  ShouHuoStatusPopView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/28.
//

#import "ShouHuoStatusPopView.h"

@interface ShouHuoStatusPopView()
{
    NSArray *_dataSorce;
    NSString *_chosedType;
}
@end

@implementation ShouHuoStatusPopView
- (instancetype) initWithFrame:(CGRect)frame AndType:(PopViewType)type;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        _dataSorce = @[];
        
        if (type == 0) {
            _dataSorce = @[@"已收货",@"未收货",@"取消"];
        }else if (type == 1){
            _dataSorce = @[@"我不想要了",@"外观/型号/参数等与商品描述不符合",@"退运费",@"功能/效果不符",@"性能故障",@"少件/漏发",@"包装/商品破损",@"假冒品牌",@"取消"];
        }else{
            _dataSorce = @[@"我不想要了",@"空包裹",@"快递/物流一直未送到",@"快递/物流无跟踪记录",@"货物破损已经拒签",@"取消"];
        }
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.subviewVSpace = 1;
    [self addSubview:self.rootLy];
    
    for (int i = 0; i < _dataSorce.count; i++) {
        
        if (i == _dataSorce.count - 1) {
            
            UIButton *btn = [BaseButton CreateBaseButtonTitle:_dataSorce[i] Target:self Action:@selector(chooseType:) Font:[UIFont systemFontOfSize:18] BackgroundColor:UIColor.whiteColor Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:i];
            btn.myHorzMargin = 0;
            btn.myHeight = 55;
            btn.myTop = 12;
            [self.rootLy addSubview:btn];
        }else{
            
            UIButton *btn = [BaseButton CreateBaseButtonTitle:_dataSorce[i] Target:self Action:@selector(chooseType:) Font:[UIFont systemFontOfSize:18] BackgroundColor:UIColor.whiteColor Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:i];
            btn.myHorzMargin = 0;
            btn.myHeight = 55;
            [self.rootLy addSubview:btn];
        }
    }
}
- (void)chooseType:(UIButton *)sender{
    
    if (sender.tag == _dataSorce.count - 1) {
        
        if (self.cancleBlock) {
            
            self.cancleBlock();
        }
    }else{
        
        if (self.chooseTypeBlock) {
            
            self.chooseTypeBlock(sender.titleLabel.text);
        }
    }
}
@end
