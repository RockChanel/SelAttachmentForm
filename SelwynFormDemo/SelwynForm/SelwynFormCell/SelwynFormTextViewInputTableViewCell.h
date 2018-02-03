//
//  SelwynFormTextViewInputTableViewCell.h
//  SelwynFormDemo
//
//  Created by Selwyn Bi on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormBaseTableViewCell.h"

@class SelwynFormItem;

typedef void(^FormTextViewInputCompletion)(NSString *text);

@interface SelwynFormTextViewInputTableViewCell : SelwynFormBaseTableViewCell

/** cell条目 */
@property (nonatomic, strong) SelwynFormItem *formItem;
/** 输入内容回调 */
@property (nonatomic, copy) FormTextViewInputCompletion formTextViewInputCompletion;
/** 动态获取cell高度 */
+ (CGFloat)cellHeightWithItem:(SelwynFormItem *)item;

@end

@interface UITableView (SelwynFormTextViewInputTableViewCell)

/** SelwynFormTextViewInputTableViewCell初始化 */
- (SelwynFormTextViewInputTableViewCell *)formTextViewInputCellWithId:(NSString *)cellId;

@end
