//
//  XXUIMagnifier.m
//  XMMagnifier
//
//  Created by lixumeng on 2022/3/24.
//

#import "XMMagnifier.h"

#define XMScreenSize [[UIScreen mainScreen] bounds].size

static dispatch_once_t _onceToken;
static XMMagnifier    *_instance;

static const CGFloat cornerRadius = 25.0; // 默认圆角
static const CGFloat borderWidth  = 2.0;  // 默认边宽

@interface XMMagnifier ()

@property (nonatomic) CGPoint locationPoint; // 当前触摸的坐标点
@property (nonatomic) CGSize  initSize;      // 放大镜初始大小
@property (nonatomic) BOOL    isNeedDraw;    // 是否需要重绘

@end

@implementation XMMagnifier

#pragma mark - Public

+ (instancetype)shared {
    dispatch_once(&_onceToken, ^{
        _instance = [[XMMagnifier alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    });
    return _instance;
}

- (void)destroy {
    _onceToken = 0;
    _instance = nil;
}

#pragma mark - Override

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = borderWidth;
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
        self.windowLevel = UIWindowLevelStatusBar + 1;
        // 延时，避免keyWindow显示前设置
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (@available(iOS 13.0, *)) {
                self.windowScene = self.relativeWindow.windowScene;
            }
        });
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_handlePan:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if ( !_isNeedDraw) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, self.magnification, self.magnification);
    CGContextTranslateCTM(context,-_locationPoint.x + self.frame.size.width/3, -_locationPoint.y + self.frame.size.height/2 + self.frame.size.height/3);
    [self.relativeWindow.layer renderInContext:context];
}

#pragma mark - Private
/// 拖动手势
- (void)_handlePan:(UIPanGestureRecognizer*) recognizer {
    _locationPoint = [recognizer locationInView:self.relativeWindow];
    [self setNeedsDisplay];
    
    recognizer.view.center = CGPointMake(_locationPoint.x, _locationPoint.y - self.frame.size.height/2 - 10);
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _isNeedDraw = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.initSize = self.frame.size;
            recognizer.view.bounds = CGRectMake(0, 0, self.enableSize.width, self.enableSize.height);
        }];
    }
    if(recognizer.state == UIGestureRecognizerStateEnded||
       recognizer.state == UIGestureRecognizerStateCancelled) {
        _isNeedDraw = NO;
        if(_locationPoint.x > XMScreenSize.width/2) {
            _locationPoint.x = XMScreenSize.width - _initSize.width;
        } else {
            _locationPoint.x = 0;
        }
        if (_locationPoint.y > XMScreenSize.height - _initSize.height) {
            _locationPoint.y = XMScreenSize.height - _initSize.height;
        }
        if (_locationPoint.y < _initSize.height) {
            _locationPoint.y = _initSize.height;
        }
        [UIView animateWithDuration:0.3 animations:^{
            recognizer.view.frame = CGRectMake(self.locationPoint.x, self.locationPoint.y, self.initSize.width, self.initSize.height);
        }];
    }
}

#pragma mark - Getter

- (CGFloat)magnification {
    if (_magnification <= 1) {
        _magnification = 1.5;
    }
    return _magnification;
}

- (CGSize)enableSize {
    if (CGSizeEqualToSize(_enableSize, CGSizeZero)) {
        _enableSize = CGSizeMake(200, 150);
    }
    return _enableSize;
}

- (UIWindow *)relativeWindow {
    if (!_relativeWindow) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *window in [windows reverseObjectEnumerator]) {
            if ([window isKindOfClass:[UIWindow class]] &&
                window.windowLevel == UIWindowLevelNormal &&
                CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
                return _relativeWindow = window;
        }
        _relativeWindow = [UIApplication sharedApplication].keyWindow;
    }
    return _relativeWindow;
}

@end
