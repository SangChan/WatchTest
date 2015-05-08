//
//  ViewController.m
//  WatchTest
//
//  Created by SangChan on 2015. 5. 6..
//  Copyright (c) 2015년 sangchan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *mirrorLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLabel:) name:@"changeLabel" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeLabel:(NSNotification *)notification
{
    [self.mirrorLabel setText:[notification.userInfo objectForKey:@"randomNumber"]];
}

@end
