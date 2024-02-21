//
//  XMViewController.m
//  XMMagnifier
//
//  Created by lxmeng on 02/21/2024.
//  Copyright (c) 2024 lxmeng. All rights reserved.
//

#import "XMViewController.h"
@import XMMagnifier;

@interface XMViewController ()

@end

@implementation XMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clickSwitch:(UISwitch *)sender {
    //    [XMMagnifier shared].frame = CGRectMake(0, 50, 80, 80);
    //    [XMMagnifier shared].layer.cornerRadius = 40;
    //    [XMMagnifier shared].magnification = 2.0;
    [XMMagnifier shared].hidden = !sender.isOn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
