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

/* cell Item */
@property (nonatomic, strong) SelwynFormItem *formItem;

/* textview content block */
@property (nonatomic, copy) FormInputCompletion formInputCompletion;

/* return height of cell */
+ (CGFloat)cellHeightWithItem:(SelwynFormItem *)item;

@end

@interface UITableView (SelwynFormInputTableViewCell)

/* Designated initializer */
- (SelwynFormInputTableViewCell *)formInputCellWithId:(NSString *)cellId;

@end
