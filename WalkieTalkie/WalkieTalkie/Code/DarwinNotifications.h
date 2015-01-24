//
//  Notifications.h
//  NotifyMe
//
//  Created by Konstantin Koval on 23/01/15.
//  Copyright (c) 2015 Kostiantyn Koval. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DarwinNotifications : NSObject

+ (void)addObserver:(CFNotificationCenterRef)center name:(CFStringRef)name;

@end
