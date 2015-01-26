# Walkie-Talkie
A Notifications between iOS and WatchKit

Send messages between iOS and WatchKit apps  
**1. Register listener to chanel  **

```swift
  let notifyier = WalkieTalkie()
  notifyier.registerListener("test") {
      println("Watch App listener")
    }  
```

**2. Send a Message to a chanel  **

``` swift
  let notifyier = WalkieTalkie()
  notifyier.sendMessage("test", object: "Object Message")
```
