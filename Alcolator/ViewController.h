//
//  ViewController.h
//  Alcolator
//
//  Created by kevcol on 3/11/15.
//  Copyright (c) 2015 kevcol inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UISlider *beerCountSlider;


- (void)buttonPressed:(UIButton *)sender;

- (void)setTitleColor:(UIColor *)color
             forState:(UIControlState)state;




@end

