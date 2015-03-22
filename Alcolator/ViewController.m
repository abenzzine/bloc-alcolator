//
//  ViewController.m
//  Alcolator
//
//  Created by kevcol on 3/11/15.
//  Copyright (c) 2015 kevcol inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;
@property (weak, nonatomic) IBOutlet UILabel *beerCounter;

@end

@implementation ViewController

- (void)setTitleColor:(UIColor *)color
             forState:(UIControlState)state; {
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Wine", @"wine");
        
        // Since we don't have icons, let's move the title to the middle of the tab bar
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    
    return self;
}


-(void)loadView {
    // Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    // Allocate and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    // Add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:label];
    [self.view addGestureRecognizer:tap];
    [self.view addSubview:slider];
    
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.hideKeyboardTapGestureRecognizer = tap;
    
    
}

- (void)textFieldDidChange:(UITextField *)sender {
    
    // Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];
    
    // calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine...
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *containText;
    
    if (numberOfBeers == 1) {
        containText = NSLocalizedString(@"contains", @"singular verb contains");
    } else {
        containText = NSLocalizedString(@"contain", @"plural verb contain");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
     NSString *wineGlassesDigit =  [NSString stringWithFormat:NSLocalizedString(@"Wine (%.1f %@)", nil), numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    
    // Display result
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ %@ as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, containText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    
    self.title = NSLocalizedString(wineGlassesDigit, @"wine");
    
    
}

- (void)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
   
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set our primary view's background color
    self.view.backgroundColor = [UIColor colorWithRed:0.953 green:0.612 blue:0.071 alpha:1]; // #e67e22
    
    // Tells the text field that 'self', this instance of 'ViewController' should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    // Set placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    // Pretty it up ... kinda
    self.beerPercentTextField.backgroundColor = [UIColor whiteColor];
    self.beerPercentTextField.font = [UIFont fontWithName:@"American Typewriter" size:18];
    self.beerPercentTextField.textAlignment = NSTextAlignmentCenter;
    
    self.resultLabel.font = [UIFont fontWithName:@"American Typewriter" size:18];
    
    self.beerCountSlider.maximumTrackTintColor = [UIColor colorWithRed:0.957 green:0.702 blue:0.314 alpha:1];
    self.beerCountSlider.minimumTrackTintColor = [UIColor colorWithRed:0.827 green:0.329 blue:0 alpha:1];
    
    
    // Set keyboard attributes
    self.beerPercentTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.beerPercentTextField.keyboardAppearance = UIKeyboardAppearanceDark;
    
    // Tells 'self.beerCountSlider that its value changes, it should call '[self -sliderValueDidChange:]'
    // This is equivalent to connecting the IBAction in the previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Set minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
  
    
    //tells the tap gesture recognizer to call '[self -tapGestureDidFire:]' when it detects a tap
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
    
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewHeight = self.view.bounds.size.height;
    CGFloat padding = 20;
    CGFloat topPadding = viewHeight / 6;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.beerPercentTextField.frame = CGRectMake(padding, topPadding, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight);
    
    //CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    
  
}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
