//
//  Notifications.m
//  NotifyMe
//
//  Created by Konstantin Koval on 23/01/15.
//  Copyright (c) 2015 Kostiantyn Koval. All rights reserved.
//

#import "DarwinNotifications.h"
NSString * const WalkieTalkieNotification = @"WalkieTakieDarwinNotification";

@implementation DarwinNotifications


+ (void)addObserver:(CFNotificationCenterRef)center name:(CFStringRef)name {
  CFNotificationCenterAddObserver(center, (__bridge const void *)(self), darwinNotificationCallback,
                                  name, NULL,CFNotificationSuspensionBehaviorDeliverImmediately);
}


void darwinNotificationCallback(CFNotificationCenterRef center, void * observer, CFStringRef name,
                                void const * object, CFDictionaryRef userInfo) {
  NSLog(@"Recived");
  
  NSString *identifier = (__bridge NSString *)name;
  [[NSNotificationCenter defaultCenter] postNotificationName:WalkieTalkieNotification object:nil userInfo:@{@"identifier" : identifier}];
}


@end
