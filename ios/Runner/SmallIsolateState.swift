
//: Declare String Begin

/*: "netiexs" :*/
fileprivate let showFullPath:[Character] = ["n","e","t","i","e","x","s"]

/*: "https://m. :*/
fileprivate let notiMethodKey:String = "hcontactcontactps"
fileprivate let constSaveFormat:String = "other by://m."

/*: .com" :*/
fileprivate let kArrowId:String = "environment case.com"

/*: "1.9.1" :*/
fileprivate let showMaxData:String = "1.9.1"

/*: "992" :*/
fileprivate let show_clickFirstMessage:String = "992"

/*: "mzukuti7j5kw" :*/
fileprivate let notiLayerSavePath:String = "mzukusign7"
fileprivate let user_startClickProductPath:[Character] = ["j","5","k","w"]

/*: "zhlimk" :*/
fileprivate let appUsRestoreMessage:String = "zclientimk"

/*: "CFBundleShortVersionString" :*/
fileprivate let app_warnMsg:[Character] = ["C","F","B","u","n","d","l","e","S","h","o","r","t","V","e"]
fileprivate let constControlPath:String = "confirms"
fileprivate let const_resultLabKey:[Character] = ["i","o","n","S","t","r","i","n","g"]

/*: "CFBundleDisplayName" :*/
fileprivate let notiSaveId:String = "challenge reduce big message inputCFBun"
fileprivate let app_argumentServicePath:String = "sploperation"

/*: "CFBundleVersion" :*/
fileprivate let noti_takeValue:[Character] = ["C","F","B","u","n","d"]
fileprivate let show_labelUrl:[Character] = ["l","e","V","e","r","s","i","o","n"]

/*: "weixin" :*/
fileprivate let data_schemeNoFormat:String = "option"
fileprivate let data_thatStr:String = "eixiavailable"

/*: "wxwork" :*/
fileprivate let noti_regionId:String = "name"
fileprivate let show_canTakeUrl:String = "xwornow"

/*: "dingtalk" :*/
fileprivate let appToTagKey:String = "agentngta"
fileprivate let k_decisionMessage:String = "LK"

/*: "lark" :*/
fileprivate let mainLaunchName:String = "lbarrk"

//: Declare String End

// __DEBUG__
// __CLOSE_PRINT__
//
//  SmallIsolateState.swift
//  OverseaH5
//
//  Created by young on 2025/9/24.
//

//: import KeychainSwift
import KeychainSwift
//: import UIKit
import UIKit

/// 域名
//: let ReplaceUrlDomain = "netiexs"
let show_scriptPath = (String(showFullPath))
//: let H5WebDomain = "https://m.\(ReplaceUrlDomain).com"
let appStatusOpenId = (notiMethodKey.replacingOccurrences(of: "contact", with: "t") + String(constSaveFormat.suffix(5))) + "\(show_scriptPath)" + (String(kArrowId.suffix(4)))
/// 网络版本号
//: let AppNetVersion = "1.9.1"
let main_bigData = (showMaxData.capitalized)
/// 包ID
//: let PackageID = "992"
let appPutPath = (show_clickFirstMessage.capitalized)
/// Adjust
//: let AdjustKey = "mzukuti7j5kw"
let data_scriptTitle = (notiLayerSavePath.replacingOccurrences(of: "sign", with: "ti") + String(user_startClickProductPath))
//: let AdInstallToken = "zhlimk"
let constNameData = (appUsRestoreMessage.replacingOccurrences(of: "client", with: "hl"))

//: let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let constWarningAdName = Bundle.main.infoDictionary![(String(app_warnMsg) + constControlPath.replacingOccurrences(of: "confirm", with: "r") + String(const_resultLabKey))] as! String
//: let AppBundle = Bundle.main.bundleIdentifier!
let dataOpenerScriptPath = Bundle.main.bundleIdentifier!
//: let AppName = Bundle.main.infoDictionary!["CFBundleDisplayName"] ?? ""
let data_targetMsg = Bundle.main.infoDictionary![(String(notiSaveId.suffix(5)) + "dleDi" + app_argumentServicePath.replacingOccurrences(of: "operation", with: "a") + "yName")] ?? ""
//: let AppBuildNumber = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
let dataErrorFormatMsg = Bundle.main.infoDictionary![(String(noti_takeValue) + String(show_labelUrl))] as! String

//: class AppConfig: NSObject {
class SmallIsolateState: NSObject {
    /// 获取状态栏高度
    //: class func getStatusBarHeight() -> CGFloat {
    class func after() -> CGFloat {
        //: if #available(iOS 13.0, *) {
        if #available(iOS 13.0, *) {
            //: if let statusBarManager = UIApplication.shared.windows.first?
            if let statusBarManager = UIApplication.shared.windows.first?
                //: .windowScene?.statusBarManager
                .windowScene?.statusBarManager
            {
                //: return statusBarManager.statusBarFrame.size.height
                return statusBarManager.statusBarFrame.size.height
            }
            //: } else {
        } else {
            //: return UIApplication.shared.statusBarFrame.size.height
            return UIApplication.shared.statusBarFrame.size.height
        }
        //: return 20.0
        return 20.0
    }

    /// 获取window
    //: class func getWindow() -> UIWindow {
    class func worldView() -> UIWindow {
        //: var window = UIApplication.shared.windows.first(where: {
        var window = UIApplication.shared.windows.first(where: {
            //: $0.isKeyWindow
            $0.isKeyWindow
            //: })
        })
        // 是否为当前显示的window
        //: if window?.windowLevel != UIWindow.Level.normal {
        if window?.windowLevel != UIWindow.Level.normal {
            //: let windows = UIApplication.shared.windows
            let windows = UIApplication.shared.windows
            //: for windowTemp in windows {
            for windowTemp in windows {
                //: if windowTemp.windowLevel == UIWindow.Level.normal {
                if windowTemp.windowLevel == UIWindow.Level.normal {
                    //: window = windowTemp
                    window = windowTemp
                    //: break
                    break
                }
            }
        }
        //: return window!
        return window!
    }

    /// 获取当前控制器
    //: class func currentViewController() -> (UIViewController?) {
    class func with() -> (UIViewController?) {
        //: var window = AppConfig.getWindow()
        var window = SmallIsolateState.worldView()
        //: if window.windowLevel != UIWindow.Level.normal {
        if window.windowLevel != UIWindow.Level.normal {
            //: let windows = UIApplication.shared.windows
            let windows = UIApplication.shared.windows
            //: for windowTemp in windows {
            for windowTemp in windows {
                //: if windowTemp.windowLevel == UIWindow.Level.normal {
                if windowTemp.windowLevel == UIWindow.Level.normal {
                    //: window = windowTemp
                    window = windowTemp
                    //: break
                    break
                }
            }
        }
        //: let vc = window.rootViewController
        let vc = window.rootViewController
        //: return currentViewController(vc)
        return sign(vc)
    }

    //: class func currentViewController(_ vc: UIViewController?)
    class func sign(_ vc: UIViewController?)
        //: -> UIViewController?
        -> UIViewController?
    {
        //: if vc == nil {
        if vc == nil {
            //: return nil
            return nil
        }
        //: if let presentVC = vc?.presentedViewController {
        if let presentVC = vc?.presentedViewController {
            //: return currentViewController(presentVC)
            return sign(presentVC)
            //: } else if let tabVC = vc as? UITabBarController {
        } else if let tabVC = vc as? UITabBarController {
            //: if let selectVC = tabVC.selectedViewController {
            if let selectVC = tabVC.selectedViewController {
                //: return currentViewController(selectVC)
                return sign(selectVC)
            }
            //: return nil
            return nil
            //: } else if let naiVC = vc as? UINavigationController {
        } else if let naiVC = vc as? UINavigationController {
            //: return currentViewController(naiVC.visibleViewController)
            return sign(naiVC.visibleViewController)
            //: } else {
        } else {
            //: return vc
            return vc
        }
    }
}

// MARK: - Device

//: extension UIDevice {
extension UIDevice {
    //: static var modelName: String {
    static var modelName: String {
        //: var systemInfo = utsname()
        var systemInfo = utsname()
        //: uname(&systemInfo)
        uname(&systemInfo)
        //: let machineMirror = Mirror(reflecting: systemInfo.machine)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        //: let identifier = machineMirror.children.reduce("") {
        let identifier = machineMirror.children.reduce("") {
            //: identifier, element in
            identifier, element in
            //: guard let value = element.value as? Int8, value != 0 else {
            guard let value = element.value as? Int8, value != 0 else {
                //: return identifier
                return identifier
            }
            //: return identifier + String(UnicodeScalar(UInt8(value)))
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        //: return identifier
        return identifier
    }

    /// 获取当前系统时区
    //: static var timeZone: String {
    static var timeZone: String {
        //: let currentTimeZone = NSTimeZone.system
        let currentTimeZone = NSTimeZone.system
        //: return currentTimeZone.identifier
        return currentTimeZone.identifier
    }

    /// 获取当前系统语言
    //: static var langCode: String {
    static var langCode: String {
        //: let language = Locale.preferredLanguages.first
        let language = Locale.preferredLanguages.first
        //: return language ?? ""
        return language ?? ""
    }

    /// 获取接口语言
    //: static var interfaceLang: String {
    static var interfaceLang: String {
        //: let lang = UIDevice.getSystemLangCode()
        let lang = UIDevice.receive()
        //: if ["en", "ar", "es", "pt"].contains(lang) {
        if ["en", "ar", "es", "pt"].contains(lang) {
            //: return lang
            return lang
        }
        //: return "en"
        return "en"
    }

    /// 获取当前系统地区
    //: static var countryCode: String {
    static var countryCode: String {
        //: let locale = Locale.current
        let locale = Locale.current
        //: let countryCode = locale.regionCode
        let countryCode = locale.regionCode
        //: return countryCode ?? ""
        return countryCode ?? ""
    }

    /// 获取系统UUID（每次调用都会产生新值，所以需要keychain）
    //: static var systemUUID: String {
    static var systemUUID: String {
        //: let key = KeychainSwift()
        let key = KeychainSwift()
        //: if let value = key.get(AdjustKey) {
        if let value = key.get(data_scriptTitle) {
            //: return value
            return value
            //: } else {
        } else {
            //: let value = NSUUID().uuidString
            let value = NSUUID().uuidString
            //: key.set(value, forKey: AdjustKey)
            key.set(value, forKey: data_scriptTitle)
            //: return value
            return value
        }
    }

    /// 获取已安装应用信息
    //: static var getInstalledApps: String {
    static var getInstalledApps: String {
        //: var appsArr: [String] = []
        var appsArr: [String] = []
        //: if UIDevice.canOpenApp("weixin") {
        if UIDevice.at((data_schemeNoFormat.replacingOccurrences(of: "option", with: "w") + data_thatStr.replacingOccurrences(of: "available", with: "n"))) {
            //: appsArr.append("weixin")
            appsArr.append((data_schemeNoFormat.replacingOccurrences(of: "option", with: "w") + data_thatStr.replacingOccurrences(of: "available", with: "n")))
        }
        //: if UIDevice.canOpenApp("wxwork") {
        if UIDevice.at((noti_regionId.replacingOccurrences(of: "name", with: "w") + show_canTakeUrl.replacingOccurrences(of: "now", with: "k"))) {
            //: appsArr.append("wxwork")
            appsArr.append((noti_regionId.replacingOccurrences(of: "name", with: "w") + show_canTakeUrl.replacingOccurrences(of: "now", with: "k")))
        }
        //: if UIDevice.canOpenApp("dingtalk") {
        if UIDevice.at((appToTagKey.replacingOccurrences(of: "agent", with: "di") + k_decisionMessage.lowercased())) {
            //: appsArr.append("dingtalk")
            appsArr.append((appToTagKey.replacingOccurrences(of: "agent", with: "di") + k_decisionMessage.lowercased()))
        }
        //: if UIDevice.canOpenApp("lark") {
        if UIDevice.at((mainLaunchName.replacingOccurrences(of: "bar", with: "a"))) {
            //: appsArr.append("lark")
            appsArr.append((mainLaunchName.replacingOccurrences(of: "bar", with: "a")))
        }
        //: if appsArr.count > 0 {
        if appsArr.count > 0 {
            //: return appsArr.joined(separator: ",")
            return appsArr.joined(separator: ",")
        }
        //: return ""
        return ""
    }

    /// 判断是否安装app
    //: static func canOpenApp(_ scheme: String) -> Bool {
    static func at(_ scheme: String) -> Bool {
        //: let url = URL(string: "\(scheme)://")!
        let url = URL(string: "\(scheme)://")!
        //: if UIApplication.shared.canOpenURL(url) {
        if UIApplication.shared.canOpenURL(url) {
            //: return true
            return true
        }
        //: return false
        return false
    }

    /// 获取系统语言
    /// - Returns: 国际通用语言Code
    //: @objc public class func getSystemLangCode() -> String {
    @objc public class func receive() -> String {
        //: let language = NSLocale.preferredLanguages.first
        let language = NSLocale.preferredLanguages.first
        //: let array = language?.components(separatedBy: "-")
        let array = language?.components(separatedBy: "-")
        //: return array?.first ?? "en"
        return array?.first ?? "en"
    }
}
