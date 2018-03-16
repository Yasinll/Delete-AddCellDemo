//
//  ViewController.m
//  Delete&AddCellDemo
//
//  Created by PatrickY on 2018/3/16.
//  Copyright © 2018年 PatrickY. All rights reserved.
//

#import "ViewController.h"
static NSString *cellIdentifier = @"cellIdentifier";
@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField                           *textField;
@property (nonatomic, strong) NSMutableArray                        *arrayM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"单元格删除与插入";
    
    _textField = [[UITextField alloc] init];
    _textField.hidden = YES;
    _textField.delegate = self;
    
    _arrayM = [[NSMutableArray alloc] initWithObjects:@"江苏省", @"浙江省", @"陕西省",nil];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
}
#pragma mark --UIViewController生命周期方法
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:YES];
    
    if (editing) {
        _textField.hidden = NO;
    }else {
        _textField.hidden = YES;
    }
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrayM.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    BOOL addCell = (indexPath.row == _arrayM.count);
    
    if (!addCell) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = _arrayM[indexPath.row];
    }else {
        //设置textField
        _textField.frame = CGRectMake(40, 0, 300, cell.frame.size.height);
        _textField.borderStyle = UITextBorderStyleLine;
        _textField.placeholder = @"增加";
        _textField.text = @"";
        
        [cell addSubview:_textField];
    }
    
    return cell;
}

//实现删除和插入
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *idxPath = [NSArray arrayWithObject:indexPath];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_arrayM removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:idxPath withRowAnimation:UITableViewRowAnimationFade];
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [_arrayM insertObject:_textField.text atIndex:_arrayM.count];
        [self.tableView insertRowsAtIndexPaths:idxPath withRowAnimation:UITableViewRowAnimationFade];
        }
    
    [self.tableView reloadData];
}

//删除&增加
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _arrayM.count) {
        return UITableViewCellEditingStyleInsert;
    }else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _arrayM.count) {
        return NO;
    }else {
        return YES;
    }
}

//关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
