//
//  DiySlideViewController.m
//  DIYSlideViewController
//
//  Created by Broc on 2017/4/18.
//  Copyright © 2017年 Broc. All rights reserved.
//

#import "DiySlideViewController.h"
//#import "VTGridViewController.h"
//#import "VTMenuItem.h"
#import "ShowViewController.h"
@interface DiySlideViewController ()<VTMagicViewDelegate>
@property (nonatomic, strong)  NSArray *menuList;
@end

@implementation DiySlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.magicView.navigationHeight = 44;
    //    self.magicView.againstStatusBar = YES;
    //    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    self.magicView.headerView.backgroundColor = [UIColor redColor];
    self.magicView.headerHeight = 100; // 头部view高度
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.sliderStyle = VTSliderStyleBubble;
    self.magicView.sliderColor = RGBCOLOR(229, 229, 229);
    self.magicView.bubbleInset = UIEdgeInsetsMake(2, 7, 2, 7);
    self.magicView.bubbleRadius = 10;
    [self integrateComponents];
    
    [self addNotification];
    [self generateTestData];
    [self.magicView reloadDataToPage:2];// 默认加载哪一页
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.magicView.againstStatusBar = !self.magicView.againstStatusBar;
    [self.magicView setHeaderHidden:NO duration:0];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - NSNotification
- (void)addNotification {
    [self removeNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChange:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)statusBarOrientationChange:(NSNotification *)notification {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
}
#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (UIButton *menu in _menuList) {
        [titleList addObject:menu.titleLabel.text];
    }
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:RGBCOLOR(50, 50, 50) forState:UIControlStateNormal];
        [menuItem setTitleColor:RGBCOLOR(169, 37, 37) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    static NSString *gridId = @"grid.identifier";
    ShowViewController *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!viewController) {
        viewController = [[ShowViewController alloc] init];
    }
    dispatch_async(dispatch_get_main_queue(), ^{ // 有时候默认不是主线程
        
        viewController.showLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)pageIndex];
    });
    
    return viewController;
}

#pragma mark - actions
- (void)subscribeAction {
    NSLog(@"subscribeAction");
    // against status bar or not
    self.magicView.againstStatusBar = !self.magicView.againstStatusBar;
    [self.magicView setHeaderHidden:!self.magicView.isHeaderHidden duration:0.35];
}

#pragma mark - functional methods
- (void)integrateComponents {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightButton addTarget:self action:@selector(subscribeAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:RGBACOLOR(169, 37, 37, 0.6) forState:UIControlStateSelected];
    [rightButton setTitleColor:RGBCOLOR(169, 37, 37) forState:UIControlStateNormal];
    [rightButton setTitle:@"+" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    rightButton.center = self.view.center;
    self.magicView.rightNavigatoinItem = rightButton;
}

- (void)generateTestData {
    NSString *title = @"省份";
    NSMutableArray *menuList = [[NSMutableArray alloc] initWithCapacity:24];
    for (int index = 0; index < 20; index++) {
        title = [NSString stringWithFormat:@"省份%d", index];
        UIButton *menu = [UIButton buttonWithType:UIButtonTypeCustom];
        [menu setTitle:title forState:UIControlStateNormal];
        [menuList addObject:menu];
    }
    _menuList = menuList;
}
- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
    NSLog(@"wwwww   %lu",(unsigned long)itemIndex);
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
