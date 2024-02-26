//
//  XMMagnifier.h
//  XMMagnifier
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

/// 单例，默认Frame(0, 100, 50, 50)，该控件继承自UIWindow，默认隐藏，修改hidden属性或调用makeKeyAndVisible即可。
+ (instancetype)shared;

/// 释放，如果只是想控制显示/隐藏，请用UIView的hidden属性
- (void)destroy;

@end

NS_ASSUME_NONNULL_END
