//
//  TabBarViewController.m
//  TabBar_Animatiom_Demo
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "TabBarViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "MyTabBar.h"


//http://www.jianshu.com/p/89d3fb9949ff
//点击动画

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self initUI];
    
    MyTabBar *myTabBar =[[MyTabBar alloc] init];
    //(1) 由于tabBar是tabBarController的只读属性,因此我们用KVC来设置
    

    [self setValue:myTabBar forKey:@"tabBar"];
    
    
    [self setSplitLineForTabbarItem];
    
}

-(void)initUI
{
    
    NSMutableArray *controllerArray = [NSMutableArray arrayWithCapacity:0];
    
    [controllerArray addObject:@"ViewController1"];
    [controllerArray addObject:@"ViewController2"];
    [controllerArray addObject:@"ViewController3"];
    
    NSArray *titleArray = @[@"首页",@"通讯录",@"我"];
    
    NSArray *imageArray = @[@"tabbar_home_normal",@"tabbar_contract_normal",@"tabbar_mine_normal"];
    NSArray *selectImageArray = @[@"tabbar_home_selected",@"tabbar_contract_selected",@"tabbar_mine_selected"];
    
    NSMutableArray *navArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i <  controllerArray.count;i++ ) {
        Class classController  = NSClassFromString(controllerArray[i]);
        UIViewController *baseController = [[classController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:baseController];
        
        [navArray addObject:nav];
        
        baseController.title = titleArray[i];
        
        
        //设置tabbar的选中和未选中的图片
        
        [nav.tabBarItem setImage:[[UIImage imageNamed:imageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [nav.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [nav.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor redColor]} forState:UIControlStateSelected];
        
        
        
        
        //设置导航条颜色和字体大小及颜色
        nav.navigationBar.barTintColor = [UIColor cyanColor];
        [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        
    }
    self.viewControllers = navArray;



}


- (void)setSplitLineForTabbarItem {
    UITabBar *tabBar = self.tabBar;
    for (int i = 0; i < tabBar.subviews.count; i++) {
        if (i == tabBar.subviews.count - 1) {
            return;
        }
        UIView *view = tabBar.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            NSLog(@"%@",NSStringFromCGRect(view.frame));
            UIView *lineView  = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(view.frame) - 1, 10, 1, CGRectGetHeight(view.frame) - 20)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [view addSubview:lineView];
        }
    }
}


@end
