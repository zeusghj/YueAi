//
//  PressButton.h
//  YueAi
//
//  Created by 郭洪军 on 7/13/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PressButton : UIButton

@property (nonatomic, strong) void(^sendVoice)(NSString *);

@end
