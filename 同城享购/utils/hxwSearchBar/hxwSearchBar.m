//
//  hxwSearchBar.m
//  同城享购
//
//  Created by 庄园 on 2017/11/8.
//  Copyright © 2017年 庄园. All rights reserved.
//
#import "hxwSearchBar.h"

@interface hxwSearchBar ()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField * textField;
@property (nonatomic, strong)UIImageView * leftView;
@property (nonatomic, strong)UIButton * deleteBtn;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation hxwSearchBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAllViews];
    }
    return self;
}

- (void)initAllViews
{
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.masksToBounds = YES;
    
    if (_leftView == nil) {
        _leftView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (self.frame.size.height - 17) / 2.0, 17, 17)];
        _leftView.image = [UIImage imageNamed:@"found_search.png"];
        [self addSubview:_leftView];
    }
    
//    if (_textField == nil) {
//        _textField = [[UITextField alloc] initWithFrame:CGRectMake(_leftView.frame.size.width + _leftView.frame.origin.x + 10, 2, self.frame.size.width - (_leftView.frame.size.width + _leftView.frame.origin.x + 10) - (self.frame.size.height - 4) , self.frame.size.height - 4)];
//        _textField.backgroundColor = [UIColor clearColor];
//        _textField.returnKeyType = UIReturnKeyDone;
//        _textField.delegate = self;
//        [_textField addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
//        [self addSubview:_textField];
//    }
    if (_titleLabel == nil ) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_leftView.frame.size.width + _leftView.frame.origin.x + 10, 2, self.frame.size.width - (_leftView.frame.size.width + _leftView.frame.origin.x + 10) - (self.frame.size.height - 4) , self.frame.size.height - 4)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.text = self.text;
        
        [self addSubview:_titleLabel];
    
    }
    
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(self.frame.size.width - self.frame.size.height - 4, 2, self.frame.size.height - 4, self.frame.size.height - 4);
        [_deleteBtn setImage:[UIImage imageNamed:@"found_search_off.png"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
       // [self addSubview:_deleteBtn];
    }
}

- (void)setIsbecomeFirstResponder:(BOOL)isbecomeFirstResponder
{
    _isbecomeFirstResponder = isbecomeFirstResponder;
    if (_isbecomeFirstResponder) {
        [_textField becomeFirstResponder];
    }
}

- (void)setSearBarColor:(UIColor *)searBarColor
{
    _searBarColor = searBarColor;
    self.backgroundColor = _searBarColor;
  //  _textField.backgroundColor = _searBarColor;
   // _leftView.backgroundColor = _searBarColor;
  //  _deleteBtn.backgroundColor = _searBarColor;
}

- (void)setSearBarFont:(UIFont *)searBarFont
{
    _searBarFont = searBarFont;
    _textField.font = _searBarFont;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _titleLabel.textColor = _textColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _titleLabel.text = _placeholder;
}

- (void)setPlaceholdesColor:(UIColor *)placeholdesColor
{
    _placeholdesColor = placeholdesColor;
    [_textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
}

- (void)setPlaceholdesFont:(UIFont *)placeholdesFont
{
    _placeholdesFont = placeholdesFont;
    [_textField setValue:_placeholdesFont forKeyPath:@"_placeholderLabel.font"];
    
}

- (void)setText:(NSString *)text
{
    _text = text;
    _textField.text = _text;
}

- (void)setDeleteImage:(UIImage *)deleteImage
{
    _deleteImage = deleteImage;
    [_deleteBtn setImage:_deleteImage forState:UIControlStateNormal];
}

#pragma mark - deleteClick
- (void)deleteClick:(UIButton *)delete
{
    NSLog(@"删除");
    if ([_delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]) {
        [self.delegate searchBarCancelButtonClicked:self];
    }
}

#pragma mark - textFieldValueChange
- (void)textFieldValueChange:(UITextField *)textField
{
    _text = textField.text;
    if ([_delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchBar:self textDidChange:textField.text];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        [self.delegate searchBarShouldBeginEditing:self];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]) {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        [self.delegate searchBarShouldEndEditing:self];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
        [self.delegate searchBarSearchButtonClicked:self];
    }
    return YES;
}

- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}

@end
