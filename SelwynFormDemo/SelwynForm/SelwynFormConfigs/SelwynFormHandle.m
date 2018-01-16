//
//  SelwynFormHandle.m
//  SelwynFormDemo
//
//  Created by BSW on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormHandle.h"

CGFloat const EdgeMarin = 10.0f;
CGFloat const TitleWidth = 100.0f;
CGFloat const TitleHeight = 24.0f;
CGFloat const TitleFont = 16;

@implementation SelwynFormHandle

#pragma mark -- create item
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

//cell 详情
+ (SelwynFormItem *)detailItemWithFormTitle:(NSString *)formTitle formDetail:(NSString *)formDetail cellType:(SelwynFormCellType)cellType{
    
    SelwynFormItem *formItem = [[SelwynFormItem alloc]init];
    formItem.formTitle = formTitle;
    formItem.formDetail = formDetail;
    formItem.editable = NO;
    formItem.keyboardType = UIKeyboardTypeDefault;
    formItem.required = NO;
    formItem.formCellType = cellType;
    formItem.isDetail = YES;
    
    return formItem;
}

#pragma mark -- size of string
+ (CGSize)getSizeWithString:(NSString *)string Font:(UIFont *)font maxSize:(CGSize)maxSize{
    
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}

#pragma mark -- check input or select content
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
