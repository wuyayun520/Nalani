
//: Declare String Begin

/*: "Net Error, Try again later" :*/
fileprivate let const_sourcePlusStr:String = "Net Eroperation move"
fileprivate let kAgentPath:String = "ror, Tby can type no list"
fileprivate let main_onData:[Character] = ["i","n"," ","l","a","t","e","r"]

/*: "data" :*/
fileprivate let k_showMessage:[Character] = ["d","a","t","a"]

/*: ":null" :*/
fileprivate let const_trackPath:[Character] = [":","n","u","l","l"]

/*: "json error" :*/
fileprivate let appManagerPhoneKey:[Character] = ["j","s","o","n"," ","e","r"]
fileprivate let noti_pointPath:String = "bouncer"

/*: "platform=iphone&version= :*/
fileprivate let mainStopName:String = "pcurrency"
fileprivate let k_searchFullStr:[Character] = ["t","f","o","r","m","=","i","p","h","o","n","e","&","v","e","r","s","i","o","n","="]

/*: &packageId= :*/
fileprivate let show_countryMsg:[Character] = ["&","p","a","c","k","a","g","e"]
fileprivate let mainNativeMoveSafePath:String = "Id=float any accounting s"

/*: &bundleId= :*/
fileprivate let const_againMirrorPath:[Character] = ["&","b","u","n","d","l","e","I","d","="]

/*: &lang= :*/
fileprivate let main_productionVersionContent:[Character] = ["&","l","a","n","g"]
fileprivate let constNumberSpaceUrl:String = "procedure"

/*: ; build: :*/
fileprivate let k_receiveCameraData:[Character] = [";"," ","b","u","i","l","d",":"]

/*: ; iOS  :*/
fileprivate let appAllowContent:String = "; iOS carrier indicator fail sign"

//: Declare String End

//: import Alamofire
import Alamofire
//: import CoreMedia
import CoreMedia
//: import HandyJSON
import HandyJSON
// __DEBUG__
// __CLOSE_PRINT__
//: import UIKit
import UIKit

//: typealias FinishBlock = (_ succeed: Bool, _ result: Any?, _ errorModel: AppErrorResponse?) -> Void
typealias FinishBlock = (_ succeed: Bool, _ result: Any?, _ errorModel: SupportErrorResponse?) -> Void

//: @objc class AppRequestTool: NSObject {
@objc class TensorCurveVelocity: NSObject {
    /// 发起Post请求
    /// - Parameters:
    ///   - model: 请求参数
    ///   - completion: 回调
    //: class func startPostRequest(model: AppRequestModel, completion: @escaping FinishBlock) {
    class func statisticalProcedure(model: DisabledRequestModel, completion: @escaping FinishBlock) {
        //: let serverUrl = self.buildServerUrl(model: model)
        let serverUrl = self.purchaseSource(model: model)
        //: let headers = self.getRequestHeader(model: model)
        let headers = self.get(model: model)
        //: AF.request(serverUrl, method: .post, parameters: model.params, headers: headers, requestModifier: { $0.timeoutInterval = 10.0 }).responseData { [self] responseData in
        AF.request(serverUrl, method: .post, parameters: model.params, headers: headers, requestModifier: { $0.timeoutInterval = 10.0 }).responseData { [self] responseData in
            //: switch responseData.result {
            switch responseData.result {
            //: case .success:
            case .success:
                //: func__requestSucess(model: model, response: responseData.response!, responseData: responseData.data!, completion: completion)
                consequence(model: model, response: responseData.response!, responseData: responseData.data!, completion: completion)

            //: case .failure:
            case .failure:
                //: completion(false, nil, AppErrorResponse.init(errorCode: RequestResultCode.NetError.rawValue, errorMsg: "Net Error, Try again later"))
                completion(false, nil, SupportErrorResponse(errorCode: TimingHashableRepresentation.NetError.rawValue, errorMsg: (String(const_sourcePlusStr.prefix(6)) + String(kAgentPath.prefix(6)) + "ry aga" + String(main_onData))))
            }
        }
    }

    //: class func func__requestSucess(model: AppRequestModel, response: HTTPURLResponse, responseData: Data, completion: @escaping FinishBlock) {
    class func consequence(model _: DisabledRequestModel, response _: HTTPURLResponse, responseData: Data, completion: @escaping FinishBlock) {
        //: var responseJson = String(data: responseData, encoding: .utf8)
        var responseJson = String(data: responseData, encoding: .utf8)
        //: responseJson = responseJson?.replacingOccurrences(of: "\"data\":null", with: "\"data\":{}")
        responseJson = responseJson?.replacingOccurrences(of: "\"" + (String(k_showMessage)) + "\"" + (String(const_trackPath)), with: "" + "\"" + (String(k_showMessage)) + "\"" + ":{}")
        //: if let responseModel = JSONDeserializer<AppBaseResponse>.deserializeFrom(json: responseJson) {
        if let responseModel = JSONDeserializer<PhotoTransformable>.deserializeFrom(json: responseJson) {
            //: if responseModel.errno == RequestResultCode.Normal.rawValue {
            if responseModel.errno == TimingHashableRepresentation.Normal.rawValue {
                //: completion(true, responseModel.data, nil)
                completion(true, responseModel.data, nil)
                //: } else {
            } else {
                //: completion(false, responseModel.data, AppErrorResponse.init(errorCode: responseModel.errno, errorMsg: responseModel.msg ?? ""))
                completion(false, responseModel.data, SupportErrorResponse(errorCode: responseModel.errno, errorMsg: responseModel.msg ?? ""))
                //: switch responseModel.errno {
                switch responseModel.errno {
//                case TimingHashableRepresentation.NeedReLogin.rawValue:
//                    NotificationCenter.default.post(name: DID_LOGIN_OUT_SUCCESS_NOTIFICATION, object: nil, userInfo: nil)
                //: default:
                default:
                    //: break
                    break
                }
            }
            //: } else {
        } else {
            //: completion(false, nil, AppErrorResponse.init(errorCode: RequestResultCode.NetError.rawValue, errorMsg: "json error"))
            completion(false, nil, SupportErrorResponse(errorCode: TimingHashableRepresentation.NetError.rawValue, errorMsg: (String(appManagerPhoneKey) + noti_pointPath.replacingOccurrences(of: "bounce", with: "ro"))))
        }
    }

    //: class func buildServerUrl(model: AppRequestModel) -> String {
    class func purchaseSource(model: DisabledRequestModel) -> String {
        //: var serverUrl: String = model.requestServer
        var serverUrl: String = model.requestServer
        //: let otherParams = "platform=iphone&version=\(AppNetVersion)&packageId=\(PackageID)&bundleId=\(AppBundle)&lang=\(UIDevice.interfaceLang)"
        let otherParams = (mainStopName.replacingOccurrences(of: "currency", with: "la") + String(k_searchFullStr)) + "\(main_bigData)" + (String(show_countryMsg) + String(mainNativeMoveSafePath.prefix(3))) + "\(appPutPath)" + (String(const_againMirrorPath)) + "\(dataOpenerScriptPath)" + (String(main_productionVersionContent) + constNumberSpaceUrl.replacingOccurrences(of: "procedure", with: "=")) + "\(UIDevice.interfaceLang)"
        //: if !model.requestPath.isEmpty {
        if !model.requestPath.isEmpty {
            //: serverUrl.append("/\(model.requestPath)")
            serverUrl.append("/\(model.requestPath)")
        }
        //: serverUrl.append("?\(otherParams)")
        serverUrl.append("?\(otherParams)")

        //: return serverUrl
        return serverUrl
    }

    /// 获取请求头参数
    /// - Parameter model: 请求模型
    /// - Returns: 请求头参数
    //: class func getRequestHeader(model: AppRequestModel) -> HTTPHeaders {
    class func get(model _: DisabledRequestModel) -> HTTPHeaders {
        //: let userAgent = "\(AppName)/\(AppVersion) (\(AppBundle); build:\(AppBuildNumber); iOS \(UIDevice.current.systemVersion); \(UIDevice.modelName))"
        let userAgent = "\(data_targetMsg)/\(constWarningAdName) (\(dataOpenerScriptPath)" + (String(k_receiveCameraData)) + "\(dataErrorFormatMsg)" + (String(appAllowContent.prefix(6))) + "\(UIDevice.current.systemVersion); \(UIDevice.modelName))"
        //: let headers = [HTTPHeader.userAgent(userAgent)]
        let headers = [HTTPHeader.userAgent(userAgent)]
        //: return HTTPHeaders(headers)
        return HTTPHeaders(headers)
    }
}
