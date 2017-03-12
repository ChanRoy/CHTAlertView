# CHTAlertView
AlertView with a icon and block

![](https://github.com/ChanRoy/CHTAlertView/blob/master/CHTAlertView.gif)

## 简介

自定义AlertView，接口模仿UIKit中的UIAlertView。自定义功能有：

- AlertView title 中带有自定义小图标
- title message 以及下方的两个button字体颜色支持自定义

效果图如上。

## 使用

### 调用方法

- instance method

```
- (instancetype)initWithTitle:(NSString *)title
                    titleIcon:(UIImage *)icon
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
           confirmButtonTitle:(NSString *)confirmButtonTitle
              completionBlock:(void (^)(NSUInteger buttonIndex, CHTAlertView *alertView))block; 
```

```
- (void)show;
```

- class method

```
+ (id)showWithTitle:(NSString *)title
          titleIcon:(UIImage *)icon
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
 confirmButtonTitle:(NSString *)confirmButtonTitle
    completionBlock:(void (^)(NSUInteger buttonIndex, CHTAlertView *alertView))block;
```

### 属性

```
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *messageColor;

@property (nonatomic, strong) UIColor *cancelButtonTitleColor;

@property (nonatomic, strong) UIColor *confirmButtonTitleColor;
```

## Demo

### instance method demo

```
CHTAlertView *alertView = [[CHTAlertView alloc]initWithTitle:@"88888888"
                                                       titleIcon:image
                                                         message:@"make a phone call"
                                               cancelButtonTitle:@"cancel"
                                              confirmButtonTitle:@"OK"
                                                 completionBlock:^(NSUInteger buttonIndex, CHTAlertView *alertView) {
        //button click event
        NSLog(@"%ld",buttonIndex);
        
    }];
    
    [alertView show];
```

### class method demo
```
[CHTAlertView showWithTitle:@"88888888"
                      titleIcon:image
                        message:@"make a phone call"
              cancelButtonTitle:@"cancel"
             confirmButtonTitle:@"OK"
                completionBlock:^(NSUInteger buttonIndex, CHTAlertView *alertView) {
        
                    //button click event
        NSLog(@"%ld",buttonIndex);
    }];
```

## LICENSE

MIT



