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

/** cell条目 */
@property (nonatomic, strong) SelwynFormItem *formItem;
/** 动态获取cell高度 */
+ (CGFloat)cellHeightWithItem:(SelwynFormItem *)item;

@end

@interface UITableView (SelwynFormSelectTableViewCell)

/** SelwynFormSelectTableViewCell初始化 */
- (SelwynFormSelectTableViewCell *)formSelectCellWithId:(NSString *)cellId;

@end
