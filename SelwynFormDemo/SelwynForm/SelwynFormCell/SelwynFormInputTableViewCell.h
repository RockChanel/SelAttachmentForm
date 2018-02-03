//
//  SelwynFormInputTableViewCell.h
//  SelwynFormDemo
//
//  Created by Selwyn Bi on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormBaseTableViewCell.h"

@class SelwynFormItem;

typedef void(^FormInputCompletion)(NSString *text);

@interface SelwynFormInputTableViewCell : SelwynFormBaseTableViewCell

/** cell条目 */
@property (nonatomic, strong) SelwynFormItem *formItem;
/** 输入内容回调 */
@property (nonatomic, copy) FormInputCompletion formInputCompletion;
/** 动态获取cell高度 */
+ (CGFloat)cellHeightWithItem:(SelwynFormItem *)item;

@end

@interface UITableView (SelwynFormInputTableViewCell)

/** SelwynFormInputTableViewCell初始化 */
- (SelwynFormInputTableViewCell *)formInputCellWithId:(NSString *)cellId;

@end
