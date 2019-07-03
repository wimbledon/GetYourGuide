//
//  GYGHttpClient.m
//  David
//
//  Created by David Liu on 7/2/19.
//  Copyright © 2019 GetYourGuide. All rights reserved.
//

#import "GYGHttpClient.h"
#import "NSArray+Utility.h"
#import "GYGReviewModel.h"

@interface GYGHttpClient()
@property (nonatomic) NSUInteger pageIndex;
@end

@implementation GYGHttpClient

- (BFTask *)fetchReviews
{
    self.pageIndex = 0;
    return [self _fetchReviews];
}
- (BFTask *)fetchNextReviews
{
    self.pageIndex += 1;
    return [self _fetchReviews];
}

#pragma mark - Private methods

- (BFTask *)_fetchReviews
{
    return [[self _getURL:@"https://www.getyourguide.com/berlin-l17/tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776/reviews.json"
              parameters:@{@"count" : @(10),
                           @"page" : @(self.pageIndex),
                           @"rating" : @(0),
                           @"sortBy" : @"date_of_review",
                           @"direction" : @"DESC"}] continueWithSuccessBlock:^id _Nullable(BFTask * _Nonnull t) {
        NSDictionary *r = t.result;
        return [r[@"data"] arrayByManipulationBlock:^id _Nonnull(NSDictionary * _Nonnull d, NSUInteger ind) {
            return [[GYGReviewModel alloc] initWithDictionary:d error:nil];
        }];
    }];
}

- (BFTask *)_getURL:(NSString *)url parameters:(NSDictionary *)parameters
{
    BFTaskCompletionSource *tsCs = [BFTaskCompletionSource taskCompletionSource];
    [self GET:url
   parameters:parameters
     progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          [tsCs setResult:responseObject];
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          [tsCs setError:error];
      }];
    
    return tsCs.task;
}

@end
