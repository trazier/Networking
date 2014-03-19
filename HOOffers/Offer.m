//
//  Offer.m
//  HOOffers
//
//  Created by Frazier Moore on 3/18/14.
//  Copyright (c) 2014 Frazier Moore. All rights reserved.
//

#import "Offer.h"

@implementation Offer

- (id) initWithJSON:(NSDictionary *)json
{
    if (self = [super init])
    {
        self.name = [json objectForKey:@"name"];
        self.html_url = [NSURL URLWithString:[json objectForKey:@"offer_url"]];
    }
    return self;
}

@end
