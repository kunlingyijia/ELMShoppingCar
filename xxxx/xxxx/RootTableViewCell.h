//
//  RootTableViewCell.h
//  xxxx
//
//  Created by 席亚坤 on 16/5/6.
//  Copyright © 2016年 席亚坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "indexPathBtn.h"
@interface RootTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet indexPathBtn *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
///XXXLabel
@property (nonatomic, strong) UILabel *label ;
@property (weak, nonatomic) IBOutlet indexPathBtn *deleteBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deleteRight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right;
///移动view
//@property (weak, nonatomic) IBOutlet UIView *moveView;
@property (weak, nonatomic) IBOutlet indexPathBtn *moveBtn;

@end
