//
//  SelwynFormHandle.h
//  SelwynFormDemo
//
//  Created by BSW on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelwynFormItem.h"


UIKIT_EXTERN CGFloat const EdgeMarin; //cell margin
UIKIT_EXTERN CGFloat const TitleWidth; //form title width
UIKIT_EXTERN CGFloat const TitleHeight; //form title height
UIKIT_EXTERN CGFloat const TitleFont; //form font size of title
UIKIT_EXTERN CGFloat const DefaultTextViewHeight; //TextViewCellType Default TextView Height

@interface SelwynFormHandle : NSObject

/* create a form item */
+ (SelwynFormItem *)itemWithFormTitle:(NSString *)formTitle formDetail:(NSString *)formDetail cellType:(SelwynFormCellType)cellType keyboardType:(UIKeyboardType)keboardType editable:(BOOL)editable required:(BOOL)required;

+ (SelwynFormItem *)detailItemWithFormTitle:(NSString *)formTitle formDetail:(NSString *)formDetail cellType:(SelwynFormCellType)cellType;

+ (CGSize)getSizeWithString:(NSString *)string Font:(UIFont *)font maxSize:(CGSize)maxSize;

#pragma mark -- check input or select content
+ (SelwynFormItem *)checkContentWithItem:(SelwynFormItem *)item;

@end

NS_INLINE SelwynFormItem *SelwynItemMake(NSString *formTitle, NSString *formDetail, SelwynFormCellType cellType, UIKeyboardType keyboardType, BOOL editable, BOOL required){
    
    return [SelwynFormHandle itemWithFormTitle:formTitle formDetail:formDetail cellType:cellType keyboardType:keyboardType editable:editable required:required];
}

NS_INLINE SelwynFormItem *SelwynDetailItemMake(NSString *formTitle, NSString *formDetail, SelwynFormCellType cellType){
    
    return [SelwynFormHandle detailItemWithFormTitle:formTitle formDetail:formDetail cellType:cellType];
}









