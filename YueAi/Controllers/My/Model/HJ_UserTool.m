//
//  HJ_UserTool.m
//  YueAi
//
//  Created by 郭洪军 on 7/11/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "HJ_UserTool.h"
#import "HJ_UserModel.h"

@interface HJ_UserTool ()
@end

@implementation HJ_UserTool
+ (instancetype)shareInstance
{
    static HJ_UserTool *userTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userTool = [self new];
    });
    return userTool;
}

- (HJ_UserModel *)userModel
{
    HJ_UserModel *model = [[HJ_UserModel alloc] init];
    model.icon = @"icon1.jpg";
    model.name = @"Dscore";
    model.weiXinNumber = @"Fronxe";
    model.qrCode = @"";
    model.address = @"北京市 海淀区";
    model.sex = @"男";
    model.area = @"阿拉伯联合酋长国 迪拜";
    model.signature = @"技术无法使其变得更便宜的唯一东西，就是品牌......";
    model.userId = @"000000";
    model.circleBgImage = @"IMG_1208.JPG";
    return model;
}

#pragma mark - modify User information
+ (BOOL)modifyHeadICon:(NSString *)icon
{
    //    DS_UserTool *tool = [DS_UserTool shareInstance];
    return NO;
}

+ (BOOL)modifyUserName:(NSString *)userName
{
    return NO;
}

+ (BOOL)modifyAddress:(NSString *)address
{
    return NO;
}

+ (BOOL)modifySex:(NSString *)sex
{
    return NO;
}

+ (BOOL)modifyArea:(NSString *)area
{
    return NO;
}

+ (BOOL)modifySignature:(NSString *)signature
{
    return NO;
}
@end
