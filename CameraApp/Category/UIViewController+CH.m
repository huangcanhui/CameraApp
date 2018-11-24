//
//  UIViewController+CH.m
//  CameraApp
//
//  Created by aieffei on 2018/11/24.
//  Copyright © 2018年 黄灿辉. All rights reserved.
//

#import "UIViewController+CH.h"

@implementation UIViewController (CH)

- (void)showLogin
{
//    CHLoginViewController *loginVC = [CHLoginViewController new];
//    CHNavigationViewController *navc = [[CHNavigationViewController alloc] initWithRootViewController:loginVC];
//    [[CHUtils ch_topppestViewController] presentViewController:navc animated:YES completion:nil];
}

- (void)showResgister
{
    //    CHRegisterViewController *resVC = [CHRegisterViewController new];
    //    CHNavigationController *navc = [[CHNavigationController alloc] initWithRootViewController:resVC];
    //    [self presentViewController:navc animated:YES completion:nil];
}

- (void)ch_CloseViewController
{
    if (self.navigationController && self.navigationController.childViewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)ch_navigateTo:(UIViewController *)page
{
    if(self.navigationController && page) [self.navigationController pushViewController:page animated:YES] ;
}

- (void)ch_redirectTo:(UIViewController *)page
{
    if (!self.navigationController || !page) return ;
    
    NSArray * controllers = self.navigationController.viewControllers ;
    NSMutableArray * newPages = [NSMutableArray arrayWithCapacity:controllers.count];
    
    for (int i = 0 ; i < controllers.count ; i++) {
        if (controllers[i] == self) {
            [newPages addObject:page] ;
        }else{
            [newPages addObject:controllers[i]] ;
        }
    }
    
    [self.navigationController setViewControllers:newPages animated:NO] ;
}

- (void)ch_navigateBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ch_navigateBack:(NSInteger)delta
{
    if (delta < 1) return ;
    UINavigationController * nav = self.navigationController ;
    if(!nav) return ;
    NSMutableArray * controllers = self.navigationController.viewControllers.mutableCopy ;
    if (delta > controllers.count - 1) delta = controllers.count - 1 ;
    for (NSInteger i = delta - 1 ; i >= 0 ; i --) {
        [controllers removeLastObject] ;
    }
    [nav setViewControllers:controllers animated:YES] ;
}

-(void)ch_navigateBackToPageByName:(NSString *)pageName
{
    if (!pageName) return ;
    if (!self.navigationController) return ;
    Class clazz = NSClassFromString(pageName) ;
    if (clazz && [clazz isSubclassOfClass:[UIViewController class]])
    {
        NSArray * controllers = self.navigationController.viewControllers ;
        for (int i = 0 ; i < controllers.count ; i ++) {
            UIViewController *vc = controllers[i] ;
            if (vc.class == clazz)
            {
                [self.navigationController popToViewController:vc animated:YES] ;
                break ;
            }
        }
    }
}

- (void)ch_closeSomePaggeByName:(NSArray<NSString *> *)pageNames
{
    if (self.navigationController == nil)   return ;
    if (!pageNames || pageNames.count == 0) return ;
    NSMutableArray * controllers = self.navigationController.viewControllers.mutableCopy ;
    NSMutableArray * deletes = @[].mutableCopy ;
    for (NSInteger i = 0 ; i < controllers.count ; i ++ ) {
        UIViewController * vc = controllers[i] ;
        for (int j = 0 ; j < pageNames.count ; j ++) {
            if ([pageNames[j] isEqualToString:NSStringFromClass(vc.class)]){
                [deletes addObject:vc] ;
                break ;
            }
        }
    }
    
    //不能删除所有的vc，必须至少留一个作为栈顶控制器
    if (deletes.count == controllers.count) return ;
    
    UINavigationController * nav = self.navigationController ;
    [controllers removeObjectsInArray:deletes] ;
    [nav setViewControllers:controllers animated:YES] ;
}

- (void)ch_reloadSelf
{
    if (!self.navigationController) return ;
    
    NSArray * controllers = self.navigationController.viewControllers ;
    NSMutableArray * newPages = [NSMutableArray arrayWithCapacity:controllers.count];
    
    for (int i = 0 ; i < controllers.count ; i++) {
        if (controllers[i] == self) {
            Class clazz = self.class ;
            UIViewController * newSelf = [[clazz alloc] init] ;
            [newPages addObject:newSelf] ;
        }else{
            [newPages addObject:controllers[i]] ;
        }
    }
    
    [self.navigationController setViewControllers:newPages animated:NO] ;
}

- (void)ch_navigateBackTabbarItem:(NSInteger)index
{
    [self ch_navigateBack];
    self.navigationController.tabBarController.selectedIndex = index;
}


@end
