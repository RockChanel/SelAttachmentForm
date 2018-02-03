//
//  SelwynFormHandle.h
//  SelwynFormDemo
//
//  Created by BSW on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelwynFormItem.h"

/** cell边缘边距 */
UIKIT_EXTERN CGFloat const EdgeMarin;
/** 表单标题宽度 */
UIKIT_EXTERN CGFloat const TitleWidth;
/** 表单标题高度 */
UIKIT_EXTERN CGFloat const TitleHeight;
/** 表单标题字体大小 */
UIKIT_EXTERN CGFloat const TitleFont;
/** 表单textView缺省高度 */
UIKIT_EXTERN CGFloat const DefaultTextViewHeight;

@interface SelwynFormHandle : NSObject

/**
 创建新增表单条目
 
 @param formTitle 标题
 @param formDetail 详情
 @param cellType cell类型
 @param keboardType 键盘类型
 @param editable 是否可编辑
 @param required 是否必填（必选）
 @return 表单条目
 */
+ (SelwynFormItem *)itemWithFormTitle:(NSString *)formTitle formDetail:(NSString *)formDetail cellType:(SelwynFormCellType)cellType keyboardType:(UIKeyboardType)keboardType editable:(BOOL)editable required:(BOOL)required;

/**
 创建详情表单条目

 @param formTitle 标题
 @param formDetail 详情
 @param cellType cell类型
 @return 表单条目
 */
+ (SelwynFormItem *)detailItemWithFormTitle:(NSString *)formTitle formDetail:(NSString *)formDetail cellType:(SelwynFormCellType)cellType;

/** 获取文字CGSize */
+ (CGSize)getSizeWithString:(NSString *)string Font:(UIFont *)font maxSize:(CGSize)maxSize;

/** 校验表单内容 */
+ (SelwynFormItem *)checkContentWithItem:(SelwynFormItem *)item;

@end

/**
 快捷创建新增表单条目

 @param formTitle 标题
 @param formDetail 详情
 @param cellType cell类型
 @param keyboardType 键盘类型
 @param editable 是否可编辑
 @param required 是否必填（必选）
 @return 表单条目
 */
NS_INLINE SelwynFormItem *SelwynItemMake(NSString *formTitle, NSString *formDetail, SelwynFormCellType cellType, UIKeyboardType keyboardType, BOOL editable, BOOL required){
    return [SelwynFormHandle itemWithFormTitle:formTitle formDetail:formDetail cellType:cellType keyboardType:keyboardType editable:editable required:required];
}


/**
 快捷创建详情表单条目
 
 @param formTitle 标题
 @param formDetail 详情
 @param cellType cell类型
 @return 表单条目
 */
NS_INLINE SelwynFormItem *SelwynDetailItemMake(NSString *formTitle, NSString *formDetail, SelwynFormCellType cellType){
    return [SelwynFormHandle detailItemWithFormTitle:formTitle formDetail:formDetail cellType:cellType];
}









