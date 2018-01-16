//
//  SelwynFormItem.h
//  SelwynFormDemo
//
//  Created by BSW on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SelwynFormItem;

/* Values for SelwynFormCellType */
typedef NS_ENUM(NSInteger, SelwynFormCellType) {
    
    SelwynFormCellTypeNone = 0, //default
    SelwynFormCellTypeInput = 1, 
    SelwynFormCellTypeTextViewInput = 2,
    SelwynFormCellTypeSelect = 3,
    SelwynFormCellTypeAttachment = 4,
};

typedef void(^FormItemSelectHandle)(SelwynFormItem *item);

@interface SelwynFormItem : NSObject

/* item 缺省高度 缺省44*/
@property (nonatomic, assign) CGFloat defaultCellHeight;

/* Type of cell */
@property (nonatomic, assign) SelwynFormCellType formCellType;

/* Form title */
@property (nonatomic, copy) NSString *formTitle;
@property (nonatomic, strong) NSAttributedString *formAttributedTitle;

/* Form detail */
@property (nonatomic, copy) NSString *formDetail;

/* Error message */
@property (nonatomic, copy) NSString *formError;

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;

/* Whether is required or must be selected */
@property (nonatomic, assign) BOOL required;

/* Whether can be edited */
@property (nonatomic, assign) BOOL editable;

/* 是否是详情页面 */
@property (nonatomic, assign) BOOL isDetail;

/* 附件图片 */
@property (nonatomic, strong) NSArray *images;

/* 附件最大图片选择数量 缺省4张*/
@property (nonatomic, assign) NSInteger maxImageCount;

/* KeyboardType */
@property (nonatomic, assign) UIKeyboardType keyboardType;

/* Select block */
@property (nonatomic, copy) FormItemSelectHandle selectHandle;

/* Word limit */
@property (nonatomic, assign) NSInteger maxInputLength; //default is 0 and 0 means no limit.

/* TextAlignment of textView content and placeholder */
@property (nonatomic, assign) NSTextAlignment textAlignment;




@end
