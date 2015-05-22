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

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    [self addMenuItemWithItemIcon:WKMenuItemIconAdd title:@"더하기" action:@selector(test1:)];
    [self addMenuItemWithItemIcon:WKMenuItemIconInfo title:@"정보" action:@selector(test1:)];
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
    NSLog(@"%@",data);
}
@end


