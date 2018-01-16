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

/* cell Item */
@property (nonatomic, strong) SelwynFormItem *formItem;

/* textview content block */
@property (nonatomic, copy) FormTextViewInputCompletion formTextViewInputCompletion;

/* return height of cell */
+ (CGFloat)cellHeightWithItem:(SelwynFormItem *)item;

@end

@interface UITableView (SelwynFormTextViewInputTableViewCell)

/* Designated initializer */
- (SelwynFormTextViewInputTableViewCell *)formTextViewInputCellWithId:(NSString *)cellId;

@end
