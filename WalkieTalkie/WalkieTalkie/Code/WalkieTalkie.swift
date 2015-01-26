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

typealias Listener = () -> Void

@objc public class WalkieTalkie {
  
  public class var sharedInstance : WalkieTalkie {
    struct Static {
      static let instance = WalkieTalkie()
    }
    return Static.instance
  }


  var listeners: [String: [Listener]] = [:]
  
  private init() {
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
    if !chanelExist(chanel, chanels: listeners.keys.array) {
      let center = CFNotificationCenterGetDarwinNotifyCenter()
      DarwinNotifications.addObserver(center, observer:self, name: chanel)
    }
    listeners[chanel] = addListener(callback, toChanel: chanel)
  }
  
  public func unregisterListener(chanel: String) {
    let center = CFNotificationCenterGetDarwinNotifyCenter()
    var mSelf = self
    DarwinNotifications.removeObserver(center, observer: self, name: chanel)
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

extension WalkieTalkie {
  
  func chanelExist(chanel: String, chanels: [String]) -> Bool {
    return chanels.filter { $0 == chanel }.count != 0
  }
  
  func addListener(listener:() -> Void, toChanel chanel: String) -> [Listener] {
    var chanelListeners = listeners[chanel] ?? []
    chanelListeners.append(listener)
    return chanelListeners
  }
}
