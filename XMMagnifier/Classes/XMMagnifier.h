//
//  XXUIMagnifier.h
//  XXMagnifierService
//
//  Created by lixumeng on 2022/3/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMMagnifier : UIWindow

/// 放大倍数,必须大于1，默认1.5倍。
@property (nonatomic) CGFloat           magnification;
/// 拖动放大镜时放大镜的大小，默认（200, 150）
@property (nonatomic) CGSize            enableSize;
/// 默认为keyWindow，如需放大别的window，请自行传入
@property (nonatomic, strong) UIWindow *relativeWindow;

/// 单利，默认初始位置大小(0, 100, 50, 50)
+ (instancetype)shared;

/// 释放
+ (void)remove;

@end

NS_ASSUME_NONNULL_END
