//
//  BaseViewController.m
//  YueAi
//
//  Created by 郭洪军 on 5/27/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_bg_ios7"]  forBarMetrics:UIBarMetricsDefault];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
