//
//  ApplicationModel.m
//  进程管家
//
//  Created by mx1614 on 2/21/19.
//  Copyright © 2019 ludy. All rights reserved.
//

#import "ApplicationModel.h"

@implementation ApplicationModel

- (instancetype)initApplicationmodelLocalizedName:(NSString *)name bundleURL:(NSURL *)url processIdentifier:(pid_t)processId launchDate:(NSDate *)date andIcon:(NSImage *)icon
{
    self = [super init];
    if (self) {
        _localizedName = name;
        _bundleURL = url;
        _processIdentifier = processId;
        _launchDate = date;
        _icon = icon;
    }
    return self;
}

@end
