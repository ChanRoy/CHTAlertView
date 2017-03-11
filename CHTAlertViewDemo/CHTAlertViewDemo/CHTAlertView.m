//
//  CHTAlertView.m
//  CHTAlertViewDemo
//
//  Created by cht on 17/3/11.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import "CHTAlertView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define HexColor(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

@interface CHTAlertView ()<UIGestureRecognizerDelegate>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, copy) NSString *cancelBtnTitle;
@property (nonatomic, copy) NSString *confirmBtnTitle;
@property (nonatomic, copy) void (^completionBlock)(NSUInteger, CHTAlertView *);

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *mainView;

@end

@implementation CHTAlertView{

    CGRect _frame;
}

- (instancetype)initWithTitle:(NSString *)title //必填
                    titleIcon:(UIImage *)icon
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
           confirmButtonTitle:(NSString *)confirmButtonTitle
              completionBlock:(void (^)(NSUInteger buttonIndex, CHTAlertView *alertView))block
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        
        _title = title;
        _message = message;
        _icon = icon;
        _cancelBtnTitle = cancelButtonTitle;
        _confirmBtnTitle = confirmButtonTitle;
        _completionBlock = block;
        
        [self initialize];
        
        [self setupContentView];
        
        [self setupUI];
    }
    return self;
}

- (void)initialize{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onceTap:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    if (!_cancelBtnTitle.length) {
        
        _cancelBtnTitle = @"cancel";
    }
    if (!_confirmBtnTitle.length) {
        
        _confirmBtnTitle = @"confirm";
    }
}

- (void)setupContentView{
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_frame), SCREEN_HEIGHT, CGRectGetWidth(_frame), CGRectGetHeight(_frame))];
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentView];
}

- (void)setupUI{
    
    CGFloat viewW = SCREEN_WIDTH * 275 / 375;
    CGFloat viewH = 120.0f;
    CGFloat titleStartX = 35.0f;
    
    _mainView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-viewW)/2, (SCREEN_HEIGHT-viewH)/2, viewW, viewH)];
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.layer.cornerRadius = 8.0f;
    [_contentView addSubview:_mainView];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(titleStartX, 18, viewW-2*titleStartX, 18)];
    titleLb.font = [UIFont systemFontOfSize:17.0f];
    titleLb.textColor = [UIColor blackColor];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.text = _title;
    [_mainView addSubview:titleLb];
    
    CGFloat messageStartX = 20.0f;
    UILabel *messageLb = [[UILabel alloc]initWithFrame:CGRectMake(messageStartX, CGRectGetMaxY(titleLb.frame) + 10, viewW-2*messageStartX, 15)];
    messageLb.font = [UIFont systemFontOfSize:13.0f];
    messageLb.textColor = [UIColor blackColor];
    messageLb.textAlignment = NSTextAlignmentCenter;
    messageLb.text = _message;
    [_mainView addSubview:messageLb];
    
    UIView *horLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(messageLb.frame)+10, viewW, 0.5)];
    horLine.backgroundColor = [UIColor blackColor];
    [_mainView addSubview:horLine];
    
    UIView *verLine = [[UIView alloc]initWithFrame:CGRectMake(viewW/2-0.25, CGRectGetMaxY(horLine.frame), 0.5, viewH-CGRectGetMaxY(horLine.frame))];
    verLine.backgroundColor = [UIColor blackColor];
    [_mainView addSubview:verLine];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(horLine.frame), viewW/2-0.25, viewH-CGRectGetMaxY(horLine.frame))];
    [cancelBtn setTitle:_cancelBtnTitle forState:UIControlStateNormal];
    [cancelBtn setTitleColor:HexColor(0x0076FF) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(verLine.frame), CGRectGetMaxY(horLine.frame), viewW/2-0.5, viewH-CGRectGetMaxY(horLine.frame))];
    [confirmBtn setTitle:_confirmBtnTitle forState:UIControlStateNormal];
    [confirmBtn setTitleColor:HexColor(0x0076FF) forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:confirmBtn];
    
}

#pragma mark - gesture
- (void)onceTap:(UITapGestureRecognizer *)tap{
    
    if ([tap.view isKindOfClass:self.class]) {
        
        [self dismiss];
    }
    
}

#pragma mark - gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isKindOfClass:[self class]]) {
        return YES;
    }
    return NO;
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = _contentView.frame;
        frame.origin.y = SCREEN_HEIGHT;
        _contentView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        
        _contentView.frame = _frame;
        
    }];
}

#pragma mark - events
- (void)cancel:(UIButton *)cancelBtn{
    
    [self dismiss];
}

- (void)confirm:(UIButton *)confirmBtn{
    
    [self dismiss];
}

@end
