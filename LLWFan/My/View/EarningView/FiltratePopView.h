//
//  FiltratePopView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/20.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FiltratePopViewDelegate <NSObject>

- (void)sureChoose;

@end

@interface FiltratePopView : THBaseView

@property (weak, nonatomic) id<FiltratePopViewDelegate> delegate;

- (void)popWithData;

@end

NS_ASSUME_NONNULL_END
