//
//  SelwynFormAttachmentTableViewCell.h
//  SelwynFormDemo
//
//  Created by zhuku on 2018/1/16.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SelwynFormBaseTableViewCell.h"

@class SelwynFormItem;

typedef void(^AttachmentCellHandle)(NSArray *images);

@interface SelwynFormAttachmentTableViewCell : SelwynFormBaseTableViewCell

/* cell Item */
@property (nonatomic, strong) SelwynFormItem *formItem;

/* 选择照片block */
@property (nonatomic, copy) AttachmentCellHandle cellHandle;

#pragma mark -- cell height
+ (CGFloat)cellHeightWithItem:(SelwynFormItem *)item;

@end

@interface UITableView (SelwynFormAttachmentTableViewCell)

/* Designated initializer */
- (SelwynFormAttachmentTableViewCell *)formAttachmentCellWithId:(NSString *)cellId;

@end
