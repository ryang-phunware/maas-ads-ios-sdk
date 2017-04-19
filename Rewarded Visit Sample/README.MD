Rewarded Visit - Integration Guide (iOS)
================
Overview
------------
Rewarded Visit Ad uses the features provided by both Mobile Engagement (ME) SDK and Advertising SDK.
To use Rewarded visit Ad in an app both these SDKs need to be integrated. Please follow the steps below to integrate Rewarded visit Ad in an App.

Installation
------------
### CocoaPods
To integrate PWAds and PWMessaging into your Xcode project using CocoaPods, specify it in your `Podfile`:

~~~
pod 'PWCore'
pod 'PWAds'
pod 'PWMessaging'
~~~
Run `pod install` command in your project directory.


### Mobile Engagement (Messaging) SDK
1. Create a new iOS Messaging application in MaaS portal.
2. Configure your app for push notifications.
   * Go to [developer.apple.com] (http://developer.apple.com) and create a push notification certificate.([Push notification tutorial](https://www.raywenderlich.com/123862/push-notifications-tutorial))

   * Once it's created, download the push production certificate and add it to Keychain Access. Then, from Keychain Access, export both the certificate and key. (Right click to view the Export option) as a  .p12 and set a password.

   * Now, log on to the Maas Portal, navigate to the app created for your application and update the following.
     * Certificate (.p12): Click the grey ellipses button to upload the Production Push Certificate you created on developer.apple.com.
     * Password: The password you setup for the push certificate.
     * Environment: Use Production environment for production apps.

   * Enabling the Push Notification Service: In your app, go to `App Settings` -> `Capabilities` and flip the switch for `Push Notifications` to On. Also turn on the switch for `Background Modes`, select `Location updates`.
   * Add the following entries to your plist:
   ~~~
   <key>NSLocationWhenInUseUsageDescription</key>
	 <string>Pleas allow the app to use location service</string>
   <key>NSLocationAlwaysUsageDescription</key>
	 <string>Pleas allow the app to use location service in background</string>
   ~~~
4. In the AppDelegate, initialize PWMessaging SDK using the following code in application:didFinishLaunchingWithOptions:

~~~Swift
PWMessaging.start(withMaasAppId: yourappID, accessKey: yourAccessKey, signatureKey: yourSignatureKey, encryptionKey: "") { (error) in
    if let error = error {
      print(error)
    }
}

PWMessaging.didFinishLaunching(options: launchOptions) { (notification) -> Bool in
    return true
}

PWMessaging.setLocalNotificationHandler { (notification) -> Bool in
    if let notification = notification {
        // notification customization
    }
    // return false if you want to customize and send your own notification
    return true
}
~~~

In application:didRegisterForRemoteNotificationsWithDeviceToken:, add:
~~~Swift
PWMessaging.didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
~~~

In application:didFailToRegisterForRemoteNotificationsWithError:, add:
~~~Swift
PWMessaging.didFailToRegisterForRemoteNotificationsWithError(error)
~~~

Please visit [Phunware Messaging SDK for iOS](https://github.com/phunware/maas-messaging-ios-sdk) for more details.

### PWAdvertising SDK
1. App Transport Security: In order to prevent your ads from being impacted by ATS, please add the following to your plist:
~~~~
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
~~~~

2. In your ViewController, request and present the video ad as such:

~~~Swift
let zoneId = "yourZoneId"
let userId = "yourUserId"

class ViewController: UIViewController, PWAdsRewardedVideoDelegate {

    let adRequest = PWAdsRequest(zoneID: “yourZoneId”)
    var rewardedVideo = PWAdsRewardedVideo()

    override func viewDidLoad() {
        super.viewDidLoad()

        rewardedVideo.delegate = self
        adRequest?.userID = userId
        rewardedVideo.load(adRequest)
    }

    func rewardedVideoDidFinishedPreCaching(_ rewardedVideo: PWAdsRewardedVideo!, withAdExtensionData adExtensionData: [AnyHashable : Any]!) {
        rewardedVideo.present(from: self)
    }
}
~~~

Please visit [Phunware Advertising SDK for iOS](https://github.com/phunware/maas-ads-ios-sdk) for more details.

### Run the app
Watch the video ad, an end card with Rewarded Visit details will be shown at the end of the video. Once the user visits the location that was specified in the end card, he will get a notification with the reward that was set up earlier.
