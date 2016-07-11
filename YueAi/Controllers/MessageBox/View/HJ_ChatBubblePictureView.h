//
//  HJ_ChatBubblePictureView.h
//  YueAi
//
//  Created by 郭洪军 on 7/11/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJ_ChatBubblePictureView : UIView

//图片页面
@property (nonatomic, strong) NSString* pictureUrl;
//消息来自自己还是其他人
@property (nonatomic, assign) BOOL msgSources;

@end
