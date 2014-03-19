//
//  MasterViewController.m
//  HOOffers
//
//  Created by Frazier Moore on 3/18/14.
//  Copyright (c) 2014 Frazier Moore. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "Offer.h"

@interface MasterViewController () {
    NSMutableArray *_offers;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [self getOffersForQuery:@"findAll"];
}

- (void) getOffersForQuery:(NSString *)query
{
    NSOperationQueue *downloadQueue = [NSOperationQueue new];
    [downloadQueue addOperationWithBlock:^{
        NSString *searchURLString = [NSString stringWithFormat:@"http://api.hasoffers.com/v3/Offer.json?Method=findAll&NetworkToken=NETeMzeZyRUaHEEttxGPWgCPR7BBtS&NetworkId=fraziermoore"];
        
        NSURL *searchURL = [NSURL URLWithString:searchURLString];
        
        NSData *searchData = [NSData dataWithContentsOfURL:searchURL];
        
        NSDictionary *searchDict = [NSJSONSerialization JSONObjectWithData:searchData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
        
        NSMutableArray *tempOffers = [NSMutableArray new];
        
        for (NSDictionary *offer in [searchDict objectForKey:@"data"]) {
            Offer *downloadedOffer = [[Offer alloc] initWithJSON:offer];
            [tempOffers addObject:downloadedOffer];
            NSLog(@"offer => %@",offer);
        }
        
        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
        
        [mainQueue addOperationWithBlock:^{
            _offers = tempOffers;
            [self.tableView reloadData];
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _offers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _offers[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_offers removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *offer = _offers[indexPath.row];
    self.detailViewController.offer = offer;
}

@end
