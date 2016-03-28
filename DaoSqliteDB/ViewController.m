//
//  ViewController.m
//  DaoSqliteDB
//
//  Created by Chetu India on 28/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"Hi inside of an viewWillAppear Method.");
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
