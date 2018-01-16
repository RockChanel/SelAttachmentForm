//
//  SelwynFormItem.m
//  SelwynFormDemo
//
//  Created by BSW on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormItem.h"
#import "SelwynFormHandle.h"

@implementation SelwynFormItem

- (instancetype)init
{
    self = [super init];
    
    if (self) {
    
        _formDetail = @"";
        _defaultCellHeight = 44;
        _maxImageCount = 4;
    }
    
    return self;
}

#pragma mark -- setFormCellType  set placeholder
- (void)setFormCellType:(SelwynFormCellType)formCellType
{
    _formCellType = formCellType;
    
    switch (formCellType) {
        case SelwynFormCellTypeNone:
        {
            self.placeholder = @"";
        }
            break;
        case SelwynFormCellTypeInput:
        {
            self.placeholder = @"请输入";
        }
            break;
        case SelwynFormCellTypeSelect:
        {
            self.placeholder = @"请选择";
        }
            break;
        case SelwynFormCellTypeTextViewInput:
        {
            self.placeholder = @"请输入";
        }
            break;
        default:
            break;
    }
}

#pragma mark -- isDetail
- (void)setIsDetail:(BOOL)isDetail{
    _isDetail = isDetail;
    if (_isDetail) {
        self.placeholder = @"";
    }
}

#pragma mark -- attributedPlaceholder
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:placeholder attributes:@{NSFontAttributeName:Font(TitleFont),NSForegroundColorAttributeName:[UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1/1.0]}];
    
    _attributedPlaceholder = attributedPlaceholder;
}

#pragma mark - add * before heading if required 
- (void)setRequired:(BOOL)required
{
    _required = required;
    
    NSString *title = self.formTitle;
    
    if (required) {
        title = [NSString stringWithFormat:@"*%@",title];
    }
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc]initWithString:title attributes:@{NSFontAttributeName:Font(TitleFont), NSForegroundColorAttributeName:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]}];
    
    if (required) {
        [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    }
    
    _formAttributedTitle = attributedTitle;
}

@end
