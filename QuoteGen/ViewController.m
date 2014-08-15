//
//  ViewController.m
//  QuoteGen
//
//  Created by Snazzy on 8/14/14.
//  Copyright (c) 2014 Snazzy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.myQuotes = @[
                      @"Live and let live",
                      @"Don't cry over spilt milk",
                      @"Always look on the bright side of life",
                      @"Nobody's perfect",
                      @"Can't see the woods for the trees",
                      @"Better to have loved and lost then not loved at all",
                      @"The early bird catches the worm",
                      @"As slow as a wet week"
                      ];
    
    //Load movie quotes from path of plist
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"plist"];
    self.movieQuotes = [NSMutableArray arrayWithContentsOfFile:plistCatPath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) quoteButtonTapped:(id)sender {
    if(self.quoteOpt.selectedSegmentIndex == 2){
        // 1.1 - Get array count
        int array_tot = [self.myQuotes count];
        // 1.2 - Initialize string for concatenated quotes
        NSString *all_my_quotes = @"";
        NSString *my_quote = nil;
        // 1.3 - Iterate through array
        for (int x=0; x < array_tot; x++) {
            my_quote = self.myQuotes[x];
            all_my_quotes = [NSString stringWithFormat:@"%@\n%@\n",  all_my_quotes,my_quote];
        }
        self.quoteText.text = [NSString stringWithFormat:@"%@", all_my_quotes];
    }
    else{
        NSString *selectedCategory = @"classic";
        
        if (self.quoteOpt.selectedSegmentIndex == 1 ) {
            selectedCategory = @"modern";
        }
        
        //Filter array by category using predicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", selectedCategory];
        NSArray *filteredArray = [self.movieQuotes filteredArrayUsingPredicate:predicate];
        
        int array_tot = [filteredArray count];
        
        if(array_tot > 0) {
            //get random index
            int index = (arc4random() % array_tot);
            //get the quote string from the array for the index
            NSString *quote = filteredArray[index][@"quote"];
            
            //self.quoteText.text = [NSString stringWithFormat:@"Movie Quote: \n\n%@", quote];
            
            // 2.7 - Check if there is a source
            NSString *source = [[filteredArray objectAtIndex:index] valueForKey:@"source"];
            if (![source length] == 0) {
                quote = [NSString stringWithFormat:@"%@\n\n(%@)",  quote, source];
            }
            
            // 2.8 - Customize quote based on category
            if ([selectedCategory isEqualToString:@"classic"]) {
                quote = [NSString stringWithFormat:@"From Classic Movie\n\n%@",  quote];
            } else {
                quote = [NSString stringWithFormat:@"Movie Quote:\n\n%@",  quote];
            }
            
            if ([source hasPrefix:@"Harry"]) {
                quote = [NSString stringWithFormat:@"HARRY ROCKS!!\n\n%@",  quote];
            }
            
            self.quoteText.text = quote;
            
            int movie_array_tot = [self.movieQuotes count];
            NSString *quote1 = filteredArray[index][@"quote"];
            for (int x=0; x < movie_array_tot; x++) {
                NSString *quote2 = self.movieQuotes[x][@"quote"];
                if ([quote1 isEqualToString:quote2]) {
                    NSMutableDictionary *itemAtIndex = (NSMutableDictionary *)self.movieQuotes[x];
                    itemAtIndex[@"source"] = @"DONE";
                }
            }
        }
        else{
            self.quoteText.text = [NSString stringWithFormat:@"No quotes to display"];
        }
    }
}

@end
