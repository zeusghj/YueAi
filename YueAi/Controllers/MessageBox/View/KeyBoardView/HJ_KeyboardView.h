//
//  HJ_KeyboardView.h
//  YueAi
//
//  Created by 郭洪军 on 7/6/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HJ_KeyboardView;

extern const CGFloat KBoardInputBgHeight;

typedef NS_ENUM(NSInteger, HJ_KeyboardViewFuncItemType) {
    HJ_KeyboardViewFuncItemTypePhoto = 0,      //照片
    HJ_KeyboardViewFuncItemTypeTakePhoto       //拍照
};

@protocol HJ_KeyboardViewDelegate <NSObject>

@optional
- (void)keyBoardInputViewWillShow:(HJ_KeyboardView *)view;
- (void)keyBoardInputViewDidShow:(HJ_KeyboardView *)view;
- (void)keyBoardInputViewWillDismiss:(HJ_KeyboardView *)view;
- (void)keyBoardInputViewDidDismiss:(HJ_KeyboardView *)view;


- (void)keyBoardSendMsgTextView:(HJ_KeyboardView *)view sendMsgText:(NSString *)text;

@end

@interface HJ_KeyboardView : UIView

@property (nonatomic, weak)id <HJ_KeyboardViewDelegate>delegate;
@property (nonatomic, assign)HJ_KeyboardViewFuncItemType itemType;
- (void)dismiss;
@end

