//
//  WebServiceHelper.swift
//  Somi
//
//  Created by Paras on 24/03/21.
//

import Foundation
import UIKit



//let BASE_URL = "https://ambitious.in.net/Shubham/reflections/index.php/api/"//Local
let BASE_URL = "https://reflectionsappus.com/index.php/api/"


struct WsUrl{
    
    static let url_SignUp  = BASE_URL + "signup?"
    static let url_GetVehicle = BASE_URL + "get_vehicle"
    static let url_getUserProfile  = BASE_URL + "get_profile"
    static let url_Login  = BASE_URL + "login"
    static let url_ForgotPassword = BASE_URL + "forgot_password"
    static let url_CheckProfile = BASE_URL + "check_profile"
    static let url_GetPurposes = BASE_URL + "get_purposes"
    static let url_GetUserImages = BASE_URL + "get_user_images"
    static let url_Privacy = BASE_URL + "page/Privacy"
    static let url_About = BASE_URL + "page/About"
    static let url_AddUserImage = BASE_URL + "add_user_images"
    static let url_deleteAlbum = BASE_URL + "delete_user_image"
    static let url_VoteImage = BASE_URL + "save_in_favorite"
    static let url_ChangePassword = BASE_URL + "change_password"
    static let url_delete_user_account = BASE_URL + "delete_user_account"
    
}


//Api Header

struct WsHeader {

    //Login

    static let deviceId = "Device-Id"

    static let deviceType = "Device-Type"

    static let deviceTimeZone = "Device-Timezone"

    static let ContentType = "Content-Type"

}



//Api parameters

struct WsParam {

    

    //static let itunesSharedSecret : String = "c736cf14764344a5913c8c1"

    //Signup

    static let dialCode = "dialCode"

    static let contactNumber = "contactNumber"

    static let code = "code"

    static let deviceToken = "deviceToken"

    static let deviceType = "deviceType"

    static let firstName = "firstName"

    static let lastName = "lastName"

    static let email = "email"

    static let driverImage = "driverImage"

    static let isSignup = "isSignup"

    static let licenceImage = "licenceImage"

    static let socialId = "socialId"

    static let socialType = "socialType"

    static let imageUrl = "image_url"

    static let invitationId = "invitationId"

    static let status = "status"

    static let companyId = "companyId"

    static let vehicleId = "vehicleId"

    static let type = "type"

    static let bookingId = "bookingId"

    static let location = "location"

    static let latitude = "latitude"

    static let longitude = "longitude"

    static let currentdate_time = "current_date_time"

}



//Api check for params
struct WsParamsType {
    static let PathVariable = "Path Variable"
    static let QueryParams = "Query Params"
}
