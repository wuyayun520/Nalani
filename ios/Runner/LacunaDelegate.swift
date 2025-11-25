
//: Declare String Begin

/*: "document.getElementsByTagName('body')[0].style.background='rgba(0,0,0,0)'" :*/
fileprivate let appPieceContent:[UInt8] = [0x7c,0x87,0x7b,0x8d,0x85,0x7d,0x86,0x8c,0x46,0x7f,0x7d,0x8c,0x5d,0x84,0x7d,0x85,0x7d,0x86,0x8c,0x8b,0x5a,0x91,0x6c,0x79,0x7f,0x66,0x79,0x85,0x7d,0x40,0x3f,0x7a,0x87,0x7c,0x91,0x3f,0x41,0x73,0x48,0x75,0x46,0x8b,0x8c,0x91,0x84,0x7d,0x46,0x7a,0x79,0x7b,0x83,0x7f,0x8a,0x87,0x8d,0x86,0x7c,0x55,0x3f,0x8a,0x7f,0x7a,0x79,0x40,0x48,0x44,0x48,0x44,0x48,0x44,0x48,0x41,0x3f]

fileprivate func networkFinish(tag num: UInt8) -> UInt8 {
    let value = Int(num) + 232
    if value > 255 {
        return UInt8(value - 256)
    } else {
        return UInt8(value)
    }
}

/*: "closeWeb" :*/
fileprivate let app_dropFormat:[Character] = ["c","l","o","s","e","W","e","b"]

/*: "toUrl" :*/
fileprivate let k_windowKey:[Character] = ["t","o","U","r","l"]

/*: "syncAppInfo" :*/
fileprivate let notiMapMessage:String = "from lab sharedsyncApp"
fileprivate let noti_itemValue:String = "Infotrigger field no area enter"

/*: "typeName" :*/
fileprivate let mainTextId:String = "typmic"

/*: "isAuth" :*/
fileprivate let app_yourFormat:[Character] = ["i","s","A","u","t","h"]

/*: "isFirst" :*/
fileprivate let main_pushPath:String = "isFirstcorner object plus context of"

/*: "Please click 'Go' to allow access" :*/
fileprivate let user_arrayKey:[UInt8] = [0x9,0x35,0x3c,0x38,0x2a,0x3c,0x79,0x3a,0x35,0x30,0x3a,0x32,0x79,0x7e,0x1e,0x36,0x7e,0x79,0x2d,0x36,0x79,0x38,0x35,0x35,0x36,0x2e,0x79,0x38,0x3a,0x3a,0x3c,0x2a,0x2a]

private func cornerColor(pic num: UInt8) -> UInt8 {
    return num ^ 89
}

/*: "getCameraStatus" :*/
fileprivate let app_behaviorData:[Character] = ["g","e","t","C","a","m","e","r","a","S","t","a","t","u","s"]

/*: "Please allow ' :*/
fileprivate let show_sourceId:String = "full feedback scriptPleas"
fileprivate let notiPoorKey:String = "low \'"

/*: ' to access your camera in your iPhone's 'Settings-Privacy-Camera' option" :*/
fileprivate let dataProgressValue:[UInt8] = [0xdf,0xd8,0x8c,0x97,0xd8,0x99,0x9b,0x9b,0x9d,0x8b,0x8b,0xd8,0x81,0x97,0x8d,0x8a,0xd8,0x9b,0x99,0x95,0x9d,0x8a,0x99,0xd8,0x91,0x96,0xd8,0x81,0x97,0x8d,0x8a,0xd8,0x91,0xa8,0x90,0x97,0x96,0x9d,0xdf,0x8b,0xd8,0xdf,0xab,0x9d,0x8c,0x8c,0x91,0x96,0x9f,0x8b,0xd5,0xa8,0x8a,0x91,0x8e,0x99,0x9b,0x81,0xd5,0xbb,0x99,0x95,0x9d,0x8a,0x99,0xdf,0xd8,0x97,0x88,0x8c,0x91,0x97,0x96]

/*: "getPhotoStatus" :*/
fileprivate let user_selectUrl:String = "getPhmethod view push that screen"
fileprivate let showTapName:String = "tusince"

/*: ' to access your album in your iPhone's 'Settings-Privacy-Album' option" :*/
fileprivate let mainStartFormat:[UInt8] = [0x24,0x23,0x77,0x6c,0x23,0x62,0x60,0x60,0x66,0x70,0x70,0x23,0x7a,0x6c,0x76,0x71,0x23,0x62,0x6f,0x61,0x76,0x6e,0x23,0x6a,0x6d,0x23,0x7a,0x6c,0x76,0x71,0x23,0x6a,0x53,0x6b,0x6c,0x6d,0x66,0x24,0x70,0x23,0x24,0x50,0x66,0x77,0x77,0x6a,0x6d,0x64,0x70,0x2e,0x53,0x71,0x6a,0x75,0x62,0x60,0x7a,0x2e,0x42,0x6f,0x61,0x76,0x6e,0x24,0x23,0x6c,0x73,0x77,0x6a,0x6c,0x6d]

/*: "getMicStatus" :*/
fileprivate let showConfirmData:String = "background indicator forward itemgetMic"

/*: ' to access your microphone in your iPhone's 'Settings-Privacy-Microphone' option" :*/
fileprivate let data_modelText:[UInt8] = [0x26,0x1f,0x73,0x6e,0x1f,0x60,0x62,0x62,0x64,0x72,0x72,0x1f,0x78,0x6e,0x74,0x71,0x1f,0x6c,0x68,0x62,0x71,0x6e,0x6f,0x67,0x6e,0x6d,0x64,0x1f,0x68,0x6d,0x1f,0x78,0x6e,0x74,0x71,0x1f,0x68,0x4f,0x67,0x6e,0x6d,0x64,0x26,0x72,0x1f,0x26,0x52,0x64,0x73,0x73,0x68,0x6d,0x66,0x72,0x2c,0x4f,0x71,0x68,0x75,0x60,0x62,0x78,0x2c,0x4c,0x68,0x62,0x71,0x6e,0x6f,0x67,0x6e,0x6d,0x64,0x26,0x1f,0x6e,0x6f,0x73,0x68,0x6e,0x6d]

fileprivate func scriptFlexible(target num: UInt8) -> UInt8 {
    let value = Int(num) + 1
    if value > 255 {
        return UInt8(value - 256)
    } else {
        return UInt8(value)
    }
}

/*: "Cancel" :*/
fileprivate let userPurchaseValue:[Character] = ["C","a","n","c","e","l"]

/*: "Poor network, loading failed" :*/
fileprivate let const_contentName:[Character] = ["P","o","o","r"," ","n","e","t","w","o","r","k",","," ","l","o","a","d","i","n","g"," ","f","a","i","l","e"]
fileprivate let k_coreMsg:String = "D"

/*: "Refresh" :*/
fileprivate let data_plainStr:String = "Refreshreturn previous from index item"

/*: "Alert" :*/
fileprivate let app_failTitle:String = "Alertload tab root current mirror"

/*: "Done" :*/
fileprivate let user_finishPath:String = "stop tag mDone"

/*: "HttpTool.NativeToJs('recharge')" :*/
fileprivate let mainRemoteContactName:[UInt8] = [0xa3,0xcf,0xcf,0xcb,0xaf,0xca,0xca,0xc7,0x89,0xa9,0xbc,0xcf,0xc4,0xd1,0xc0,0xaf,0xca,0xa5,0xce,0x83,0x82,0xcd,0xc0,0xbe,0xc3,0xbc,0xcd,0xc2,0xc0,0x82,0x84]

fileprivate func challengeInstance(component num: UInt8) -> UInt8 {
    let value = Int(num) - 91
    if value < 0 {
        return UInt8(value + 256)
    } else {
        return UInt8(value)
    }
}

/*: "onPageShow" :*/
fileprivate let appCameraToolPushFormat:[Character] = ["o","n","P","a"]
fileprivate let noti_reText:String = "load or select clickgeShow"

/*: "window.onPageShow&&onPageShow();" :*/
fileprivate let show_laterData:[UInt8] = [0xe7,0xd9,0xde,0xd4,0xdf,0xe7,0x9e,0xdf,0xde,0xc0,0xd1,0xd7,0xd5,0xc3,0xd8,0xdf,0xe7,0x96,0x96,0xdf,0xde,0xc0,0xd1,0xd7,0xd5,0xc3,0xd8,0xdf,0xe7,0x98,0x99,0xab]

fileprivate func selfPropelledVehicle(forward num: UInt8) -> UInt8 {
    let value = Int(num) + 144
    if value > 255 {
        return UInt8(value - 256)
    } else {
        return UInt8(value)
    }
}

/*: "onPageHide" :*/
fileprivate let dataProductShowValue:String = "onPagelayer string new safe app"

/*: "window.onPageHide&&onPageHide();" :*/
fileprivate let kWarningMsg:[UInt8] = [0x3d,0x23,0x24,0x2e,0x25,0x3d,0x64,0x25,0x24,0x1a,0x2b,0x2d,0x2f,0x2,0x23,0x2e,0x2f,0x6c,0x6c,0x25,0x24,0x1a,0x2b,0x2d,0x2f,0x2,0x23,0x2e,0x2f,0x62,0x63,0x71]

private func loadAccess(permission num: UInt8) -> UInt8 {
    return num ^ 74
}

//: Declare String End

// __DEBUG__
// __CLOSE_PRINT__
//
//  LacunaDelegate.swift
//  OverseaH5
//
//  Created by DouXiu on 2025/9/23.
//

//: import UIKit
import UIKit
//: import WebKit
import WebKit
//: import WebViewJavascriptBridge
import WebViewJavascriptBridge

//: class AppWebViewController: UIViewController {
class LacunaDelegate: UIViewController {
    //: var urlString: String = ""
    var urlString: String = ""
    /// 是否背景透明
    //: var clearBgColor = false
    var clearBgColor = false
    /// 是否全屏
    //: var fullscreen = true
    var fullscreen = true

    //: private var bridge: WebViewJavascriptBridge?
    private var bridge: WebViewJavascriptBridge?

    // Pending JS dialog completion handlers (ensure always-called to avoid WKWebView crash)
    //: private var pendingAlertCompletion: (() -> Void)?
    private var pendingAlertCompletion: (() -> Void)?
    //: private var pendingConfirmCompletion: ((Bool) -> Void)?
    private var pendingConfirmCompletion: ((Bool) -> Void)?
    //: private var pendingPromptCompletion: ((String?) -> Void)?
    private var pendingPromptCompletion: ((String?) -> Void)?

    //: lazy var webView: WKWebView = {
    lazy var webView: WKWebView = {
        //: let webConfig = WKWebViewConfiguration()
        let webConfig = WKWebViewConfiguration()
        //: let preferences = WKPreferences()
        let preferences = WKPreferences()
        //: preferences.javaScriptEnabled = true
        preferences.javaScriptEnabled = true
        //: webConfig.preferences = preferences
        webConfig.preferences = preferences
        //: webConfig.allowsInlineMediaPlayback = true
        webConfig.allowsInlineMediaPlayback = true
        //: webConfig.mediaTypesRequiringUserActionForPlayback = []
        webConfig.mediaTypesRequiringUserActionForPlayback = []
        //: let userControl = WKUserContentController()
        let userControl = WKUserContentController()
        //: webConfig.userContentController = userControl
        webConfig.userContentController = userControl
        //: let w = WKWebView(frame: .zero, configuration: webConfig)
        let w = WKWebView(frame: .zero, configuration: webConfig)
        //: w.uiDelegate = self
        w.uiDelegate = self
        //: w.navigationDelegate = self
        w.navigationDelegate = self
        //: w.allowsLinkPreview = false
        w.allowsLinkPreview = false
        //: w.allowsBackForwardNavigationGestures = true
        w.allowsBackForwardNavigationGestures = true
        //: w.scrollView.contentInsetAdjustmentBehavior = .never
        w.scrollView.contentInsetAdjustmentBehavior = .never
        //: w.isOpaque = false
        w.isOpaque = false
        //: w.scrollView.bounces = false
        w.scrollView.bounces = false
        //: w.scrollView.alwaysBounceVertical = false
        w.scrollView.alwaysBounceVertical = false
        //: w.scrollView.alwaysBounceHorizontal = false
        w.scrollView.alwaysBounceHorizontal = false
        //: return w
        return w
        //: }()
    }()

    //: override func viewDidLoad() {
    override func viewDidLoad() {
        //: super.viewDidLoad()
        super.viewDidLoad()
        //: view.addSubview(self.webView)
        view.addSubview(self.webView)
        //: var frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
        var frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
        //: if fullscreen == false {
        if fullscreen == false {
            //: frame.origin.y = AppConfig.getStatusBarHeight()
            frame.origin.y = SmallIsolateState.after()
        }
        //: self.webView.frame = frame
        self.webView.frame = frame

        //: self.addBridgeMethod()
        self.observer()
        //: self.beginStartRequest()
        self.usedDown()

        // 应用从后台切换到前台
        //: NotificationCenter.default.addObserver(self,
        NotificationCenter.default.addObserver(self,
                                               //: selector: #selector(jsEvent_onPageShow),
                                               selector: #selector(navigationalSystem),
                                               //: name: UIApplication.willEnterForegroundNotification,
                                               name: UIApplication.willEnterForegroundNotification,
                                               //: object: nil)
                                               object: nil)
    }

    //: override func viewWillAppear(_ animated: Bool) {
    override func viewWillAppear(_ animated: Bool) {
        //: super.viewWillAppear(animated)
        super.viewWillAppear(animated)
        //: jsEvent_onPageShow()
        navigationalSystem()
    }

    //: override func viewWillDisappear(_ animated: Bool) {
    override func viewWillDisappear(_ animated: Bool) {
        //: super.viewWillDisappear(animated)
        super.viewWillDisappear(animated)
        //: jsEvent_onPageHide()
        appear()
        //: finalizePendingJSHandlersIfNeeded()
        source()
    }

    //: deinit {
    deinit {
        //: removeBridgeMethod()
        drop()
        //: finalizePendingJSHandlersIfNeeded()
        source()
    }

    /// 发起网页请求
    //: private func beginStartRequest() {
    private func usedDown() {
        //: if let url = URL(string: urlString) {
        if let url = URL(string: urlString) {
            //: let urlRequest = URLRequest(url: url)
            let urlRequest = URLRequest(url: url)
            //: self.webView.load(urlRequest)
            self.webView.load(urlRequest)
            //: self.clearJSBgColor()
            self.tincture()
        }
    }

    /// 设置页面为透明
    //: private func clearJSBgColor() {
    private func tincture() {
        //: guard clearBgColor == true else { return }
        guard clearBgColor == true else { return }
        //: webView.evaluateJavaScript("document.getElementsByTagName('body')[0].style.background='rgba(0,0,0,0)'") { _, _  in
        webView.evaluateJavaScript(String(bytes: appPieceContent.map{networkFinish(tag: $0)}, encoding: .utf8)!) { _, _ in
        }
        //: view.backgroundColor = .clear
        view.backgroundColor = .clear
        //: webView.backgroundColor = .clear
        webView.backgroundColor = .clear
        //: webView.scrollView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        //: webView.scrollView.bounces = false
        webView.scrollView.bounces = false
        //: webView.scrollView.alwaysBounceVertical = false
        webView.scrollView.alwaysBounceVertical = false
        //: webView.scrollView.alwaysBounceHorizontal = false
        webView.scrollView.alwaysBounceHorizontal = false
        //: webView.isOpaque = false
        webView.isOpaque = false
    }

    /// 关闭webview事件
    //: func closeWeb() {
    func failOf() {
        //: if webView.canGoBack {
        if webView.canGoBack {
            //: webView.goBack()
            webView.goBack()
            //: return
            return
        }

        //: removeBridgeMethod()
        drop()
        //: if self.presentingViewController != nil {
        if self.presentingViewController != nil {
            // 当前页面dismiss后，下面还是网页时，手动调用viewDidAppear
            //: dismiss(animated: true) {
            dismiss(animated: true) {
                //: if let currentVC = AppConfig.currentViewController() {
                if let currentVC = SmallIsolateState.with() {
                    //: if currentVC.isKind(of: AppWebViewController.self) {
                    if currentVC.isKind(of: LacunaDelegate.self) {
                        //: (currentVC as! AppWebViewController).jsEvent_onPageShow()
                        (currentVC as! LacunaDelegate).navigationalSystem()
                    }
                }
            }
        }
    }
}

//: extension AppWebViewController: WKScriptMessageHandler, WebViewJavascriptBridgeBaseDelegate {
extension LacunaDelegate: WKScriptMessageHandler, WebViewJavascriptBridgeBaseDelegate {
    //: func _evaluateJavascript(_ javascriptCommand: String!) -> String! {
    func _evaluateJavascript(_: String!) -> String! {
        //: return ""
        return ""
    }

    //: func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    func userContentController(_: WKUserContentController, didReceive message: WKScriptMessage) {
        //: print("js call method name = \(message.name), message = \(message.body)")
        // 兼容老事件
        //: DispatchQueue.main.async {
        DispatchQueue.main.async {
            //: let type = message.name
            let type = message.name
            //: if type == "closeWeb" {
            if type == (String(app_dropFormat)) {
                //: self.closeWeb()
                self.failOf()

                //: } else if type == "toUrl" {
            } else if type == (String(k_windowKey)) {
                //: if let url = message.body as? String {
                if let url = message.body as? String {
                    //: AppWebViewController.openNewWebView(url)
                    LacunaDelegate.watch(url)
                }
            }
        }
    }

    //: func addBridgeMethod() {
    func observer() {
        //: self.bridge = WebViewJavascriptBridge(self.webView)
        self.bridge = WebViewJavascriptBridge(self.webView)
        //: self.bridge?.setWebViewDelegate(self)
        self.bridge?.setWebViewDelegate(self)
        //: self.bridge?.registerHandler("syncAppInfo", handler: { data, callback in
        self.bridge?.registerHandler((String(notiMapMessage.suffix(7)) + String(noti_itemValue.prefix(4))), handler: { data, callback in
            //: print("js call getUserIdFromObjC, data from js is %@", data as Any)
            //: if callback != nil {
            if callback != nil {
                //: if let dic = data as? [String: Any] {
                if let dic = data as? [String: Any] {
                    //: self.handleH5Message(schemeDic: dic) { backDic in
                    self.represent(schemeDic: dic) { backDic in
                        //: callback?(backDic)
                        callback?(backDic)
                        //: DispatchQueue.main.async {
                        DispatchQueue.main.async {
                            //: self.handAuthOpenURL(dic: backDic)
                            self.group(dic: backDic)
                        }
                    }
                }
            }
            //: })
        })
        //: let ucController = self.webView.configuration.userContentController
        let ucController = self.webView.configuration.userContentController
        //: ucController.add(AppWebViewScriptDelegateHandler(self), name: "closeWeb")
        ucController.add(DeepDelegateHandler(self), name: (String(app_dropFormat)))
        //: ucController.add(AppWebViewScriptDelegateHandler(self), name: "toUrl")
        ucController.add(DeepDelegateHandler(self), name: (String(k_windowKey)))
    }

    //: func removeBridgeMethod() {
    func drop() {
        //: let ucController = self.webView.configuration.userContentController
        let ucController = self.webView.configuration.userContentController
        //: if #available(iOS 14.0, *) {
        if #available(iOS 14.0, *) {
            //: ucController.removeAllScriptMessageHandlers()
            ucController.removeAllScriptMessageHandlers()
            //: } else {
        } else {
            //: ucController.removeScriptMessageHandler(forName: "closeWeb")
            ucController.removeScriptMessageHandler(forName: (String(app_dropFormat)))
            //: ucController.removeScriptMessageHandler(forName: "toUrl")
            ucController.removeScriptMessageHandler(forName: (String(k_windowKey)))
        }
    }

    //: func handAuthOpenURL(dic: [String: Any]) {
    func group(dic: [String: Any]) {
        //: if let typeName = dic["typeName"] as? String, let isAuth = dic["isAuth"] as? Bool, let isFirst = dic["isFirst"] as? Bool {
        if let typeName = dic[(mainTextId.replacingOccurrences(of: "mic", with: "e") + "Name")] as? String, let isAuth = dic[(String(app_yourFormat))] as? Bool, let isFirst = dic[(String(main_pushPath.prefix(7)))] as? Bool {
            //: if isAuth || isFirst {
            if isAuth || isFirst {
                //: return
                return
            }
            //: var message = "Please click 'Go' to allow access"
            var message = String(bytes: user_arrayKey.map{cornerColor(pic: $0)}, encoding: .utf8)!
            //: var needAlert = false
            var needAlert = false
            //: if typeName == "getCameraStatus" {
            if typeName == (String(app_behaviorData)) {
                //: needAlert = true
                needAlert = true
                //: message = "Please allow '\(AppName)' to access your camera in your iPhone's 'Settings-Privacy-Camera' option"
                message = (String(show_sourceId.suffix(5)) + "e al" + notiPoorKey) + "\(data_targetMsg)" + String(bytes: dataProgressValue.map{$0^248}, encoding: .utf8)!

                //: } else if typeName == "getPhotoStatus" {
            } else if typeName == (String(user_selectUrl.prefix(5)) + "otoSta" + showTapName.replacingOccurrences(of: "since", with: "s")) {
                //: needAlert = true
                needAlert = true
                //: message = "Please allow '\(AppName)' to access your album in your iPhone's 'Settings-Privacy-Album' option"
                message = (String(show_sourceId.suffix(5)) + "e al" + notiPoorKey) + "\(data_targetMsg)" + String(bytes: mainStartFormat.map{$0^3}, encoding: .utf8)!

                //: } else if typeName == "getMicStatus" {
            } else if typeName == (String(showConfirmData.suffix(6)) + "Status") {
                //: needAlert = true
                needAlert = true
                //: message = "Please allow '\(AppName)' to access your microphone in your iPhone's 'Settings-Privacy-Microphone' option"
                message = (String(show_sourceId.suffix(5)) + "e al" + notiPoorKey) + "\(data_targetMsg)" + String(bytes: data_modelText.map{scriptFlexible(target: $0)}, encoding: .utf8)!
            }

            //: if needAlert {
            if needAlert {
                //: let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

                //: let action1 = UIAlertAction(title: "Cancel", style: .default) { _ in
                let action1 = UIAlertAction(title: (String(userPurchaseValue)), style: .default) { _ in
                }
                //: let action2 = UIAlertAction(title: "Go", style: .destructive) { _ in
                let action2 = UIAlertAction(title: "Go", style: .destructive) { _ in
                    //: if let url = URL(string: UIApplication.openSettingsURLString) {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        //: UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
                        UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
                    }
                }
                //: alertController.addAction(action1)
                alertController.addAction(action1)
                //: alertController.addAction(action2)
                alertController.addAction(action2)
                //: present(alertController, animated: true)
                present(alertController, animated: true)
            }
        }
    }
}

//: extension AppWebViewController: WKNavigationDelegate, WKUIDelegate {
extension LacunaDelegate: WKNavigationDelegate, WKUIDelegate {
    //: func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    func webView(_: WKWebView, decidePolicyFor _: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //: decisionHandler(.allow)
        decisionHandler(.allow)
    }

    //: func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        //: UIApplication.shared.isNetworkActivityIndicatorVisible = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    //: func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        //: clearJSBgColor()
        tincture()
        //: UIApplication.shared.isNetworkActivityIndicatorVisible = false
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    //: func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    func webView(_: WKWebView, didFailProvisionalNavigation _: WKNavigation!, withError _: Error) {
        //: let alertController = UIAlertController(title: nil, message: "Poor network, loading failed", preferredStyle: .alert)
        let alertController = UIAlertController(title: nil, message: (String(const_contentName) + k_coreMsg.lowercased()), preferredStyle: .alert)
        //: let action = UIAlertAction(title: "Refresh", style: .default) { _ in
        let action = UIAlertAction(title: (String(data_plainStr.prefix(7))), style: .default) { _ in
            //: self.reloadWebView()
            self.anyRoot()
        }
        //: alertController.addAction(action)
        alertController.addAction(action)
        //: present(alertController, animated: true)
        present(alertController, animated: true)
        //: UIApplication.shared.isNetworkActivityIndicatorVisible = false
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    //: func reloadWebView() {
    func anyRoot() {
        //: if self.webView.url != nil {
        if self.webView.url != nil {
            //: self.webView.reload()
            self.webView.reload()
            //: } else {
        } else {
            //: self.beginStartRequest()
            self.usedDown()
        }
    }

    //: func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {}
    func webView(_: WKWebView, didFail _: WKNavigation!, withError _: Error) {}

    //: func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    func webView(_: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        //: DispatchQueue.global().async {
        DispatchQueue.global().async {
            //: if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                //: if challenge.previousFailureCount == 0 {
                if challenge.previousFailureCount == 0 {
                    //: let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                    let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                    //: completionHandler(.useCredential, credential)
                    completionHandler(.useCredential, credential)
                    //: } else {
                } else {
                    //: completionHandler(.cancelAuthenticationChallenge, nil)
                    completionHandler(.cancelAuthenticationChallenge, nil)
                }
                //: } else {
            } else {
                //: completionHandler(.cancelAuthenticationChallenge, nil)
                completionHandler(.cancelAuthenticationChallenge, nil)
            }
        }
    }

    //: func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
    func webViewWebContentProcessDidTerminate(_: WKWebView) {
        //: self.reloadWebView()
        self.anyRoot()
    }

    //: func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
    func webView(_: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame _: WKFrameInfo, completionHandler: @escaping () -> Void) {
        //: pendingAlertCompletion = completionHandler
        pendingAlertCompletion = completionHandler
        //: let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let alertController = UIAlertController(title: (String(app_failTitle.prefix(5))), message: message, preferredStyle: .alert)
        //: let action = UIAlertAction(title: "OK", style: .default) { _ in
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            //: self.pendingAlertCompletion?()
            self.pendingAlertCompletion?()
            //: self.pendingAlertCompletion = nil
            self.pendingAlertCompletion = nil
        }
        //: alertController.addAction(action)
        alertController.addAction(action)
        //: if let topVC = AppConfig.currentViewController() {
        if let topVC = SmallIsolateState.with() {
            //: topVC.present(alertController, animated: true)
            topVC.present(alertController, animated: true)
            //: } else {
        } else {
            // Fallback to avoid crash if cannot present
            //: self.pendingAlertCompletion?()
            self.pendingAlertCompletion?()
            //: self.pendingAlertCompletion = nil
            self.pendingAlertCompletion = nil
        }
    }

    //: func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
    func webView(_: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame _: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        //: pendingConfirmCompletion = completionHandler
        pendingConfirmCompletion = completionHandler
        //: let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let alertController = UIAlertController(title: (String(app_failTitle.prefix(5))), message: message, preferredStyle: .alert)
        //: let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            //: self.pendingConfirmCompletion?(true)
            self.pendingConfirmCompletion?(true)
            //: self.pendingConfirmCompletion = nil
            self.pendingConfirmCompletion = nil
        }
        //: let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        let cancelAction = UIAlertAction(title: (String(userPurchaseValue)), style: .cancel) { _ in
            //: self.pendingConfirmCompletion?(false)
            self.pendingConfirmCompletion?(false)
            //: self.pendingConfirmCompletion = nil
            self.pendingConfirmCompletion = nil
        }
        //: alertController.addAction(cancelAction)
        alertController.addAction(cancelAction)
        //: alertController.addAction(okAction)
        alertController.addAction(okAction)
        //: if let topVC = AppConfig.currentViewController() {
        if let topVC = SmallIsolateState.with() {
            //: topVC.present(alertController, animated: true)
            topVC.present(alertController, animated: true)
            //: } else {
        } else {
            // Fallback default = false
            //: self.pendingConfirmCompletion?(false)
            self.pendingConfirmCompletion?(false)
            //: self.pendingConfirmCompletion = nil
            self.pendingConfirmCompletion = nil
        }
    }

    //: func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
    func webView(_: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame _: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        //: pendingPromptCompletion = completionHandler
        pendingPromptCompletion = completionHandler
        //: let alertController = UIAlertController(title: prompt, message: "", preferredStyle: .alert)
        let alertController = UIAlertController(title: prompt, message: "", preferredStyle: .alert)
        //: alertController.addTextField { textField in
        alertController.addTextField { textField in
            //: textField.text = defaultText
            textField.text = defaultText
        }
        //: let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
        let doneAction = UIAlertAction(title: (String(user_finishPath.suffix(4))), style: .default) { _ in
            //: let text = alertController.textFields?.first?.text
            let text = alertController.textFields?.first?.text
            //: self.pendingPromptCompletion?(text)
            self.pendingPromptCompletion?(text)
            //: self.pendingPromptCompletion = nil
            self.pendingPromptCompletion = nil
        }
        //: let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        let cancelAction = UIAlertAction(title: (String(userPurchaseValue)), style: .cancel) { _ in
            //: self.pendingPromptCompletion?(nil)
            self.pendingPromptCompletion?(nil)
            //: self.pendingPromptCompletion = nil
            self.pendingPromptCompletion = nil
        }
        //: alertController.addAction(cancelAction)
        alertController.addAction(cancelAction)
        //: alertController.addAction(doneAction)
        alertController.addAction(doneAction)
        //: if let topVC = AppConfig.currentViewController() {
        if let topVC = SmallIsolateState.with() {
            //: topVC.present(alertController, animated: true)
            topVC.present(alertController, animated: true)
            //: } else {
        } else {
            // Fallback default = nil
            //: self.pendingPromptCompletion?(nil)
            self.pendingPromptCompletion?(nil)
            //: self.pendingPromptCompletion = nil
            self.pendingPromptCompletion = nil
        }
    }

    //: @available(iOS 15.0, *)
    @available(iOS 15.0, *)
    //: func webView(_ webView: WKWebView, requestMediaCapturePermissionFor origin: WKSecurityOrigin, initiatedByFrame frame: WKFrameInfo, type: WKMediaCaptureType, decisionHandler: @escaping (WKPermissionDecision) -> Void) {
    func webView(_: WKWebView, requestMediaCapturePermissionFor _: WKSecurityOrigin, initiatedByFrame _: WKFrameInfo, type _: WKMediaCaptureType, decisionHandler: @escaping (WKPermissionDecision) -> Void) {
        //: decisionHandler(.grant)
        decisionHandler(.grant)
    }
}

//: extension AppWebViewController {
extension LacunaDelegate {
    /// Ensure any pending JS dialog completion handlers are executed to avoid WKWebView crash
    //: private func finalizePendingJSHandlersIfNeeded() {
    private func source() {
        //: if let alertCompletion = pendingAlertCompletion {
        if let alertCompletion = pendingAlertCompletion {
            //: alertCompletion()
            alertCompletion()
            //: pendingAlertCompletion = nil
            pendingAlertCompletion = nil
        }
        //: if let confirmCompletion = pendingConfirmCompletion {
        if let confirmCompletion = pendingConfirmCompletion {
            //: confirmCompletion(false)
            confirmCompletion(false)
            //: pendingConfirmCompletion = nil
            pendingConfirmCompletion = nil
        }
        //: if let promptCompletion = pendingPromptCompletion {
        if let promptCompletion = pendingPromptCompletion {
            //: promptCompletion(nil)
            promptCompletion(nil)
            //: pendingPromptCompletion = nil
            pendingPromptCompletion = nil
        }
    }

    /// 通知三方H5刷新金币
    //: func third_jsEvent_refreshCoin() {
    func fiftyCentPiece() {
        //: self.webView.evaluateJavaScript("HttpTool.NativeToJs('recharge')") { data, error in
        self.webView.evaluateJavaScript(String(bytes: mainRemoteContactName.map{challengeInstance(component: $0)}, encoding: .utf8)!) { _, _ in
        }
    }

    /// js事件：网页展示
    //: @objc private func jsEvent_onPageShow() {
    @objc private func navigationalSystem() {
        //: self.bridge?.callHandler("onPageShow")
        self.bridge?.callHandler((String(appCameraToolPushFormat) + String(noti_reText.suffix(6))))
        //: self.webView.evaluateJavaScript("window.onPageShow&&onPageShow();") { data, error in
        self.webView.evaluateJavaScript(String(bytes: show_laterData.map{selfPropelledVehicle(forward: $0)}, encoding: .utf8)!) { _, _ in
            //: print("jsEvent(onPageShow): \(String(describing: data))---\(String(describing: error))")
        }
    }

    /// js事件：网页消失
    //: private func jsEvent_onPageHide() {
    private func appear() {
        //: self.bridge?.callHandler("onPageHide")
        self.bridge?.callHandler((String(dataProductShowValue.prefix(6)) + "Hide"))
        //: self.webView.evaluateJavaScript("window.onPageHide&&onPageHide();") { data, error in
        self.webView.evaluateJavaScript(String(bytes: kWarningMsg.map{loadAccess(permission: $0)}, encoding: .utf8)!) { _, _ in
            //: print("jsEvent(onPageHide): \(String(describing: data))---\(String(describing: error))")
        }
    }
}
