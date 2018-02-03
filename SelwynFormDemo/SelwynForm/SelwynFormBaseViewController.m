//
//  SelwynFormBaseViewController.m
//  SelwynFormDemo
//
//  Created by BSW on 2017/6/24.
//  Copyright © 2017年 selwyn. All rights reserved.
//

#import "SelwynFormBaseViewController.h"

#import "SelwynFormItem.h"
#import "SelwynFormSectionItem.h"
#import "SelwynFormHandle.h"

#import "SelwynFormInputTableViewCell.h"
#import "SelwynFormTextViewInputTableViewCell.h"
#import "SelwynFormSelectTableViewCell.h"
#import "SelwynFormAttachmentTableViewCell.h"

@interface SelwynFormBaseViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 表单样式 */
@property (nonatomic, readonly) UITableViewStyle style;
@end

@implementation SelwynFormBaseViewController

/** 数据源 */
- (NSMutableArray *)mutableArray
{
    if (!_mutableArray) {
        _mutableArray = [NSMutableArray array];
    }
    return _mutableArray;
}

/**
 初始化方法
 @param style 表单样式
 */
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // navigationController
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    //创建formTableView
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:_style];
    [self addChildViewController:tableViewController];
    [tableViewController.view setFrame:self.view.bounds];
    
    _formTableView = tableViewController.tableView;
    _formTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _formTableView.dataSource = self;
    _formTableView.delegate = self;
    _formTableView.showsVerticalScrollIndicator = NO;
    _formTableView.showsHorizontalScrollIndicator = NO;
    _formTableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_formTableView];
}

#pragma mark -- tableView delegate && tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[section];
    return sectionItem.cellItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    
    SelwynFormSectionItem *sectionItem = self.mutableArray[indexPath.section];
    SelwynFormItem *item = sectionItem.cellItems[indexPath.row];
    
    //根据条目cellType创建不同cell
    if (item.formCellType == SelwynFormCellTypeTextViewInput) {
        
        static NSString *cell_id = @"textViewInputCell_id";
        SelwynFormTextViewInputTableViewCell *cell = [tableView formTextViewInputCellWithId:cell_id];
        cell.formItem = item;
        cell.formTextViewInputCompletion = ^(NSString *text) {
          
            [weakSelf updateFormTextViewInputWithText:text indexPath:indexPath];
        };
        return cell;
        
    }else if (item.formCellType == SelwynFormCellTypeSelect){
        
        static NSString *cell_id = @"selectCell_id";
        SelwynFormSelectTableViewCell *cell = [tableView formSelectCellWithId:cell_id];
        cell.formItem = item;
        return cell;
    }
    else if (item.formCellType == SelwynFormCellTypeAttachment){
        
        static NSString *cell_id = @"attachmentCell_id";
        SelwynFormAttachmentTableViewCell *cell = [tableView formAttachmentCellWithId:cell_id];
        cell.formItem = item;
        cell.cellHandle = ^(NSArray *images) {
            [weakSelf updatedAttachments:images indexPath:indexPath];
        };
        return cell;
    }
    else
    {
        static NSString *cell_id = @"inputCell_id";
        SelwynFormInputTableViewCell *cell = [tableView formInputCellWithId:cell_id];
        cell.formItem = item;
        cell.formInputCompletion = ^(NSString *text) {
            [weakSelf updateFormInputWithText:text indexPath:indexPath];
        };
        return cell;
    }
}


/**
 更新附件
 @param images 图片数组
 @param indexPath indexPath
 */
- (void)updatedAttachments:(NSArray *)images indexPath:(NSIndexPath *)indexPath{
    
    SelwynFormSectionItem *sectionModel = self.mutableArray[indexPath.section];
    SelwynFormItem *item = sectionModel.cellItems[indexPath.row];
    item.images = images;
}

/**
 更新InputType输入内容
 @param text 输入内容
 @param indexPath indexPath
 */
- (void)updateFormInputWithText:(NSString *)text indexPath:(NSIndexPath *)indexPath{
    
    SelwynFormSectionItem *sectionItem = self.mutableArray[indexPath.section];
    SelwynFormItem *item = sectionItem.cellItems[indexPath.row];
    item.formDetail = text;
}

/**
 更新TextViewType输入内容
 @param text 输入内容
 @param indexPath indexPath
 */
- (void)updateFormTextViewInputWithText:(NSString *)text indexPath:(NSIndexPath *)indexPath{
    
    SelwynFormSectionItem *sectionItem = self.mutableArray[indexPath.section];
    SelwynFormItem *item = sectionItem.cellItems[indexPath.row];
    item.formDetail = text;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[indexPath.section];
    SelwynFormItem *item = sectionItem.cellItems[indexPath.row];
    
    /** 动态计算cellHeight */
    if (item.formCellType == SelwynFormCellTypeTextViewInput) {
        return [SelwynFormTextViewInputTableViewCell cellHeightWithItem:item];
    }
    else if (item.formCellType == SelwynFormCellTypeSelect){
        return [SelwynFormSelectTableViewCell cellHeightWithItem:item];
    }
    else if (item.formCellType == SelwynFormCellTypeAttachment){
        return [SelwynFormAttachmentTableViewCell cellHeightWithItem:item];
    }
    return [SelwynFormInputTableViewCell cellHeightWithItem:item];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[section];
    return sectionItem.headerHeight > 0 ? sectionItem.headerHeight:0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[section];
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, sectionItem.headerHeight)];
    header.backgroundColor = sectionItem.headerColor;
    
    if (sectionItem.headerTitle) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, header.frame.size.width - 10, header.frame.size.height)];
        titleLabel.font = Font(14);
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.text = sectionItem.headerTitle;
        titleLabel.textColor = sectionItem.headerTitleColor;
        [header addSubview:titleLabel];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[section];
    return sectionItem.footerHeight > 0 ? sectionItem.footerHeight:0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[section];
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, sectionItem.footerHeight)];
    footer.backgroundColor = sectionItem.footerColor;
    
    if (sectionItem.footerTitle) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, footer.frame.size.width - 10, footer.frame.size.height)];
        titleLabel.font = Font(14);
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.text = sectionItem.footerTitle;
        titleLabel.textColor = sectionItem.footerTitleColor;
        [footer addSubview:titleLabel];
    }
    return footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[section];
    return sectionItem.headerTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelwynFormSectionItem *sectionItem = self.mutableArray[indexPath.section];
    SelwynFormItem *item = sectionItem.cellItems[indexPath.row];
    
    if (item.selectHandle) {
        item.selectHandle(item);
    }
}

/** 添加提交按钮 */
- (void)_setCommitItem{
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    commitButton.titleLabel.font = Font(14);
    [commitButton sizeToFit];
    [commitButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *commitItem = [[UIBarButtonItem alloc]initWithCustomView:commitButton];
    self.navigationItem.rightBarButtonItem = commitItem;
}

/** 校验数据 */ 
- (void)commit{
    for (int sec = 0; sec < self.mutableArray.count; sec++) {
        SelwynFormSectionItem *sectionItem = self.mutableArray[sec];
        
        for (int row = 0; row < sectionItem.cellItems.count; row++) {
            
            SelwynFormItem *rowItem = sectionItem.cellItems[row];
            SelwynFormItem *checkItem = [SelwynFormHandle checkContentWithItem:rowItem];
            if (![checkItem.formError isEqualToString:@""]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:checkItem.formError message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                return;
            }
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
