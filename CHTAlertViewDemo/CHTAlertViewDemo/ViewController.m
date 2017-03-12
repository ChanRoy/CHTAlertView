//
//  ViewController.m
//  CHTAlertViewDemo
//
//  Created by cht on 17/3/11.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import "ViewController.h"
#import "CHTAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)btnClick:(id)sender {
    
    UIImage *image = [UIImage imageNamed:@"phoneIcon"];
    
#if 1
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
#else
    
    [CHTAlertView showWithTitle:@"88888888"
                      titleIcon:image
                        message:@"make a phone call"
              cancelButtonTitle:@"cancel"
             confirmButtonTitle:@"OK"
                completionBlock:^(NSUInteger buttonIndex, CHTAlertView *alertView) {
        
                    //button click event
        NSLog(@"%ld",buttonIndex);
    }];
    
    
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
