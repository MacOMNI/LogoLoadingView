//
//  ViewController.m
//  LoadingAnimationDemo
//
//  Created by MacKun on 2016/11/14.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "ViewController.h"
#import "LoadingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LoadingView *loadingView = [[LoadingView alloc] initWithFrame:self.view.bounds];
  //  loadingView.backgroundColor = [UIColor redColor];
    [self.view addSubview:loadingView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
