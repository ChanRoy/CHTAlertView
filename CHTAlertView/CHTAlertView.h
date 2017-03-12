//
//  CHTAlertView.h
//  CHTAlertViewDemo
//
//  Created by cht on 17/3/11.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHTAlertView : UIControl

- (instancetype)initWithTitle:(NSString *)title //必填
                    titleIcon:(UIImage *)icon
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
           confirmButtonTitle:(NSString *)confirmButtonTitle
              completionBlock:(void (^)(NSUInteger buttonIndex, CHTAlertView *alertView))block NS_DESIGNATED_INITIALIZER;

+ (id)showWithTitle:(NSString *)title //必填
          titleIcon:(UIImage *)icon
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
 confirmButtonTitle:(NSString *)confirmButtonTitle
    completionBlock:(void (^)(NSUInteger buttonIndex, CHTAlertView *alertView))block;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

- (void)show;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *messageColor;

@property (nonatomic, strong) UIColor *cancelButtonTitleColor;

@property (nonatomic, strong) UIColor *confirmButtonTitleColor;

@end
