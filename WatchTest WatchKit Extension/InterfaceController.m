//
//  InterfaceController.m
//  WatchTest WatchKit Extension
//
//  Created by SangChan on 2015. 5. 6..
//  Copyright (c) 2015년 sangchan. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *priceLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *primeNumberLabel;
- (IBAction)refreshTapped;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *image;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    [self addMenuItemWithItemIcon:WKMenuItemIconAdd title:@"더하기" action:@selector(test1:)];
    [self addMenuItemWithItemIcon:WKMenuItemIconInfo title:@"정보" action:@selector(test1:)];
    
    CIColor *topColor = [CIColor colorWithRed:0.49 green:0.73 blue:0.74 alpha:1];
    CIColor *bottomColor = [CIColor colorWithRed:0.93 green:0.51 blue:0.23 alpha:1];
    
    [self.image setImage:[self textureWithVerticalGradientofSize:CGSizeMake(320,30) topColor:topColor bottomColor:bottomColor]];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)refreshTapped {
    NSString *randomNumber = [NSString stringWithFormat:@"%d",arc4random_uniform(INT16_MAX)];
    
    [self.priceLabel setText:randomNumber];
    
    
    NSDictionary *sendData = [NSDictionary dictionaryWithObjectsAndKeys:randomNumber,@"randomNumber",nil];
    [WKInterfaceController openParentApplication:sendData reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"%@ %@",replyInfo, error);
        [self.primeNumberLabel setText:[replyInfo objectForKey:@"primeNumber"]];
    }];
}

- (void)test1:(id)data
{
    NSLog(@"test1 : %@",data);
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


