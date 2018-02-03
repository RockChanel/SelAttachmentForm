//
//  SelwynFormViewController.m
//  SelwynFormDemo
//
//  Created by BSW on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormViewController.h"
#import "SelwynFormSectionItem.h"
#import "SelwynFormItem.h"
#import "SelwynFormHandle.h"

typedef void(^GenderSelectCompletion)(NSInteger index);

@interface SelwynFormViewController ()<UIActionSheetDelegate>

@property (nonatomic, copy) GenderSelectCompletion genderSelectCompletion;
@property (nonatomic, strong) NSArray *genders;

@end

@implementation SelwynFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _genders = @[@"男",@"女"];
    
    [self _setCommitItem];
    
    [self dataSource];
}

- (void)dataSource{
    
    NSMutableArray *datas = [NSMutableArray array];
    
    SelwynFormItem *name = SelwynItemMake(@"姓名", @"", SelwynFormCellTypeInput, UIKeyboardTypeDefault, YES, YES);
    [datas addObject:name];
    
    SelwynFormItem *phoneNumber = SelwynItemMake(@"手机号", @"", SelwynFormCellTypeInput, UIKeyboardTypeNumberPad, YES, YES);
    phoneNumber.maxInputLength = 11;    //添加字数限制
    [datas addObject:phoneNumber];
    
    SelwynFormItem *gender = SelwynItemMake(@"性别", @"", SelwynFormCellTypeSelect, UIKeyboardTypeDefault, NO, YES);
    gender.selectHandle = ^(SelwynFormItem *item) {
        
        [self selectGenderWithItem:item];
    };
    [datas addObject:gender];
    
    SelwynFormItem *intro = SelwynItemMake(@"个人简介", @"", SelwynFormCellTypeTextViewInput, UIKeyboardTypeDefault, YES, NO);
    [datas addObject:intro];
    
    SelwynFormSectionItem *sectionItem = [[SelwynFormSectionItem alloc]init];
    sectionItem.cellItems = datas;
    
    [self.mutableArray addObject:sectionItem];
    
    NSMutableArray *datas1 = [NSMutableArray array];
    
    SelwynFormItem *address = SelwynItemMake(@"住址", @"", SelwynFormCellTypeInput, UIKeyboardTypeDefault, YES, NO);
    
    [datas1 addObject:address];
    
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

    __weak typeof(self) weakSelf = self;
    
    self.genderSelectCompletion = ^(NSInteger index) {
      
        if (index!=0) {
            
            gender.formDetail = weakSelf.genders[index-1];
            
            [weakSelf.formTableView reloadData];
        }
    };
}

- (void)selectGenderWithItem:(SelwynFormItem *)item{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat:@"请选择%@",item.formTitle] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    
    for (int i = 0; i < _genders.count; i++) {
    
        [actionSheet addButtonWithTitle:_genders[i]];
    }
    actionSheet.tag = 10;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10) {
        
        if (_genderSelectCompletion) {
            _genderSelectCompletion(buttonIndex);
        }
    }
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
