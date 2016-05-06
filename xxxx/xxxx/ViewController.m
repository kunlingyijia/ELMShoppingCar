//
//  ViewController.m
//  xxxx
//
//  Created by 席亚坤 on 16/5/6.
//  Copyright © 2016年 席亚坤. All rights reserved.
//

#import "ViewController.h"
#import "RootTableViewCell.h"
#import "ShoppingCarView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIView * redView;
}
@property(nonatomic,strong)UITableView *tableView;
///
@property (nonatomic,strong)NSMutableArray * mArray;
///求和
@property (nonatomic,strong)NSNumber * sum;
@property(nonatomic,strong)ShoppingCarView * shoppingCarView;

@end

@implementation ViewController
-(void)loadView{
    [super loadView];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    [self.view addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.shoppingCarView = [[ShoppingCarView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-60, [UIScreen mainScreen].bounds.size.width, 60)];
    _shoppingCarView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_shoppingCarView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"RootTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.mArray = [NSMutableArray arrayWithCapacity:1];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    for (int i = 0; i< 20; i++) {
         dic = [@{@"addRight":@"-30",@"messageLabel":@"0",@"deleteRight":@"-30"}mutableCopy];
        [self.mArray addObject:dic];
    }
}

#pragma tableView 代理方法
//tab分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //分区个数
    return 1;
}
///tab个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
//tab设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    //判断是否能获取可重用的cell 如果没有获取到cell 则创建一个cell
    if (!cell) {
        cell = [[RootTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"] ;
    }
   cell .selectionStyle =UITableViewCellSelectionStyleNone;
    //给Cell赋值
    NSDictionary * dic = self.mArray[indexPath.row];
    cell.messageLabel.text = [NSString stringWithFormat:@"%@",dic[@"messageLabel"]];
    cell.right.constant = [dic[@"addRight"]integerValue];
    cell.deleteRight.constant = [dic[@"deleteRight"]integerValue];
    cell.addBtn.indexPathBtn = indexPath;
    cell.deleteBtn.indexPathBtn = indexPath;
    cell.moveBtn.indexPathBtn = indexPath;
    [cell.addBtn addTarget:self action:@selector(addBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.deleteBtn addTarget:self action:@selector(deleteBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
       return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

#pragma mark --- 按钮的点击事件
-(void)addBtn:(indexPathBtn*)sender{
    

    RootTableViewCell * cell = [self.tableView cellForRowAtIndexPath:sender.indexPathBtn];
    [self.tableView reloadData];
       NSMutableDictionary * dic = self.mArray[sender.indexPathBtn.row];
    NSInteger a = [dic[@"messageLabel"]integerValue];;
    a++;
    if ([dic[@"messageLabel"]isEqualToString:@"0"]) {
        dic = [@{@"addRight":@"0",@"messageLabel":[NSString stringWithFormat:@"%ld",a],@"deleteRight":@"30"}mutableCopy];
        [self.mArray replaceObjectAtIndex:sender.indexPathBtn.row withObject:dic];
        [UIView animateWithDuration:0.3 animations:^{
            cell.deleteRight.constant = 30;
            cell.right.constant =0;
            [self.view  layoutIfNeeded];
            
            

        }];
        [UIView animateWithDuration:0.8 animations:^{
            cell.deleteBtn.transform = CGAffineTransformRotate(cell.deleteBtn.transform, M_PI) ;
            
            [self.view  layoutIfNeeded];
        }];
    }else if(![dic[@"messageLabel"]isEqualToString:@"0"]){
        dic = [@{@"addRight":@"0",@"messageLabel":[NSString stringWithFormat:@"%ld",a],@"deleteRight":@"30"}mutableCopy];
        [self.mArray replaceObjectAtIndex:sender.indexPathBtn.row withObject:dic];
        [self.view  layoutIfNeeded];

       
    }
    //创建移动动画
    [self addMoveAnination:cell];
    //数组求和
    [self sumArray];
    
   
    
}
#pragma mark --- 创建移动动画
-(void)addMoveAnination:(RootTableViewCell*)cell{
    //1 关键帧动画 ----沿着圆形轨迹移动
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //绘制半圆路径 (贝塞尔曲线)
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 首先设置一个起始点
    [path moveToPoint:cell.moveBtn.center];
    
    // 添加二次曲线
    [path addQuadCurveToPoint:CGPointMake(50, self.view.frame.size.height-60)
                 controlPoint:CGPointMake(-100,-150)];
    //  [path stroke];
    //关键帧动画给上圆形轨迹
    keyframe.path = path.CGPath;//让贝塞尔曲线作为移动轨迹
    //持续时间
    keyframe.duration = 0.5;
    //3 创建分组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[keyframe];
    group.duration = 0.5;
    group.repeatCount = 1;
    [cell.moveBtn.layer addAnimation:group forKey:nil];
    

    
    
}
-(void)deleteBtn:(indexPathBtn*)sender{
    RootTableViewCell * cell = [self.tableView cellForRowAtIndexPath:sender.indexPathBtn];
    [self.tableView reloadData];
     NSMutableDictionary * dic = self.mArray[sender.indexPathBtn.row];
    NSInteger a =    [dic[@"messageLabel"]integerValue];
    a--;
    if (![dic[@"messageLabel"] isEqualToString:@"1"]) {
        dic = [@{@"addRight":@"0",@"messageLabel":[NSString stringWithFormat:@"%ld",a],@"deleteRight":@"30"}mutableCopy];
        [self.mArray replaceObjectAtIndex:sender.indexPathBtn.row withObject:dic];
    }else if ([dic[@"messageLabel"] isEqualToString:@"1"]){
        dic = [@{@"addRight":@"-30",@"messageLabel":[NSString stringWithFormat:@"%ld",a],@"deleteRight":@"-30"}mutableCopy];
        [self.mArray replaceObjectAtIndex:sender.indexPathBtn.row withObject:dic];
        [UIView animateWithDuration:0.5 animations:^{
        cell.deleteRight.constant = -30;
        cell.right.constant =-30;
          [self.view  layoutIfNeeded];
            [UIView animateWithDuration:0.3 animations:^{
                cell.deleteBtn.transform = CGAffineTransformRotate(cell.deleteBtn.transform, M_PI) ;
            [self.view  layoutIfNeeded];
            }];
            
        }];
 
    }
    
    
    //数组求和
    [self sumArray];
}

#pragma mark-- 数组求和
//数组求和
-(void)sumArray{
    NSMutableArray * array  =[NSMutableArray arrayWithCapacity:1] ;
    for (NSMutableDictionary * dic in self.mArray) {
        [array addObject:dic[@"messageLabel"]];
    }
    self.sum = [array valueForKeyPath:@"@sum.floatValue"];
   // NSLog(@"%@",_sum);
    NSString * str = [NSString stringWithFormat:@"%@",_sum];
    //NSLog(@"%@",str);
    if (![str isEqualToString:@"0"]) {
        self.shoppingCarView.shoppingLabel.alpha = 1;
        self.shoppingCarView.shoppingLabel.text = [NSString stringWithFormat:@"%@",_sum];
    }else{
        self.shoppingCarView.shoppingLabel.alpha = 0;
      
    }
}



@end
