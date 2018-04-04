//
//  SelwynFormDetailViewController.m
//  SelwynFormDemo
//
//  Created by Selwyn Bi on 2017/6/25.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormDetailViewController.h"
#import "SelwynFormSectionItem.h"
#import "SelwynFormItem.h"
#import "SelwynFormHandle.h"

typedef void(^EditCompletion)();

@interface SelwynFormDetailViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) NSArray *genders;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, copy)EditCompletion editCompletion;

@end

@implementation SelwynFormDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _genders = @[@"男",@"女"];
    
    [self dataSource];

    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _editBtn.titleLabel.font = Font(14);
    [_editBtn sizeToFit];
    [_editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc]initWithCustomView:_editBtn];
    self.navigationItem.rightBarButtonItem = editItem;
}

- (void)edit{
    if (self.editCompletion) {
        self.editCompletion();
    }
}

- (void)dataSource{
    NSMutableArray *datas = [NSMutableArray array];
    
    SelwynFormItem *name = SelwynDetailItemMake(@"姓名", @"Selwyn", SelwynFormCellTypeInput);
    [datas addObject:name];
    
    SelwynFormItem *phoneNumber = SelwynDetailItemMake(@"手机号", @"18511111111", SelwynFormCellTypeInput);
    [datas addObject:phoneNumber];
    
    SelwynFormItem *gender = SelwynDetailItemMake(@"性别", @"男", SelwynFormCellTypeInput);
    [datas addObject:gender];
    
    SelwynFormItem *intro = SelwynDetailItemMake(@"个人简介", @"小小程序员", SelwynFormCellTypeTextViewInput);
    [datas addObject:intro];
    
    SelwynFormSectionItem *sectionItem = [[SelwynFormSectionItem alloc]init];
    sectionItem.cellItems = datas;
    
    [self.mutableArray addObject:sectionItem];
    
    NSMutableArray *datas1 = [NSMutableArray array];
    
    SelwynFormItem *address = SelwynDetailItemMake(@"住址", @"拉斯维加斯拉斯维加斯拉斯维加斯拉斯维加斯拉斯维加斯拉斯维加斯拉斯维加斯拉斯维加斯", SelwynFormCellTypeInput);
    
    [datas1 addObject:address];
    
    SelwynFormItem *attachment = SelwynDetailItemMake(@"附件", @"", SelwynFormCellTypeAttachment);
    
    [datas1 addObject:attachment];
    
    SelwynFormSectionItem *sectionItem1 = [[SelwynFormSectionItem alloc]init];
    sectionItem1.cellItems = datas1;
    sectionItem1.headerHeight = 30;
    sectionItem1.headerColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    sectionItem1.footerHeight = 30;
    sectionItem1.footerColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    sectionItem1.footerTitle = @"section footer";
    sectionItem1.headerTitle = @"section header";
    sectionItem1.headerTitleColor = [UIColor orangeColor];
    sectionItem1.footerTitleColor = [UIColor greenColor];
    
    [self.mutableArray addObject:sectionItem1];
    
    __weak typeof (self) weakSelf = self;
    
    //编辑按钮点击事件
    self.editCompletion = ^(){
        [weakSelf.editBtn setTitle:@"完成" forState:UIControlStateNormal];
        
        name.editable = YES;  //重置可编辑属性
        name.required = YES;    //重置可选必选
        
        phoneNumber.editable = YES;
        phoneNumber.maxInputLength = 11;
        phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
        phoneNumber.required = YES;
        
        gender.formCellType = SelwynFormCellTypeSelect;
        
        intro.editable = YES;
        intro.required = YES;
        
        address.editable = YES;
        address.required = YES;
        
        attachment.editable = YES;
        
        NSLog(@"%@",name.formDetail);
        NSLog(@"%@",attachment.images);
        
        [weakSelf.formTableView reloadData];
    };
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
