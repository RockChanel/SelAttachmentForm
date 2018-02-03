//
//  SelwynFormAttaViewController.m
//  SelwynFormDemo
//
//  Created by zhuku on 2018/1/16.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SelwynFormAttaViewController.h"
#import "SelwynFormItem.h"
#import "SelwynFormHandle.h"
#import "SelwynFormSectionItem.h"

@interface SelwynFormAttaViewController ()

@end

@implementation SelwynFormAttaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self dataSource];
}

- (void)dataSource{
    
    NSMutableArray *datas = [NSMutableArray array];

    SelwynFormItem *name = SelwynItemMake(@"姓名", @"", SelwynFormCellTypeInput, UIKeyboardTypeDefault, YES, YES);
    [datas addObject:name];
    
    SelwynFormItem *phoneNumber = SelwynItemMake(@"手机号", @"", SelwynFormCellTypeInput, UIKeyboardTypeNumberPad, YES, YES);
    phoneNumber.maxInputLength = 11;  //字数限制
    [datas addObject:phoneNumber];
    
    SelwynFormItem *attachment = SelwynItemMake(@"附件", @"", SelwynFormCellTypeAttachment, UIKeyboardTypeDefault, YES, NO);
    [datas addObject:attachment];
    
    SelwynFormSectionItem *sectionItem = [[SelwynFormSectionItem alloc]init];
    sectionItem.cellItems = datas;
    
    [self.mutableArray addObject:sectionItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
