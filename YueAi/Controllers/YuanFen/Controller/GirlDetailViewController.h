//
//  GirlDetailViewController.h
//  YueAi
//
//  Created by 郭洪军 on 5/30/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GirlDetailModel.h"

@interface GirlDetailViewController : UIViewController

@property(strong, nonatomic)GirlDetailModel* model;
@property(copy, nonatomic) NSString* uid;

@end
