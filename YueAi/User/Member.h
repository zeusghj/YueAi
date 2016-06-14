//
//  Member.h
//  YueAi
//
//  Created by 郭洪军 on 6/14/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject
/**
 *  icon iamge url   每个成员都对应一个小的icon
 */
@property (nonatomic, copy) NSString *iconImgUrl;
/**
 *  big image urls   同时对应一张或多张大图
 */
@property (nonatomic, strong) NSArray *bigImgUrls;

@end
