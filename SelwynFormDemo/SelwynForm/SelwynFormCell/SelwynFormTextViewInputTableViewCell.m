//
//  SelwynFormTextViewInputTableViewCell.m
//  SelwynFormDemo
//
//  Created by Selwyn Bi on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormTextViewInputTableViewCell.h"
#import "SelwynFormItem.h"
#import "SelwynExpandableTextView.h"
#import "SelwynFormHandle.h"

@interface SelwynFormTextViewInputTableViewCell()

@property (nonatomic, assign) CGFloat lastCellHeight;
@property (nonatomic, copy) NSString *inputDetail;

@end

@implementation SelwynFormTextViewInputTableViewCell

/** 重写formItem set方法 */
- (void)setFormItem:(SelwynFormItem *)formItem
{
    _formItem = formItem;
    
    self.inputDetail = formItem.formDetail;
    self.titleLabel.attributedText = formItem.formAttributedTitle;
    self.textView.keyboardType = formItem.keyboardType;
    self.textView.editable = formItem.editable;
    self.textView.attributedPlaceholder = formItem.attributedPlaceholder;
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(EdgeMarin, EdgeMarin, ScreenWidth - 2*EdgeMarin, TitleHeight);
    
    //重新设置textView内边距
    self.textView.textContainerInset = UIEdgeInsetsMake(EdgeMarin, EdgeMarin, EdgeMarin, EdgeMarin);
    self.textView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1/1.0];
    
    CGFloat newHeight = [SelwynFormTextViewInputTableViewCell cellHeightWithItem:_formItem];
    //重新计算textView frame
    self.textView.frame = CGRectMake(EdgeMarin, CGRectGetMaxY(self.titleLabel.frame) + EdgeMarin, ScreenWidth - 2*EdgeMarin, MAX(DefaultTextViewHeight - 3*EdgeMarin - TitleHeight, newHeight - TitleHeight - 3*EdgeMarin));
}

/** 输入字数限制 */
- (void)limitTextViewTextLength{
    
    NSString *toBeString = self.textView.text;
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];
    
    if ([current.primaryLanguage isEqualToString:@"zh-Hans"]) {
        
        UITextRange *selectedRange = [self.textView markedTextRange];
        UITextPosition *position = [self.textView positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (toBeString.length > _formItem.maxInputLength) {
                self.textView.text = [toBeString substringToIndex:_formItem.maxInputLength];
            }
        }
    }
    else{
        if (toBeString.length > _formItem.maxInputLength) {
            self.textView.text = [toBeString substringToIndex:_formItem.maxInputLength];
        }
    }
}

- (void)textViewDidChange:(UITextView *)theTextView
{
    if (_formItem.maxInputLength > 0) {
        [self limitTextViewTextLength];
    }
    _inputDetail = self.textView.text;
    
    //输入内容回调
    if (_formTextViewInputCompletion) {
        _formTextViewInputCompletion(_inputDetail);
    }
    
    //update tableView 关闭刷新动画
    [UIView performWithoutAnimation:^{
        [self.expandableTableView beginUpdates];
        [self.expandableTableView endUpdates];
    }];
}

- (void)setInputDetail:(NSString *)inputDetail
{
    _inputDetail = inputDetail;
    self.textView.text = inputDetail;
}

/** 动态获取cell高度 */
+ (CGFloat)cellHeightWithItem:(SelwynFormItem *)item{
    
    CGSize detailSize = [SelwynFormHandle getSizeWithString:item.formDetail Font:Font(TitleFont) maxSize:CGSizeMake(ScreenWidth - 4*EdgeMarin, MAXFLOAT)];
    return MAX(DefaultTextViewHeight, detailSize.height + TitleHeight + 5*EdgeMarin);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation UITableView (SelwynFormTextViewInputTableViewCell)

/** SelwynFormTextViewInputTableViewCell初始化 */
- (SelwynFormTextViewInputTableViewCell *)formTextViewInputCellWithId:(NSString *)cellId
{
    SelwynFormTextViewInputTableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[SelwynFormTextViewInputTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}

@end
