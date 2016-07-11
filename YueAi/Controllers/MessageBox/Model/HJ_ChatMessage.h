//
//  HJ_ChatMessage.h
//  YueAi
//
//  Created by 郭洪军 on 7/11/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#ifndef HJ_ChatMessage_h
#define HJ_ChatMessage_h

//message state
typedef NS_ENUM(NSUInteger,HJ_ChatMessageType){
    HJ_ChatMessageTypeText = 1,        //文字 1
    HJ_ChatRoomTypePicture = 2,       //图片  2
    HJ_ChatRoomTypeVoice = 3,         //语音   3
    HJ_ChatRoomTypeVoiceRead = 4,     //语音已听 4
    HJ_ChatRoomTypeFace = 6,          //表情    6
    HJ_ChatRoomTypeGif = 7,           //GIF   7
    HJ_ChatRoomTypeVideo = 11,         //小视频 11
    HJ_ChatRoomTypeBonus = 12,         //红包  12
    HJ_ChatRoomTypeReceiveBonus = 13,  //领取红包 13
    HJ_ChatRoomTypeAccounts = 14,      //转账 14
    HJ_ChatRoomTypeLocation = 21,      //位置 21
    HJ_ChatRoomTypePersonCard = 31,    //个人名片 31
    HJ_ChatRoomTypeDiscount = 32,      //卡券  32
    HJ_ChatRoomTypeOutWeb = 33,        //外部分享  33
    HJ_ChatRoomTypeAddRoom = 34,       //入群  34
    HJ_ChatRoomTypeRmoveRoom = 35,     //退出群  35
    HJ_ChatRoomTypeMsgRecall = 41      //消息撤回 41
};

#define DS_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])

//bubble max width
#define KCHATBUBBLEWIDTH (SCREEN_WIDTH - 165)
//bubble max size
#define KCHATBUBBLESIZE CGSizeMake(KCHATBUBBLEWIDTH, CGFLOAT_MAX)

#define KCHATBUBBLEFONT DSTEXTFONT(15.)

#endif /* HJ_ChatMessage_h */
