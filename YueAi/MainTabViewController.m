//
//  MainTabViewController.m
//  YueAi
//
//  Created by 郭洪军 on 5/26/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "MainTabViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController* homeVC = InstFirstVC(@"YuanFen");
    UIViewController* searchVC = InstFirstVC(@"Search");
    UIViewController* messageVC = InstFirstVC(@"MessageBox");
    UIViewController* neiborVC = InstFirstVC(@"Neighbour");
    UIViewController* myVC = InstFirstVC(@"My");
    
    homeVC.tabBarItem.title=@"缘分";
    searchVC.tabBarItem.title=@"搜索";
    messageVC.tabBarItem.title=@"信箱";
    neiborVC.tabBarItem.title=@"身边";
    myVC.tabBarItem.title=@"我的";
    
    homeVC.tabBarItem.image=[UIImage imageNamed:@"first_normal"];
    searchVC.tabBarItem.image=[UIImage imageNamed:@"second_normal"];
    messageVC.tabBarItem.image=[UIImage imageNamed:@"third_normal"];
    neiborVC.tabBarItem.image=[UIImage imageNamed:@"fourth_normal"];
    myVC.tabBarItem.image=[UIImage imageNamed:@"fifth_normal"];
    
    [homeVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"first_selected"]];
    [searchVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"second_selected"]];
    [messageVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"third_selected"]];
    [neiborVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"fourth_selected"]];
    [myVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"fifth_selected"]];
    
    
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_normal_background"]];
    [self.tabBar setTintColor:[UIColor whiteColor]];
    
    [self setViewControllers:@[homeVC, searchVC, messageVC, neiborVC, myVC]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}















@end
