//
//  Constants.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/20/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

struct URLS {
    
    static let liveBaseURL:URL = URL(string:"http://demo.m-net.in/p_MNetV2Service/MnetV2WebService/")!
    
    static var baseURL:URL {
        if let savedBaseURL:URL = User.loggedInUser()?.privateApiLink {
            return savedBaseURL
        }
        return liveBaseURL
    }
    
    static var imageBaseURLString:String {
        if let savedBaseURL:String = User.loggedInUser()?.imageURLString {
            return savedBaseURL
        }
        return "http://demo.m-net.in/demo/public/images/"
    }
    
    static let publicBaseURL:URL = URL(string:"http://demo.m-net.in/p_MNetV2Service/MnetV2WebService/")!
    
    static let getSettings:URL = URL(string: "getsetting", relativeTo: baseURL)!
    static let setSettings:URL = URL(string: "setsetting", relativeTo: baseURL)!
    static let setEmailPreferenceSettings:URL = URL(string: "setEmailPreferences", relativeTo: baseURL)!
    static let resetNewPassword:URL = URL(string: "changePassword", relativeTo: publicBaseURL)!
    static let getConversationsList:URL = URL(string: "GetPost", relativeTo: baseURL)!
    static let deleteConversationReply:URL = URL(string: "cancelReply", relativeTo: baseURL)!
    static let deleteUserFromConversation:URL = URL(string:"deletepostuser", relativeTo: baseURL)!
    static let hideConversation:URL = URL(string:"HidePost", relativeTo: baseURL)!
    static let ignoreConversation:URL = URL(string:"ignorePost", relativeTo: baseURL)!
    static let addUsersToExistingConversation:URL = URL(string:"setpostuser", relativeTo: baseURL)!
    static let getSelectUserList:URL = URL(string:"findUsersfuncTo", relativeTo: baseURL)!
    static let createNewConversation:URL = URL(string:"SetPost", relativeTo: baseURL)!
    static let setNewReplyConversation:URL = URL(string:"SetReply", relativeTo: baseURL)!
    static let markConversationAsRead:URL = URL(string: "markPostAsRead", relativeTo: baseURL)!
    static let markNotificationAsRead:URL = URL(string: "readnotification", relativeTo: baseURL)!
    static let getNotificationsList:URL = URL(string: "NotificationList", relativeTo: baseURL)!
    static let getProfile:URL = URL(string: "GetUserDetails", relativeTo: baseURL)!
    static let updateProfile:URL = URL(string: "updateProfile", relativeTo: baseURL)!
    static let getPeopleList:URL = URL(string: "getUserList", relativeTo: baseURL)!
    static let getPeopleProfile:URL = URL(string: "getpeopledetails", relativeTo: baseURL)!
    static let blockUnblock:URL = URL(string: "userBlock", relativeTo: baseURL)!
    static let identifyUser:URL = URL(string: "indentifyUser", relativeTo: publicBaseURL)!
    static let loginAuthenticate:URL = URL(string: "public_authenticate", relativeTo: publicBaseURL)!
    static let registerDevice:URL = URL(string: "registerToken", relativeTo: publicBaseURL)!
    static let deRegisterDevice:URL = URL(string: "deregisterToken", relativeTo: publicBaseURL)!
    static let getUserDetails:URL = URL(string: "GetUserDetails", relativeTo: baseURL)!
    static let getDashboardStatistics:URL = URL(string: "GetDashBoardStatistics", relativeTo: baseURL)!
    static let getUserAppsList:URL = URL(string: "getUserAppList", relativeTo: baseURL)!
    static let setAppPriority:URL = URL(string: "setAppPriority", relativeTo: baseURL)!
    static let getApprovalList:URL = URL(string: "GetApprovedData", relativeTo: baseURL)!
    static let verifyPost:URL = URL(string: "setVerifyRepliesToPost", relativeTo: baseURL)!
    static let approvePost:URL = URL(string: "setAuthorizeRepliesToPost", relativeTo: baseURL)!
    static let rejectPost:URL = URL(string: "rejectRepliesToPost", relativeTo: baseURL)!
}


struct LoginTypeCode {
    
    static let normal:String = "0"
    static let googleSSO:String = "gmail"
    static let oktaSSO:String = "okta"
}

struct AnimationDurations {
    
    static let fast:Double = 0.4
    static let normal:Double = 0.8
    static let slow:Double = 1.2
}

struct DictionaryKeys {
    
    struct APIResponse {
        
        static let error:String = "error"
        static let responseData:String = "status"
        static let noError:String = "0"
        static let noErrorInt:Int = 0
    }
    
    struct LoginPost {
        
        static let username:String = "username"
        static let password:String = "password"
        static let requestFrom:String = "request_from"
        static let loginType:String = "is_authenticate_from"
        static let requestFromApp:String = "App"
    }
    
    struct IdentifyUser {
        
        static let userEmail:String = "userEmail"
        static let requestFrom:String = "requestFrom"
        static let platform:String = "platform"
        static let requesrFromMobileApp:String = "MobileApp"
        static let platformIOS:String = "iOS"
        static let isSSO:String = "is_sso"
        static let ssoType:String = "sso_type"
    }
    
    struct User {
        
        static let userId:String = "user_id"
        static let userCode:String = "code"
    }
    
    struct DeviceRegistration {
        
        static let deviceToken:String = "token_id"
    }
    
    struct Dashboard {
        
        static let days:String = "days"
    }
}

struct AlertMessages {
    
    static let networkUnavailable:String = "Network Unavailable"
    static let success:String = "Success"
    static let failure:String = "Failure"
    static let error:String = "Error"
    static let ok:String = "OK"
    static let sorry:String = "Sorry"
    static let connectToInternet:String = "Please connect to the Internet to continue"
    static let enterReplyMessage:String = "Please enter a reply message"
    static let selectAtleastOneUSer:String = "Please select a user"
}

struct ColorConstants {
    
    static let kBrownColor: UIColor = UIColor(red: 97.0/255.0, green: 72.0/255.0, blue: 57.0/255.0, alpha: 1.0)
    static let kBlueColor: UIColor = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1.0)
    static let kRedColor: UIColor = UIColor(red: 221.0/255.0, green: 75.0/255.0, blue: 57.0/255.0, alpha: 1.0)
    static let kBackgroundColor: UIColor = UIColor(red: 247.0/255.0, green: 248.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    static let kWhiteColor:UIColor = UIColor.white
    static let kGreenColor: UIColor = UIColor(red: 0.0/255.0, green: 128.0/255.0, blue: 0.0/255.0, alpha: 1.0)
}

struct NewConversationUserType {
    
    static let to:String = "To"
    static let bcc:String = "BCC"
    static let forApproval:String = "for Approval"
    static let forVerification:String = "for Verification"
}

struct SettingOptions {
    
    static let aboutMe = "About Me"
    static let password = "Pasword"
    static let privacySettings = "Privacy Settings"
    static let appSettings = "App Settings"
    static let emailPreferences = "Email Preferences"
    static let people = "People"
    static let blockedUsers = "Blocked Users"
    static let logout = "Logout"
}


struct PrivacySettingOptions {
    
    static let myEmailID:String = "My Email ID"
    static let myEmailIDDescription:String = "Show your Email ID to others users."
    
    static let myAddress:String = "My Address"
    static let myAddressDescription:String = "Show your Address to others users."
    
    static let myMobile:String = "My Mobile"
    static let myMobileDescription:String = "Show your Mobile to others users."
    
    static let myBirthday:String = "My Birthday"
    static let myBirthdayDescription:String = "Show your Birthday to others users."
    
    static let mydesignation:String = "My Designation"
    static let mydesignationDescription:String = "Show your Designation to others users."
    
    static let mydepartment:String = "My Department"
    static let mydepartmentDescription:String = "Show your Department to others users."
    
    static let myOrganization:String = "My Organization"
    static let myOrganizationDescription:String = "Show your Organization to others users."
    
    static let myCompany:String = "My Company"
    static let myCompanyDescription:String = "Show your Company to others users."
    
    static let myApplication:String = "My Application"
    static let myApplicationDescription:String = "Show your Applications to others users."
    
    static let myGroup:String = "My Group"
    static let myGroupDescription:String = "Show your Group to others users."
    
    static let myTask:String = "My Task"
    static let myTaskDescription:String = "Show your Task to others users."
    
    static let mySchedule:String = "My schedule"
    static let myScheduleDescription:String = "Show your Schedule to others users."
}


struct CellIdentifiers {
    
    static let dashboardMyAppsTableView:String = "DashboardMyAppsTableViewCell"
    static let conversationListTableView:String = "conversationListTableViewCell"
    static let approvalsSectionsCollectionViewCell:String = "approvalSectionsCollectionViewCell"
    static let pendingApprovalsTableViewCell:String = "pendingApprovalsTableViewCell"
    static let filterTableViewCell:String = "filterTableViewCell"
    static let optionTableViewCell:String = "optionTableViewCell"
    static let pendingApprovalsCollectionViewCell:String = "pendingApprovalsCollectionViewCell"
    static let userListTableViewCell:String = "userListTableViewCell"
    static let settingOptionsTableViewCell:String = "SettingOptionsTableViewCell"
    static let peopleTableViewCell:String = "PeopleTableViewCell"
    static let privacySettingsOptionTableViewCell:String = "PrivacySettingOptionTableViewCell"
    static let notificationTableViewCell:String = "NotificationTableViewCell"
    static let selectedUsersCollectionViewCell:String = "SelectedUsersCollectionViewCell"
    static let selectUsersTableViewCell:String = "SelectUserTableViewCell"
    static let membersTableViewCell:String = "MembersTableViewCell"
    static let peopleListTableViewCell:String = "PeopleListTableViewCell"
    static let popoverTableViewCell:String = "popoverTableViewCell"
    static let sendPeopleListTableViewCell:String = "SendPeopleListTableViewCell"

}

struct TabNames {
    
    static let dashboard:String = "Dashboard"
    static let conversations:String = "Conversations"
    static let settings:String = "Settings"
    static let notifications:String = "Notifications"
}

struct UserDefaultsKeys {
    
    static let loggedInUser:String = "loggedInUser"
    static let loginStatus:String = "isUserLoggedIn"
    static let deviceToken:String = "deviceTokenForRemoteNotifications"
    static let baseURL:String = "savedBaseURL"
    static let imagesBaseURL:String = "imagesBaseURL"
    static let didReceiveNotification:String = "didReceiveNotification"
}

struct StoryboardIDs {
    
    static let peopleViewController:String = "PeopleViewController"
    static let webViewController:String = "mNetWebViewController"
    static let dateFilterViewController:String = "DateFilterViewController"
    static let blockedUsersViewController:String = "BlockedUsersViewController"
    static let aboutMeViewController:String = "AboutMeViewController"
    static let resetPasswordViewController:String = "ResetPasswordViewController"
    static let privacySetingsViewController:String = "PrivacySettingsViewController"
    static let appSettingsViewController:String = "AppSettingsViewController"
    static let emailPreferencesViewController:String = "EmailPreferencesViewController"
    static let profileViewController:String = "ProfileViewController"
    static let selectUsersViewController:String = "SelectUserViewController"
    static let conversationDetailViewController:String = "ConversationDetailViewController"
    static let conversationInfoViewController:String = "ConversationInfoViewController"
    static let newConversationViewController:String = "NewConversationViewController"
    static let imageDocViewController:String = "ImageDocDisplayViewController"
    static let infoPopoverViewController:String = "InfoPopoverViewControllerID"
    static let approvalVerificationViewController:String = "ApprovalVerificationViewController"
    static let rejectViewController:String = "RejectApplicationViewController"
    static let approvalDetailsViewController:String = "DocumentViewController"
    static let documentDetailsViewController:String = "DocumentDetailsViewController"
    static let attachmentsViewController:String = "AttachmentsViewController"
}

struct ImageNames {
    
    static let checkBox:String = "checkedBox"
    static let unCheckBox:String = "uncheckedBox"
    static let starFilled:String = "star_filled"
    static let starEmpty:String = "star_empty"
}

struct ConstantStrings {
    
    static let appName:String = "mNet"
    static let approve:String = "APPROVE"
    static let verify:String = "VERIFY"
    static let sendFor:String = "SEND FOR"
    static let approval:String = "APPROVAL"
    static let verification:String = "VERIFICATION"
}

extension UIStoryboard {
    
    static let dashboard:UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
    static let conversations:UIStoryboard = UIStoryboard(name: "Conversation", bundle: nil)
    static let settings:UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
    static let notifications:UIStoryboard = UIStoryboard(name: "Notifications", bundle: nil)
    static let profile:UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
    static let tabBar:UIStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
    static let login:UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
    static let dateSelector:UIStoryboard = UIStoryboard(name: "DateSelector", bundle: nil)
    static let webView:UIStoryboard = UIStoryboard(name: "WebView", bundle: nil)
    static let approvals:UIStoryboard = UIStoryboard(name: "ApproveReject", bundle: nil)
}

extension UIFont {
    
    static func boldAppFont(fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SanFranciscoDisplay-Bold", size: fontSize)!
    }
    
    static func semiBoldAppFont(fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SanFranciscoDisplay-Semibold", size: fontSize)!
    }
    
    static func mediumAppFont(fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SanFranciscoDisplay-Medium", size: fontSize)!
    }
    
    static func regularAppFont(fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SanFranciscoDisplay-Regular", size: fontSize)!
    }
    
    static func lightAppFont(fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SanFranciscoDisplay-Light", size: fontSize)!
    }
}

extension UIImage {
    
   static let imageDownloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .fifo,
        maximumActiveDownloads: 4,
        imageCache: AutoPurgingImageCache()
    )
}

extension URLRequest
{
    static func getRequest(_ urlString:String?) -> URLRequest?
    {
        if let urlstring = urlString
        {
            guard let url:URL = URL(string: urlstring)
            else{
                return nil
            }
            
            let urlRequest:URLRequest =  URLRequest(url: url)

            return urlRequest
        }
        else
        {
            let urlRequest:URLRequest = URLRequest.init(url: URL.init(string:"")!)
           return urlRequest
        }
    }
}

enum ResultError: Error {
    case InvalidFormat
}

