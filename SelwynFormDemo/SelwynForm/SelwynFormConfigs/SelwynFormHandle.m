//
//  SelwynFormHandle.m
//  SelwynFormDemo
//
//  Created by BSW on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormHandle.h"

/** cell边缘边距 */
CGFloat const EdgeMarin = 10.0f;
/** 表单标题宽度 */
CGFloat const TitleWidth = 100.0f;
/** 表单标题高度 */
CGFloat const TitleHeight = 24.0f;
/** 表单标题字体大小 */
CGFloat const TitleFont = 16;
/** 表单textView缺省高度 */
CGFloat const DefaultTextViewHeight = 200.0f;

@implementation SelwynFormHandle

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
+ (SelwynFormItem *)itemWithFormTitle:(NSString *)formTitle formDetail:(NSString *)formDetail cellType:(SelwynFormCellType)cellType keyboardType:(UIKeyboardType)keboardType editable:(BOOL)editable required:(BOOL)required
{
    SelwynFormItem *formItem = [[SelwynFormItem alloc]init];
    formItem.formTitle = formTitle;
    formItem.formDetail = formDetail;
    formItem.formCellType = cellType;
    formItem.keyboardType = keboardType;
    formItem.editable = editable;
    formItem.required = required;
    
    return formItem;
}

/**
 创建详情表单条目
 
 @param formTitle 标题
 @param formDetail 详情
 @param cellType cell类型
 @return 表单条目
 */
+ (SelwynFormItem *)detailItemWithFormTitle:(NSString *)formTitle formDetail:(NSString *)formDetail cellType:(SelwynFormCellType)cellType{
    
    SelwynFormItem *formItem = [[SelwynFormItem alloc]init];
    formItem.formTitle = formTitle;
    formItem.formDetail = formDetail;
    formItem.editable = NO;
    formItem.keyboardType = UIKeyboardTypeDefault;
    formItem.required = NO;
    formItem.formCellType = cellType;
    //是否是详情页面
    formItem.isDetail = YES;
    
    return formItem;
}

/** 获取文字CGSize */
+ (CGSize)getSizeWithString:(NSString *)string Font:(UIFont *)font maxSize:(CGSize)maxSize{
    
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}

/** 校验表单内容 */
+ (SelwynFormItem *)checkContentWithItem:(SelwynFormItem *)item{
    
    item.formError = @"";
    if (item.required) {
        if (!item.formDetail || [item.formDetail isEqualToString:@""]) {
         
            if (item.formCellType == SelwynFormCellTypeInput || item.formCellType == SelwynFormCellTypeTextViewInput) {
                item.formError = [NSString stringWithFormat:@"请输入%@",item.formTitle];
                
            }else if (item.formCellType == SelwynFormCellTypeSelect){
                item.formError = [NSString stringWithFormat:@"请选择%@",item.formTitle];
            }
        }
    }
    return item;
}

@end
