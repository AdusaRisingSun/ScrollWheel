//
//  ViewController.m
//  ScrollWheel
//
//  Created by Adusa on 15/9/2.
//  Copyright (c) 2015年 Adusa. All rights reserved.
//

#import "ViewController.h"
#import "ScrollWheel.h"
@interface ViewController ()

@end

@implementation ViewController
{
    ScrollWheel *_wheel;
    UILabel *_label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _wheel=[[ScrollWheel alloc]initWithFrame:CGRectMake(100, 300, 200, 200)];
    [_wheel addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_wheel];
    _label=[[UILabel alloc]initWithFrame:CGRectMake(100, 500, 200, 50)];
    [self.view addSubview:_label];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)updateValue:(ScrollWheel *)sw
{
    _label.text=[NSString stringWithFormat:@"%f",_wheel.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
