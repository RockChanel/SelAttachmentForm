//
//  SelwynFormBaseTableViewCell.m
//  SelwynFormDemo
//
//  Created by Selwyn Bi on 2017/6/25.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormBaseTableViewCell.h"
#import "SelwynExpandableTextView.h"
#import "SelwynFormHandle.h"

@interface SelwynFormBaseTableViewCell()<UITextViewDelegate>

@end

@implementation SelwynFormBaseTableViewCell

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = Font(TitleFont);
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.contentView addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (SelwynExpandableTextView *)textView
{
    if (!_textView) {
        _textView = [[SelwynExpandableTextView alloc] init];
        _textView.delegate = self;
        _textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);//set margin
        _textView.textContainer.lineFragmentPadding = 0;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = Font(TitleFont);
        _textView.scrollEnabled = NO;
        _textView.autocorrectionType = UITextAutocorrectionTypeNo;
        _textView.layoutManager.allowsNonContiguousLayout = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        
        [self.contentView addSubview:_textView];
    }
    
    return _textView;
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
