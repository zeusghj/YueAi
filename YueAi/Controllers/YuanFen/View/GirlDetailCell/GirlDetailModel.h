//
//  GirlDetailModel.h
//  YueAi
//
//  Created by 郭洪军 on 6/15/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GirlDetailModel : NSObject

@property(copy, nonatomic) NSString* name;      //名字
@property(strong, nonatomic) NSArray* medals;   //勋章
@property(copy, nonatomic) NSString* introUrl;  //音频文件名字/地址
@property(assign, nonatomic) NSInteger time;    //音频时长
@property(copy, nonatomic) NSString* ziliao;    //基本资料
@property(copy, nonatomic) NSString* detail;    //详细资料
@property(strong, nonatomic) NSArray* tags;     //标签
@property(copy, nonatomic) NSString* condition; //征友条件


@end
