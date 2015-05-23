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
    
    CIColor *topColor = [CIColor colorWithRed:0.03 green:0.16 blue:0.31 alpha:1];
    CIColor *bottomColor = [CIColor colorWithRed:0.49 green:0.73 blue:0.74 alpha:1];

    self.view.layer.contents = (id)[self textureWithVerticalGradientofSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height) topColor:topColor bottomColor:bottomColor].CGImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeLabel:(NSNotification *)notification
{
    [self.mirrorLabel setText:[notification.userInfo objectForKey:@"randomNumber"]];
}

- (UIImage*)textureWithVerticalGradientofSize:(CGSize)size topColor:(CIColor*)topColor bottomColor:(CIColor*)bottomColor
{
    CIContext *coreImageContext = [CIContext contextWithOptions:nil];
    CIFilter *gradientFilter = [CIFilter filterWithName:@"CILinearGradient"];
    [gradientFilter setDefaults];
    CIVector *startVector = [CIVector vectorWithX:size.width/2 Y:0];
    CIVector *endVector = [CIVector vectorWithX:size.width/2 Y:size.height];
    [gradientFilter setValue:startVector forKey:@"inputPoint0"];
    [gradientFilter setValue:endVector forKey:@"inputPoint1"];
    [gradientFilter setValue:bottomColor forKey:@"inputColor0"];
    [gradientFilter setValue:topColor forKey:@"inputColor1"];
    CGImageRef cgimg = [coreImageContext createCGImage:[gradientFilter outputImage]
                                              fromRect:CGRectMake(0, 0, size.width, size.height)];
    return [UIImage imageWithCGImage:cgimg];
}

@end
