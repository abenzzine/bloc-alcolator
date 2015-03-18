//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by kevcol on 3/14/15.
//  Copyright (c) 2015 kevcol inc. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Whiskey", @"whiskey");
}



- (void) sliderValueDidChange:(UISlider *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; // assume they are 12 oz beers
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWhiskeyGlass = 1; // 1 oz shot
    float alcoholPercentageOfWhiskey = 0.4; // 80 proof
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural beers");
    }
    
    NSString *whiskeyText;
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural shots");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of whiskey", nil), numberOfBeers, beerText, numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
    self.resultLabel.text = resultText;
    
    NSString *glassesDigit =  [NSString stringWithFormat:NSLocalizedString(@"Whiskey (%.1f %@)", nil), numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];

    
    self.title = NSLocalizedString(glassesDigit, @"whiskey");
                                     
}
@end
