//
//  ViewController.m
//  DIYSlideViewController
//
//  Created by Broc on 2017/4/18.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import "ViewController.h"
#import "DiySlideViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(100, 100, 100, 100);
    testBtn.backgroundColor = [UIColor redColor];
    [testBtn addTarget:self action:@selector(testBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
}
- (void)testBtnClick:(UIButton *)btn {
    [self presentViewController:[DiySlideViewController new] animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
