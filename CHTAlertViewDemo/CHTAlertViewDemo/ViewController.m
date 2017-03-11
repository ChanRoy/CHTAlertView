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
    
#if 0
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"title" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"confirm", nil];
    
    [alertView show];
    
#endif
    
    
    
}

- (IBAction)btnClick:(id)sender {
    
    CHTAlertView *alertView = [[CHTAlertView alloc]initWithTitle:@"title" titleIcon:nil message:@"message" cancelButtonTitle:@"cancel" confirmButtonTitle:@"confirm" completionBlock:^(NSUInteger buttonIndex, CHTAlertView *alertView) {
        
        NSLog(@"%ld",buttonIndex);
        
    }];
    
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
