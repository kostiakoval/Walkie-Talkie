//
//  Notifyier.swift
//  NotifyMe
//
//  Created by Konstantin Koval on 20/01/15.
//  Copyright (c) 2015 Kostiantyn Koval. All rights reserved.
//

import Foundation

let WalkieTalkieNotification = "WalkieTakieDarwinNotification"

protocol TargetAction {
  func performAction()
}

struct TargetActionWrapper<T: AnyObject> : TargetAction {
  weak var target: T?
  let action: (T) -> ()->()
  
  func performAction() -> () {
    if let t = target {
      action(t)()
    }
  }
}

@objc public class Notifier {
  
  var listeners: [String: String] = [:]
  
  public init() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector:"walkieTalkieMessage:" , name: WalkieTalkieNotification, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  
  func addObserver<T: AnyObject>(target: AnyObject, action: (T)->()->(), name: String) {
    
  }
  
  public func sendMessage<T>(chanel: String, object: T) {
    let center = CFNotificationCenterGetDarwinNotifyCenter()
    CFNotificationCenterPostNotification(center, chanel, nil, nil, 1)
  }
  
  public func registerListener(chanel: String, callback:() -> Void) {
    let center = CFNotificationCenterGetDarwinNotifyCenter()
    DarwinNotifications.addObserver(center, name: chanel)
  }
  
  public func unregisterListener(chanel: String) {
    let center = CFNotificationCenterGetDarwinNotifyCenter()
    var mSelf = self
    CFNotificationCenterRemoveObserver(center, &mSelf, chanel, nil)
  }
  
  func walkieTalkieMessage(message: NSNotification) {
    print("Recived Message: \(message.userInfo)")
  }
}

/*
let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()

var mSelf = self
var p = UnsafeMutablePointer<(CFNotificationCenter!, UnsafeMutablePointer<Void>, CFString!, UnsafePointer<Void>, CFDictionary!) -> Void>.alloc(1)
p.initialize(wormholeNotificationCallback)
var ff = COpaquePointer(p)
var f = CFunctionPointer<((CFNotificationCenter!, UnsafeMutablePointer<Void>, CFString!, UnsafePointer<Void>, CFDictionary!) -> Void)>(ff)

//Notifications

//CFNotificationCenterAddObserver(notificationCenter, &mSelf, f, "test", nil, .DeliverImmediately)
}*/
