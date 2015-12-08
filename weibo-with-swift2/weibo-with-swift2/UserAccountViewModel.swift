//
//  UserAccountViewModel.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/8.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import Foundation

/**
*  usage for VM 
    1. Encapsulation the business logic
    2. Encapsulation the network codes
    3. Encapsulation the storage codes
    4. jst make get the VC out of the plenty of logic things. made it more clearly
*/
//KNOW for those mutable parameters stored in UserAccount -> file
//     for those immutable parameters everytime get them from the web

class UserAccountViewModel {
    //singleton
    static let sharedAccountViewModel = UserAccountViewModel()
    
    var userAccount: UserAccount?
    var userLogon: Bool {
        return userAccount != nil
    }
    var avatarUrl: NSURL {
        return NSURL(string: userAccount?.avatar_large ?? "")!
    }
    
    var accountPath: String {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        return (path as NSString).stringByAppendingPathComponent("account.plist")
    }
    
    init() {
        userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
        
        if let date = userAccount?.expiresDate {
            if date.compare(NSDate()) != NSComparisonResult.OrderedDescending {
                userAccount = nil
            }
        }
        
    }
    
    func loadAccessToken(code: String, finished: (error: NSError?)->()) {
        NetworkTools.sharedTools.loadAccessToken(code) { (result, error) -> () in
            if error != nil {
                finished(error: error)
                return
            }
            //sucessfuly get the UserAcount Model
            let account = UserAccount(dict: result as! [String: AnyObject] )
            self.userAccount = account
            self.LoadUserInfo(account, finished: finished)
            //store it to
        }
    }
    
    
    func LoadUserInfo(account: UserAccount, finished: (error: NSError?)->()) {
        NetworkTools.sharedTools.loadUserInfo(account.uid!) { (result, error) -> () in
            if error != nil{
                finished(error: error)
                return
            }
            
            guard let dict = result as? [String: AnyObject] else{
                finished(error: NSError(domain: "cn.doyere.error", code: 400, userInfo: ["message": "UserInfo result to dict failed"]))
                return
            }
            account.screen_name = dict["screen_name"] as? String
            account.avatar_large = dict["avatar_large"] as? String
            
            //KNOW save under the UserAccount method so it store it "self" archived to file
            // but use in init() just be a unarchive from file
            // so don't needs to be detailly assign the UserAccount memebers in the save or loadfile could be plenty of codes :(
            account.saveUserAccount()
            finished(error: nil)
        }
    }
    
}
