//
//  CreatRightPointUtility.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/18.
//

#import "CreatRightPointUtility.h"

@interface CreatRightPointUtility()

@property (strong, nonatomic) JSBadgeView *badgeView;

@end

@implementation CreatRightPointUtility

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.pointId = 0;
        self.badgeText = 1;
        self.backGroundColor = [UIColor redColor];
        self.badgeOverlayColor = [UIColor clearColor];
        self.badgeStrokeColor = [UIColor redColor];
    }
    return self;
}

- (void)creatPointWithParentView:(UIView *)view AndPointPosition:(JSBadgeViewAlignment )position{
    
    //新标识视图
    //1、在父控件（parentView）上显示，显示的位置TopRight
    self.badgeView = [[JSBadgeView alloc]initWithParentView:view alignment:position];
    //2、如果显示的位置不对，可以自己调整，超爽啊！
    self.badgeView.badgePositionAdjustment = CGPointMake(-15, 10);
    //3、如果多个的badge,可以设置tag要辨别
    self.badgeView.tag = self.pointId;

    //1、背景色
    self.badgeView.badgeBackgroundColor = self.backGroundColor;
    //2、没有反光面
    self.badgeView.badgeOverlayColor = self.badgeOverlayColor;
    //3、外圈的颜色，默认是白色
    self.badgeView.badgeStrokeColor = self.badgeStrokeColor;

    /*****设置数字****/
    //1、用字符串来ym
    self.badgeView.badgeText = NSStringFormat(@"%ld",self.badgeText);
      
    //当更新数字时，最好刷新，不然由于frame固定的，数字为2位时，红圈变形
    [self.badgeView setNeedsLayout];
}

- (void)reloadPointWithNum:(NSInteger )num{
    /*****设置数字****/
    //1、用字符串来ym
    self.badgeView.badgeText = NSStringFormat(@"%ld",self.badgeText);
    //当更新数字时，最好刷新，不然由于frame固定的，数字为2位时，红圈变形
    [self.badgeView setNeedsLayout];
}
@end
