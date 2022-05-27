//
//  AllPopNoticeView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/22.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AllPopNoticeViewDelegate <NSObject>

@optional
- (void)clickRightBtn;

- (void)fahuoClickedWithCompName:(NSString *)compName AndExpreId:(NSString *)expreId;

- (void)changeUserRealName:(NSString *)realName;
@end

typedef void(^rightBtnClickBlock)(void);

@interface AllPopNoticeView : THBaseView

@property (strong, nonatomic) MyLinearLayout *backView;

@property (weak,   nonatomic) id<AllPopNoticeViewDelegate> delegate;

@property (copy,   nonatomic) rightBtnClickBlock block;

- (instancetype) initWithFrame:(CGRect)frame AndTitle:(NSString *)title AndContent:(NSString *)content;

- (instancetype) initWithFrame:(CGRect)frame AndrightBtnTitle:(NSString *)rightTtile AndTitle:(NSString *)title AndContent:(NSString *)content;

- (instancetype) initTextFieldPopWithFrame:(CGRect)frame AndTitle:(NSString *)title;

- (instancetype) initFaHuoTextFieldPopViewWithFrame:(CGRect )frame;

@end

NS_ASSUME_NONNULL_END
