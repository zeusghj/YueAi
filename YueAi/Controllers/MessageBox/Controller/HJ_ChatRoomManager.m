//
//  HJ_ChatRoomManager.m
//  YueAi
//
//  Created by 郭洪军 on 7/11/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "HJ_ChatRoomManager.h"
#import "HJModel.h"


@implementation HJ_ChatRoomManager

#pragma mark - public funs
+ (CGFloat)calculateCellHeightWithMsg:(HJModel *)msg
{
    CGSize size = CGSizeMake(0, 0);
    switch (msg.msg_Type) {
            //文字
        case HJ_ChatMessageTypeText:
            size = [HJ_ChatRoomManager msgTextHeight:msg.msg];
            break;
        case HJ_ChatRoomTypePicture:
            size = [HJ_ChatRoomManager msgPictureHeight:msg.msg];
            break;
        case HJ_ChatRoomTypeVoice:
        case HJ_ChatRoomTypeVoiceRead:
            size = [HJ_ChatRoomManager msgTextHeight:msg.msg];
            break;
            
        default:
            break;
    }
    return [HJ_ChatRoomManager caculateCellHight:msg withSize:size];
}

#pragma mark - pravite funs
+ (CGFloat)caculateCellHight:(HJModel *)msg withSize:(CGSize)size
{
    // top and bottom margin
    CGFloat timetampHeight = 45.f;
    if (msg.showTimestamp) {
        timetampHeight += 23;
    }
    if (msg.msg_Type == HJ_ChatMessageTypeText) {
        timetampHeight += size.height>35.f?size.height:35.;
    }else if (msg.msg_Type == HJ_ChatRoomTypePicture){
        timetampHeight += size.height;
    }
    msg.cacheMsgSize = CGSizeMake(ceil(size.width), ceil(timetampHeight));
    return timetampHeight;
}

//纯文字
+ (CGSize)msgTextHeight:(NSString *)msg
{
    CGRect rect = [msg boundingRectWithSize:KCHATBUBBLESIZE options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KCHATBUBBLEFONT} context:nil];
    return rect.size;
}

//图片
+ (CGSize)msgPictureHeight:(NSString *)msg
{
    return CGSizeMake(200, 200);
}

//语音
+ (CGSize)msgVoiceHeight:(NSString *)msg
{
    return CGSizeMake(0, 0);
}


@end
