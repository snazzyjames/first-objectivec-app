//
//  ViewController.h
//  QuoteGen
//
//  Created by Snazzy on 8/14/14.
//  Copyright (c) 2014 Snazzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSArray *myQuotes;
@property (nonatomic, strong) NSMutableArray *movieQuotes;
@property (nonatomic, strong) IBOutlet UITextView *quoteText;
@property (nonatomic, strong) IBOutlet UISegmentedControl *quoteOpt;

-(IBAction) quoteButtonTapped:(id)sender;

@end
