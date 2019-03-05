//
//  ApplicationModel.h
//  进程管家
//
//  Created by mx1614 on 2/21/19.
//  Copyright © 2019 ludy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationModel : NSObject
@property (nonatomic, copy) NSString *localizedName;
@property (nonatomic, strong) NSURL *bundleURL;
@property (nonatomic, assign) pid_t processIdentifier;
@property (nonatomic, strong) NSDate *launchDate;
@property (nonatomic, strong) NSImage *icon;

- (instancetype)initApplicationmodelLocalizedName:(NSString *)name bundleURL:(NSURL *)url processIdentifier:(pid_t)processId launchDate:(NSDate *)date andIcon:(NSImage *)icon;

@end

NS_ASSUME_NONNULL_END
