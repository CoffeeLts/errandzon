//
//  FacebookLogInViewController.swift
//  Errandzon
//
//  Created by lily on 2017/7/9.
//  Copyright © 2017年 Revolutionaries. All rights reserved.
//

import UIKit
import FBSDKLoginKit
class FacebookLogInViewController: UIViewController ,FBSDKLoginButtonDelegate{
        @IBOutlet weak var facebookLogInButton: FBSDKLoginButton!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            facebookLogInButton.readPermissions = ["public_profile", "email", "user_friends"]
            facebookLogInButton.delegate = self
            
            //第一次登入後可取得使用者token，後續即可直接登入
            if (FBSDKAccessToken.current()) != nil{
                fetchProfile()
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            FBSDKLoginManager().logOut()
        }
        
        func fetchProfile(){
            print("fetch profile")
            
            let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
            
            FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
                connection, result, error -> Void in
                
                
                if error != nil {
                    print("longinerror =(error)")
                    return
                } else {
                    
                    if let resultNew = result as? [String:Any]{
                        
                        let email = resultNew["email"]  as! String
                        print(email)
                        
                        let firstName = resultNew["first_name"] as! String
                        print(firstName)
                        
                        let lastName = resultNew["last_name"] as! String
                        print(lastName)
                        
                        if let picture = resultNew["picture"] as? NSDictionary,
                            let data = picture["data"] as? NSDictionary,
                            let url = data["url"] as? String {
                            print(url) //臉書大頭貼的url, 再放入imageView內秀出來
                        }
                    }
                    
                    
                }
            })
        }
        
        func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
            
            print("成功登入")
            fetchProfile()
            performSegue(withIdentifier: "setUserNameSegue", sender: loginButton)
            
        }
        
        func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
            
        }
        
        func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
            return true
        }
        

        
    }

