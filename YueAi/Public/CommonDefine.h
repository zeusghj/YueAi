//
//  CommonDefine.h
//  YueAi
//
//  Created by 郭洪军 on 5/27/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

//color set
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define KBackgroundColor UIColorFromRGB(0xEBEBEB)

// device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define DSTEXTFONT(float) [UIFont systemFontOfSize:float]

//block self define
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf)__strong strongSelf = weakSelf;

// size position frame
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define BOUNDS [[UIScreen mainScreen] bounds].size

#define height_scale (SCREEN_WIDTH/320.f)

// color
#define NAVI_AND_TABBAR_COLOR  [UIColor colorWithRed:46.f/255 green:39.f/255 blue:47.f/255 alpha:1]

#endif /* CommonDefine_h */
