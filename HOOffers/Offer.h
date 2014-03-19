//
//  Offer.h
//  HOOffers
//
//  Created by Frazier Moore on 3/18/14.
//  Copyright (c) 2014 Frazier Moore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Offer : NSObject

- (id) initWithJSON: (NSDictionary *)json;

@property (nonatomic, strong) NSURL *html_url;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong) NSString *htmlCache;

@end
