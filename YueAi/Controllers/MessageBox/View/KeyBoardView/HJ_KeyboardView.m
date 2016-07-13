//
//  HJ_KeyboardView.m
//  YueAi
//
//  Created by 郭洪军 on 7/6/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "HJ_KeyboardView.h"
#import "HJ_KeyboardEmjView.h"
#import "PressButton.h"

//功能键宽度/高度
const CGFloat KBoardVoiceWidth = 35.f;
//功能面板高度
const CGFloat KFunsPanelHeight = 210.f;
//上面功能键高度
const CGFloat KBoardInputBgHeight = 49.f;
//输入框文字偏差调整
const CGFloat KInputTextViewMargin = 15.5f;
//输入框文字最多显示的行数
const NSInteger KInputTextViewMaxNumbers = 1;

typedef NS_ENUM(NSInteger, KBoardFunsType) {
    KBoardFunsTypeNone,
    KBoardFunsTypeEmj,
    KBoardFunsTypeFuns
};

@interface HJ_KeyboardView ()<UITextViewDelegate>
{
    //键盘高度
    CGFloat _keyboardHeight;
    //键盘弹出动画
    CGFloat _keyboardAnimationDuration;
    //键盘弹出动画轨迹时间轴
    UIViewAnimationCurve _keyboardAnimationCurve;
    //是否处于发送语音中
    BOOL _voiceState;
    struct KeyBoardDelegate {
        unsigned int KeyBoardWillShow : 1;
        unsigned int KeyBoardDidShow : 1;
        unsigned int KeyBoardWillDismiss : 1;
        unsigned int KeyBoardDidDismiss : 1;
        unsigned int KeyBoardItemCellClick : 1;
        unsigned int KeyBoardSendMsg : 1;
    }KeyBoardDelegate;
    
    //记录inputView文字行数
    NSInteger _recordTextNums;
    //记录inputView文字偏差状态
    BOOL _recordTextMarginState;
    //记录inputView行数是增加还是减少
    BOOL _recordTextLengthChangeState;
    //当输入文字超过一行时， HJ_KeyboardView高度发生变化， 在退回到下面时需要更新
    CGFloat _recordInputTextHeight;
}

@property (nonatomic, strong)UIView* funcBackGroundView;
@property (nonatomic, strong)UITextView* inputView;
@property (nonatomic, strong)UIButton* voiceButton;
@property (nonatomic, strong)UIButton* emjButton;
@property (nonatomic, strong)UIButton* addButton;
@property (nonatomic, strong)PressButton* pressButton;

//emj 视图
@property (nonatomic,strong)HJ_KeyboardEmjView *emjView;
// 功能 视图
@property (nonatomic,strong)UIView *funsView;
//emj/功能 切换 当前处于哪个视图
@property (nonatomic,assign)KBoardFunsType funsType;

@end

@implementation HJ_KeyboardView

- (instancetype)init
{
    if (self = [super init]) {
        _recordInputTextHeight = KBoardInputBgHeight;
        self.frame = CGRectMake(0, SCREEN_HEIGHT - _recordInputTextHeight - 64.f, SCREEN_WIDTH, _recordInputTextHeight);
        [self addSubview:self.funcBackGroundView];
        [self.funcBackGroundView addSubview:self.inputView];
        [self.funcBackGroundView addSubview:self.voiceButton];
        [self.funcBackGroundView addSubview:self.emjButton];
        [self.funcBackGroundView addSubview:self.addButton];
        _recordTextNums = 1;
        [self noticeKeyBoardFrame];
        [self setNeedsUpdateConstraints];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s", __func__);
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    WEAKSELF;
    [self.funcBackGroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.equalTo(weakSelf);
        make.height.mas_equalTo(_recordInputTextHeight).priorityLow();
    }];
    
    [self.voiceButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KBoardVoiceWidth, KBoardVoiceWidth));
        make.left.equalTo(weakSelf.funcBackGroundView);
        make.bottom.equalTo(weakSelf.funcBackGroundView.mas_bottom).offset(-7);
    }];

    [self.addButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KBoardVoiceWidth, KBoardVoiceWidth));
        make.right.equalTo(weakSelf.funcBackGroundView.mas_right);
        make.top.equalTo(weakSelf.voiceButton);
    }];
    
    [self.emjButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KBoardVoiceWidth, KBoardVoiceWidth));
        make.right.equalTo(weakSelf.addButton.mas_left).offset(-5);
        make.top.equalTo(weakSelf.voiceButton);
    }];
    
    [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.voiceButton.mas_right).offset(5);
        make.top.equalTo(weakSelf.funcBackGroundView.mas_top).offset(7);
        make.bottom.equalTo(weakSelf.funcBackGroundView.mas_bottom).offset(-7);
        make.right.equalTo(weakSelf.emjButton.mas_left).offset(-5);
    }];
    
}

#pragma mark - keyBoard Frame change notice
- (void)noticeKeyBoardFrame
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

#pragma mark - keyBoardObserver Funs
- (void)keyboardWillShow:(NSNotification *)notify
{
    BOOL state = [self keyFrameWithNotification:notify];
    //在键盘弹出的时候回多次接受到通知的frame变化信息，过滤掉第一次消除键盘和功能键切换中变化过程
    if (!state) {
        return;
    }
    [self show];
}

- (void)keyboardDidShow:(NSNotification *)notify
{
}

- (void)keyboardWillHide:(NSNotification *)notify
{
    [self keyFrameWithNotification:notify];
}

- (void)keyboardDidHide:(NSNotification *)notify
{
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _voiceState = YES;
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (KeyBoardDelegate.KeyBoardSendMsg) {
            [self.delegate keyBoardSendMsgTextView:self sendMsgText:textView.text];
        }
        
        textView.text = @"" ;
        CGRect rect = self.frame;
        //需要重新修改funcBackGroundView的高度和自身的高度
        rect.origin.y = SCREEN_HEIGHT - 64 - KBoardInputBgHeight - _keyboardHeight;
        //重置记录行数
        _recordTextNums = 1 ;
        _recordTextMarginState = NO ;
        self.frame = rect ;
        _recordInputTextHeight = KBoardInputBgHeight;
        if (rect.size.height != KBoardInputBgHeight) {
            
            WEAKSELF;
            [self.funcBackGroundView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.top.left.equalTo(weakSelf);
                make.height.mas_equalTo(_recordInputTextHeight);
            }];
        }
        
        if (KeyBoardDelegate.KeyBoardWillShow) {
            [self.delegate keyBoardInputViewWillShow:self];
        }
        
        return NO;
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
//    NSLog(@"%s", __func__);
}

- (CGFloat)calculateInputTextViewHeightWithText:(NSString *)text
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.inputView.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.]} context:nil];
    return ceil(rect.size.height / self.inputView.font.lineHeight) ;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
}

#pragma mark - public funs
- (BOOL)keyFrameWithNotification:(NSNotification *)notify
{
    NSNumber *duration = [[notify userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    if (duration!=nil && [duration isKindOfClass:[NSNumber class]])
        _keyboardAnimationDuration = [duration floatValue];
    duration = [[notify userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    if (duration!=nil && [duration isKindOfClass:[NSNumber class]])
        _keyboardAnimationCurve = [duration integerValue];
    NSValue *value = [[notify userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    if ([value isKindOfClass:[NSValue class]])
    {
        CGRect rect = [value CGRectValue];
        _keyboardHeight = rect.size.height;
    }
    if (_keyboardHeight == 0) {
        return NO;
    }
    return YES;
}

- (void)show
{
    CGRect rect = self.frame;
    CGFloat height = _keyboardHeight;
    rect.size.height = _recordInputTextHeight + _keyboardHeight;
    self.frame = rect;
    
    UIViewAnimationOptions opt = animationOptionsWithCurve(_keyboardAnimationCurve);
    if (_keyboardAnimationDuration == 0) {
        _keyboardAnimationDuration = 0.25;
    }
    [UIView animateWithDuration:_keyboardAnimationDuration delay:0 options:opt animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -height);
        if (KeyBoardDelegate.KeyBoardWillShow) {
            [self.delegate keyBoardInputViewWillShow:self];
        }
        
    } completion:^(BOOL finished) {
        if (KeyBoardDelegate.KeyBoardDidShow) {
            [self.delegate keyBoardInputViewDidShow:self];
        }
        
        if ([self.pressButton superview] && self.frame.size.height != _recordInputTextHeight) {
            [self.pressButton removeFromSuperview];
            [self.voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice.png"] forState:UIControlStateNormal];
        }
    }];
}

- (void)dismiss
{
    if ([self.inputView isFirstResponder]) {
        [self.inputView resignFirstResponder];
    }
    
    UIViewAnimationOptions opt = animationOptionsWithCurve(_keyboardAnimationCurve);
    [UIView animateWithDuration:_keyboardAnimationDuration delay:0 options:opt animations:^{
        self.transform = CGAffineTransformIdentity;
        if (KeyBoardDelegate.KeyBoardWillDismiss) {
            [self.delegate keyBoardInputViewWillDismiss:self];
        }
    } completion:^(BOOL finished) {
        if (KeyBoardDelegate.KeyBoardDidDismiss) {
            [self.delegate keyBoardInputViewDidDismiss:self];
        }
    }];
}

#pragma mark - pravite funs
static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve)
{
    UIViewAnimationOptions opt = (UIViewAnimationOptions)curve;
    return opt << 16;
}

#pragma mark - button action
- (void)voiceAction:(UIButton *)sender
{
    NSLog(@"%s", __func__);
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        if (self.inputView.text) {
            self.inputView.text = nil;
        }
        [self addSubview:self.pressButton];
        [self.pressButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.inputView);
        }];
        if (_voiceState) {
            [self.inputView resignFirstResponder];
            [self dismiss];
        }
        _voiceState = YES;
        
    } else {
        [self.inputView becomeFirstResponder];
        [self.pressButton removeFromSuperview];
    }
    
}

- (void)emjAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.inputView.inputView = self.emjView;
        if ([self.inputView isFirstResponder]) {
            [self.inputView reloadInputViews];
        }else{
            [self.inputView becomeFirstResponder];
        }
    }else
    {
        self.inputView.inputView = nil;
        if ([self.inputView isFirstResponder]) {
            [self.inputView reloadInputViews];
        }else{
            [self.inputView becomeFirstResponder];
        }
    }
}

- (void)addAction:(UIButton *)btn
{
    NSLog(@"%s", __func__);
}

- (void)pressButton:(UIButton *)btn
{
    NSLog(@"%s", __func__);
    
}

#pragma mark - setter 赋值
- (void)setDelegate:(id<HJ_KeyboardViewDelegate>)delegate
{
    _delegate = delegate;
    KeyBoardDelegate.KeyBoardWillShow    = [_delegate respondsToSelector:@selector(keyBoardInputViewWillShow:)];
    KeyBoardDelegate.KeyBoardDidShow     = [_delegate respondsToSelector:@selector(keyBoardInputViewDidShow:)];
    KeyBoardDelegate.KeyBoardWillDismiss = [_delegate respondsToSelector:@selector(keyBoardInputViewWillDismiss:)];
    KeyBoardDelegate.KeyBoardDidDismiss  = [_delegate respondsToSelector:@selector(keyBoardInputViewDidDismiss:)];
    KeyBoardDelegate.KeyBoardSendMsg     = [_delegate respondsToSelector:@selector(keyBoardSendMsgTextView:sendMsgText:)];
}

#pragma mark - getter
- (UIView *)funcBackGroundView
{
    if (!_funcBackGroundView) {
        _funcBackGroundView = [[UIView alloc] init];
        _funcBackGroundView.backgroundColor = UIColorFromRGB(0xf4f4f6);
    }
    return _funcBackGroundView;
}

- (UITextView *)inputView
{
    if (!_inputView) {
        _inputView = [[UITextView alloc] init];
        _inputView.layer.masksToBounds = YES;
        _inputView.layer.cornerRadius = 3.f;
        _inputView.delegate = self;
//        _inputView.scrollEnabled = NO;
        _inputView.font = [UIFont systemFontOfSize:16.f];
        _inputView.returnKeyType = UIReturnKeySend;
        _inputView.enablesReturnKeyAutomatically = YES;
        _inputView.layoutManager.allowsNonContiguousLayout = YES;
        _inputView.textAlignment = NSTextAlignmentLeft;
    }
    
    return _inputView;
}

- (UIButton *)voiceButton
{
    if (!_voiceButton) {
        _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice.png"] forState:UIControlStateNormal];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateSelected];
        [_voiceButton addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (UIButton *)emjButton
{
    if (!_emjButton) {
        _emjButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emjButton setImage:[UIImage imageNamed:@"ToolViewEmotion.png"] forState:UIControlStateNormal];
        [_emjButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateSelected];
        [_emjButton addTarget:self action:@selector(emjAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emjButton;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"ToolViewMedia.png"] forState:UIControlStateNormal];
        [_addButton setImage:[UIImage imageNamed:@"ToolViewMediaHL.png"] forState:UIControlStateHighlighted];
        [_addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)pressButton
{
    if (!_pressButton) {
        _pressButton = [[PressButton alloc]init];
        [_pressButton.layer setMasksToBounds:YES];
        [_pressButton.layer setCornerRadius:3.0];
        [_pressButton.layer setBorderWidth:1.0];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 221/255.,221/255. ,221/255., 1 });
        [_pressButton.layer setBorderColor:colorref];
    }
    return _pressButton;
}

- (UIView *)emjView
{
    if (!_emjView) {
        _emjView = [[HJ_KeyboardEmjView alloc] init];
        _emjView.inputDelegate = self.inputView;
    }
    return _emjView;
}

- (UIView *)funsView
{
    if (!_funsView) {
        _funsView = [[UIView alloc] init];
    }
    return _funsView;
}

@end



