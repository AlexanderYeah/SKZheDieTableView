//
//  ViewController.m
//  ZDTableView
//
//  Created by Alexander on 2018/7/3.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "ShowTb_VC.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
}

- (IBAction)goBtnClick:(id)sender {
	
	ShowTb_VC *vc = [[ShowTb_VC alloc]init];
	
	[self presentViewController:vc animated:YES completion:nil];
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
