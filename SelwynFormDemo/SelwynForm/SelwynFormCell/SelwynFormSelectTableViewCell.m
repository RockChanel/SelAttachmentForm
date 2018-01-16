//
//  SelwynFormSelectTableViewCell.m
//  SelwynFormDemo
//
//  Created by Selwyn Bi on 2017/7/2.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormSelectTableViewCell.h"
#import "SelwynFormItem.h"
#import "SelwynExpandableTextView.h"
#import "SelwynFormHandle.h"

@implementation SelwynFormSelectTableViewCell

- (void)setFormItem:(SelwynFormItem *)formItem
{
    _formItem = formItem;
    
    self.titleLabel.attributedText = formItem.formAttributedTitle;
    
    self.textView.text = formItem.formDetail;
    self.textView.editable = formItem.editable;
    self.textView.textAlignment = formItem.textAlignment;
    self.textView.attributedPlaceholder = formItem.attributedPlaceholder;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(EdgeMarin, EdgeMarin, TitleWidth, TitleHeight);
    
    CGFloat newHeight = [SelwynFormSelectTableViewCell cellHeightWithItem:_formItem];
    
    self.textView.userInteractionEnabled = NO;
    self.textView.frame = CGRectMake(TitleWidth + 2*EdgeMarin, EdgeMarin, ScreenWidth - (TitleWidth + 2*EdgeMarin + 30),  MAX(TitleHeight, newHeight - 2*EdgeMarin));
}

#pragma mark -- cell height
+ (CGFloat)cellHeightWithItem:(SelwynFormItem *)item{
    
    CGSize detailSize = [SelwynFormHandle getSizeWithString:item.formDetail Font:Font(16) maxSize:CGSizeMake(ScreenWidth - TitleWidth - 2*EdgeMarin - 30, MAXFLOAT)];
    
    return MAX(44, detailSize.height + 2*EdgeMarin);
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

@implementation UITableView (SelwynFormSelectTableViewCell)

- (SelwynFormSelectTableViewCell *)formSelectCellWithId:(NSString *)cellId
{
    SelwynFormSelectTableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[SelwynFormSelectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    
    return cell;
}

@end
