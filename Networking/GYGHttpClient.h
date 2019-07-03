//
//  GYGHttpClient.h
//  David
//
//  Created by David Liu on 7/2/19.
//  Copyright © 2019 GetYourGuide. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
@import Bolts;

NS_ASSUME_NONNULL_BEGIN

@interface GYGHttpClient : AFHTTPSessionManager

- (BFTask *)fetchReviews;
- (BFTask *)fetchNextReviews;

@end

NS_ASSUME_NONNULL_END
