//
//  HJ_ChatRoomManager.h
//  YueAi
//
//  Created by 郭洪军 on 7/11/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HJModel;

@interface HJ_ChatRoomManager : NSObject
+ (CGFloat)calculateCellHeightWithMsg:(HJModel *)msg;
@end
