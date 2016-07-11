//
//  HJ_UserTool.h
//  YueAi
//
//  Created by 郭洪军 on 7/11/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HJ_UserModel;
@interface HJ_UserTool : NSObject
+ (instancetype)shareInstance;
@property (nonatomic,strong,readonly)HJ_UserModel *userModel;

/**
 * 修改头像
 */
+ (BOOL)modifyHeadICon:(NSString *)icon;

/**
 * 修改名字
 */
+ (BOOL)modifyUserName:(NSString *)userName;

/**
 * 修改地址
 */
+ (BOOL)modifyAddress:(NSString *)address;

/**
 * 修改性别
 */
+ (BOOL)modifySex:(NSString *)sex;

/**
 * 修改地区
 */
+ (BOOL)modifyArea:(NSString *)area;

/**
 * 修改签名
 */
+ (BOOL)modifySignature:(NSString *)signature;



@end
