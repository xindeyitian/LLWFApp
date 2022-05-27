//
//  ShouHuoStatusPopView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/28.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    WhetherReceived,
    Received,
    NoReceived,
} PopViewType;

typedef void(^ ChooseTypeBlock)(NSString *type);
typedef void(^ CancleBlock)(void);

@interface ShouHuoStatusPopView : THBaseView

- (instancetype) initWithFrame:(CGRect)frame AndType:(PopViewType )type;

@property (strong, nonatomic) MyLinearLayout *rootLy;

@property (copy, nonatomic) ChooseTypeBlock chooseTypeBlock;

@property (copy, nonatomic) CancleBlock cancleBlock;

@end

NS_ASSUME_NONNULL_END
