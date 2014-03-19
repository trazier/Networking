//
//  DetailViewController.h
//  HOOffers
//
//  Created by Frazier Moore on 3/18/14.
//  Copyright (c) 2014 Frazier Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) Offer *offer;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) IBOutlet UIWebView *offerWebView;

@end
