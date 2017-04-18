//
//  ShowViewController.m
//  DIYSlideViewController
//
//  Created by Broc on 2017/4/18.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 572)];
    _showLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_showLabel];
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
