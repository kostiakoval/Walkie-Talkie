//
//  Notifyier.swift
//  NotifyMe
//
//  Created by Konstantin Koval on 20/01/15.
//  Copyright (c) 2015 Kostiantyn Koval. All rights reserved.
//

import Foundation

let WalkieTalkieNotification = "WalkieTakieDarwinNotification"
let Chanel = "chanel"

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

typealias Listener = () -> Void
@objc public class Notifier {

  var listeners: [String: [Listener]] = [:]
  
  public init() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector:"walkieTalkieMessage:" , name: WalkieTalkieNotification, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  public func sendMessage<T>(chanel: String, object: T) {
    let center = CFNotificationCenterGetDarwinNotifyCenter()
    CFNotificationCenterPostNotification(center, chanel, nil, nil, 1)
  }
  
  public func registerListener(chanel: String, callback:() -> Void) {
    let center = CFNotificationCenterGetDarwinNotifyCenter()
    DarwinNotifications.addObserver(center, name: chanel)
    listeners[chanel] = addListener(callback, toChanel: chanel)
  }
  
  public func unregisterListener(chanel: String) {
    let center = CFNotificationCenterGetDarwinNotifyCenter()
    var mSelf = self
    CFNotificationCenterRemoveObserver(center, &mSelf, chanel, nil)
  }
  
  func walkieTalkieMessage(message: NSNotification) {
    let chanel = message.userInfo![Chanel] as String
    println("WalkieTalkie Recived Message: \(message.userInfo)")

    let activeListeners = listeners[chanel] ?? []
    for listener in activeListeners {
      listener()
    }
  }
}

extension Notifier {
  func addListener(listener:() -> Void, toChanel chanel: String) -> [Listener] {
    var chanelListeners = listeners[chanel] ?? []
    chanelListeners.append(listener)
    return chanelListeners
  }
}
