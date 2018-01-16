//
//  SelwynFormSelectTableViewCell.h
//  SelwynFormDemo
//
//  Created by Selwyn Bi on 2017/7/2.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormBaseTableViewCell.h"

@class SelwynFormItem;

@interface SelwynFormSelectTableViewCell : SelwynFormBaseTableViewCell

/* cell Item */
@property (nonatomic, strong) SelwynFormItem *formItem;

#pragma mark -- cell height
+ (CGFloat)cellHeightWithItem:(SelwynFormItem *)item;

@end

@interface UITableView (SelwynFormSelectTableViewCell)

/* Designated initializer */
- (SelwynFormSelectTableViewCell *)formSelectCellWithId:(NSString *)cellId;

@end
