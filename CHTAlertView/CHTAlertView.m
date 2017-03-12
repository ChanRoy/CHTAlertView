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

@interface CHTAlertView ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, copy) NSString *cancelBtnTitle;
@property (nonatomic, copy) NSString *confirmBtnTitle;
@property (nonatomic, copy) void (^completionBlock)(NSUInteger, CHTAlertView *);

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *messageLb;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;

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
        _frame = self.frame;
        
        [self initialize];
        
        [self setupContentView];
        
        [self setupUI];
    }
    return self;
}

+ (id)showWithTitle:(NSString *)title 
                    titleIcon:(UIImage *)icon
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
           confirmButtonTitle:(NSString *)confirmButtonTitle
              completionBlock:(void (^)(NSUInteger buttonIndex, CHTAlertView *alertView))block{
    
    CHTAlertView *alertView = [[CHTAlertView alloc]initWithTitle:title titleIcon:icon message:message cancelButtonTitle:cancelButtonTitle confirmButtonTitle:confirmButtonTitle completionBlock:block];
    [alertView show];
    
    return alertView;
}


- (void)initialize{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.userInteractionEnabled = YES;
    
    _titleColor = HexColor(0x000000);
    _messageColor = HexColor(0x000000);
    _cancelButtonTitleColor = HexColor(0x0076FF);
    _confirmButtonTitleColor = HexColor(0x0076FF);
    
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
    CGFloat viewH = _message.length ? 110.0f: 93.0f;
    CGFloat titleStartX = 35.0f;
    CGFloat titleStartY = 18.0f;
    
    //mainView
    _mainView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-viewW)/2, (SCREEN_HEIGHT-viewH)/2, viewW, viewH)];
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.layer.cornerRadius = 8.0f;
    [_contentView addSubview:_mainView];
    
    //icon
    CGFloat iconH = _icon ? 33.0f : 0;
    CGFloat titleH = 18.0f;
    UIImageView *iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(titleStartX, titleStartY-(iconH-titleH)/2, iconH, iconH)];
    iconImgView.image = _icon;
    [_mainView addSubview:iconImgView];
    
    //title label
    titleStartX = !_icon ? : CGRectGetMaxX(iconImgView.frame)+3;
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(titleStartX, 18, viewW-2*titleStartX, titleH)];
    _titleLb.font = [UIFont systemFontOfSize:17.0f];
    _titleLb.textColor = _titleColor;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.text = _title;
    [_mainView addSubview:_titleLb];
    
    //message label
    if (_message.length) {
        
        CGFloat messageStartX = 20.0f;
        CGFloat messageH = 15.0f;
        _messageLb = [[UILabel alloc]initWithFrame:CGRectMake(messageStartX, CGRectGetMaxY(_titleLb.frame) + 10, viewW-2*messageStartX, messageH)];
        _messageLb.font = [UIFont systemFontOfSize:13.0f];
        _messageLb.textColor = _messageColor;
        _messageLb.textAlignment = NSTextAlignmentCenter;
        _messageLb.text = _message;
        [_mainView addSubview:_messageLb];
    }
    
    //horizontal line
    CGFloat horLineStartY = _message.length ? (CGRectGetMaxY(_messageLb.frame)+10) : CGRectGetMaxY(_titleLb.frame) + 18;
    UIView *horLine = [[UIView alloc]initWithFrame:CGRectMake(0, horLineStartY, viewW, 0.5)];
    horLine.backgroundColor = [UIColor lightGrayColor];
    [_mainView addSubview:horLine];
    
    //vertical line
    UIView *verLine = [[UIView alloc]initWithFrame:CGRectMake(viewW/2-0.25, CGRectGetMaxY(horLine.frame), 0.5, viewH-CGRectGetMaxY(horLine.frame))];
    verLine.backgroundColor = [UIColor lightGrayColor];
    [_mainView addSubview:verLine];
    
    //cancel button
    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(horLine.frame), viewW/2-0.25, viewH-CGRectGetMaxY(horLine.frame))];
    [_cancelBtn setTitle:_cancelBtnTitle forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:_cancelButtonTitleColor forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_cancelBtn];
    
    //confirm button
    _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(verLine.frame), CGRectGetMaxY(horLine.frame), viewW/2-0.5, viewH-CGRectGetMaxY(horLine.frame))];
    [_confirmBtn setTitle:_confirmBtnTitle forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:_confirmButtonTitleColor forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_confirmBtn];
    
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

#pragma mark - setters
- (void)setTitleColor:(UIColor *)titleColor{
    
    _titleColor = titleColor;
    _titleLb.textColor = _titleColor;
}

- (void)setMessageColor:(UIColor *)messageColor{
    
    _messageColor = messageColor;
    _messageLb.textColor = _messageColor;
}

- (void)setCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor{
    
    _cancelButtonTitleColor = cancelButtonTitleColor;
    [_cancelBtn setTitleColor:_cancelButtonTitleColor forState:UIControlStateNormal];
}

- (void)setConfirmButtonTitleColor:(UIColor *)confirmButtonTitleColor{
    
    _confirmButtonTitleColor = confirmButtonTitleColor;
    [_confirmBtn setTitleColor:_confirmButtonTitleColor forState:UIControlStateNormal];
}

#pragma mark - events
- (void)cancel:(UIButton *)cancelBtn{
    
    if (_completionBlock) {
        
        _completionBlock(0,self);
    }
    [self dismiss];
}

- (void)confirm:(UIButton *)confirmBtn{
    
    if (_completionBlock) {
        
        _completionBlock(1,self);
    }
    [self dismiss];
}

@end
