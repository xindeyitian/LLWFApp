//
//  ReleaseImageView.h
//  SeaEgret
//
//  Created by MAC on 2021/4/26.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DeleteClickHandler)(void);

@interface ReleaseImageView : THBaseView

@property (copy, nonatomic) DeleteClickHandler deleteClickHandler;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

NS_ASSUME_NONNULL_END
