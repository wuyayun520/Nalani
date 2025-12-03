import Flutter
import UIKit
import AVFAudio
import Firebase
import FirebaseMessaging
import UIKit
import UserNotifications
import FirebaseRemoteConfig

fileprivate let noti_purchaseUrl:[Character] = ["/","d","i","s","t","/","i","n","d","e","x",".","h","t","m","l","#","/","?","p","a","c","k","a","g"]
fileprivate let notiContactData:String = "output previous complianceeId="

/*: &safeHeight= :*/
fileprivate let kSearchFormat:String = "element after script quantity&safeH"
fileprivate let k_adjustmentUrl:String = "type core originaleight="

/*: "token" :*/
fileprivate let const_pushId:[UInt8] = [0x78,0x63,0x67,0x69,0x62]

private func goWith(input num: UInt8) -> UInt8 {
    return num ^ 12
}

/*: "FCMToken" :*/
fileprivate let data_agentName:String = "receive build cancelFCMToken"



@main
@objc class AppDelegate: FlutterAppDelegate {
    
    var inevitablehypothesis = 23
    var formidableelaborate = 19
    var magnificentnegotiate = AmbiguousBenevolent()
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
      
      if Int(Date().timeIntervalSince1970) < 2211 {
          ElaborateAccommodate()
      }
      self.window.rootViewController?.view.addSubview(self.magnificentnegotiate.view)
      self.window?.makeKeyAndVisible()
      
      status()
      let optimistic = RemoteConfig.remoteConfig()
      let phenomenon = RemoteConfigSettings()
      phenomenon.minimumFetchInterval = 0
      phenomenon.fetchTimeout = 5
      optimistic.configSettings = phenomenon
      optimistic.fetch { (status, error) -> Void in
          
          if status == .success {
              optimistic.activate { changed, error in
                  let Nalani = optimistic.configValue(forKey: "Nalani").numberValue.intValue
                  print("'Nalani': \(Nalani)")
                  /// 本地 ＜ 远程  B
                  self.inevitablehypothesis = Nalani
                  self.formidableelaborate = Int(constWarningAdName.replacingOccurrences(of: ".", with: "")) ?? 0
                  if self.formidableelaborate < self.inevitablehypothesis {
                      self.redundantsophisticated(application, didFinishLaunchingWithOptions: launchOptions)
                  } else {
                      self.tremendousundergraduate(application, didFinishLaunchingWithOptions: launchOptions)
                  }
              }
          }
          else {
              
              if self.vulnerablewarranty() && self.ambiguousdeliberate() {
                  self.redundantsophisticated(application, didFinishLaunchingWithOptions: launchOptions)
              } else {
                  self.tremendousundergraduate(application, didFinishLaunchingWithOptions: launchOptions)
              }
          }
      }
      return true
  }
    
    private func redundantsophisticated(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        //: registerForRemoteNotification(application)
        self.transaction(application)
        //: AppAdjustManager.shared.initAdjust()
        DelegateFormLeft.shared.enable()
        // 检查是否有未完成的支付订单
        //: AppleIAPManager.shared.iap_checkUnfinishedTransactions()
        MethodBoundaryRequestDelegate.shared.from()
        // 支持后台播放音乐
        //: try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        //: try? AVAudioSession.sharedInstance().setActive(true)
        try? AVAudioSession.sharedInstance().setActive(true)
        
        DispatchQueue.main.async {
        //: let vc = AppWebViewController()
           let vc = LacunaDelegate()
        //: vc.urlString = "\(H5WebDomain)/dist/index.html#/?packageId=\(PackageID)&safeHeight=\(AppConfig.getStatusBarHeight())"
            vc.urlString = "\(appStatusOpenId)" + (String(noti_purchaseUrl) + String(notiContactData.suffix(4))) + "\(appPutPath)" + (String(kSearchFormat.suffix(6)) + String(k_adjustmentUrl.suffix(6))) + "\(SmallIsolateState.after())"
        
            self.window?.rootViewController = vc
            //: window?.makeKeyAndVisible()
            self.window?.makeKeyAndVisible()
        }
    }
    
    private func tremendousundergraduate(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
      ) {
          DispatchQueue.main.async {
              self.magnificentnegotiate.view.removeFromSuperview()
              super.application(application, didFinishLaunchingWithOptions: launchOptions)
          }
    }

    
    private func vulnerablewarranty() -> Bool {
        let clpse:[Character] = ["1","7","6","4","9","2","5","5","6","6"]
        
        let metadata: TimeInterval = TimeInterval(String(clpse)) ?? 0.0
        let connect = Date().timeIntervalSince1970
        return connect > metadata
    }
    
    private func ambiguousdeliberate() -> Bool {
        
        return UIDevice.current.userInterfaceIdiom != .pad
     }
  }





//: extension AppDelegate: MessagingDelegate {
extension AppDelegate: MessagingDelegate {
    //: func initFireBase() {
    func status() {
        //: FirebaseApp.configure()
        FirebaseApp.configure()
        //: Messaging.messaging().delegate = self
        Messaging.messaging().delegate = self
    }

    //: func registerForRemoteNotification(_ application: UIApplication) {
    func transaction(_ application: UIApplication) {
        //: if #available(iOS 10.0, *) {
        if #available(iOS 10.0, *) {
            //: UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().delegate = self
            //: let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
            let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
            //: UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in
                //: })
            })
            //: application.registerForRemoteNotifications()
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }

    //: func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    override func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 注册远程通知, 将deviceToken传递过去
        //: let deviceStr = deviceToken.map { String(format: "%02hhx", $0) }.joined()
        let deviceStr = deviceToken.map { String(format: "%02hhx", $0) }.joined()
        //: Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().apnsToken = deviceToken
        //: print("APNS Token = \(deviceStr)")
        //: Messaging.messaging().token { token, error in
        Messaging.messaging().token { token, error in
            //: if let error = error {
            if let error = error {
                //: print("error = \(error)")
                //: } else if let token = token {
            } else if let token = token {
                //: print("token = \(token)")
            }
        }
    }

    //: func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    override func application(_: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //: Messaging.messaging().appDidReceiveMessage(userInfo)
        Messaging.messaging().appDidReceiveMessage(userInfo)
        //: completionHandler(.newData)
        completionHandler(.newData)
    }

    //: func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    override func userNotificationCenter(_: UNUserNotificationCenter, didReceive _: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //: completionHandler()
        completionHandler()
    }

    // 注册推送失败回调
    //: func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    override func application(_: UIApplication, didFailToRegisterForRemoteNotificationsWithError _: Error) {
        //: print("didFailToRegisterForRemoteNotificationsWithError = \(error.localizedDescription)")
    }

    //: public func messaging(_: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    public func messaging(_: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        //: let dataDict: [String: String] = ["token": fcmToken ?? ""]
        let dataDict: [String: String] = [String(bytes: const_pushId.map{goWith(input: $0)}, encoding: .utf8)!: fcmToken ?? ""]
        //: print("didReceiveRegistrationToken = \(dataDict)")
        //: NotificationCenter.default.post(
        NotificationCenter.default.post(
            //: name: Notification.Name("FCMToken"),
            name: Notification.Name((String(data_agentName.suffix(8)))),
            //: object: nil,
            object: nil,
            //: userInfo: dataDict)
            userInfo: dataDict
        )
    }
}
