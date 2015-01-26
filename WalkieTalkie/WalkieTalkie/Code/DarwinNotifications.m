//
//  Notifications.m
//  NotifyMe
//
//  Created by Konstantin Koval on 23/01/15.
//  Copyright (c) 2015 Kostiantyn Koval. All rights reserved.
//

#import "DarwinNotifications.h"

NSString * const WalkieTalkieNotification = @"WalkieTakieDarwinNotification";
NSString * const Chanel = @"chanel";

@implementation DarwinNotifications

+ (void)addObserver:(CFNotificationCenterRef)center observer:(id)observer name:(CFStringRef)name {
  CFNotificationCenterAddObserver(center, (__bridge const void *)(observer), darwinNotificationCallback,
                                  name, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}

+ (void)removeObserver:(CFNotificationCenterRef)center observer:(id)observer name:(CFStringRef)name {
  CFNotificationCenterRemoveObserver(center, (__bridge const void *)observer, name, nil);
}

void darwinNotificationCallback(CFNotificationCenterRef center, void * observer, CFStringRef name,
                                void const * object, CFDictionaryRef userInfo) {
  NSLog(@"Darwin Recived");
  NSString *chanel = (__bridge NSString *)name;
  [[NSNotificationCenter defaultCenter] postNotificationName:WalkieTalkieNotification object:(__bridge id)(observer) userInfo:@{Chanel : chanel}];
}


@end
