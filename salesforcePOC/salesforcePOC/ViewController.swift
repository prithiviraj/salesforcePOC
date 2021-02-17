//
//  ViewController.swift
//  CanadaPOC
//
//  Created by CUBE84 on 14/02/21.
//

import UIKit
import Alamofire
import Foundation
import ObjectMapper

class ViewController: UIViewController {
    
    @IBOutlet weak var ambassdorTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true;
        
        let color = UIColor.black
        let placeholder = ambassdorTF.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        ambassdorTF.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
        
        RequestManager.getInstance.postLogin(username: K.LoginCreditionals.username, password: K.LoginCreditionals.password,grant_type:K.LoginCreditionals.grant_type,client_id:K.LoginCreditionals.client_id,client_secret:K.LoginCreditionals.client_secret, success: { (response) in
            if let res = response as? BaseResponse {
                self.handleTokenResponse(res: res)
            }
        }) { (error) in
            print("error:: \(error)")
        }
    }
    func handleTokenResponse(res: BaseResponse?) {
        print("access_token->\(res?.access_token ?? "")")
        token = res?.access_token ?? ""
        callPostCaseAPI()
        let alert = UIAlertController(title: "Token", message: res?.access_token ?? "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func callPostCaseAPI() {
        RequestManager.getInstance.postCase(Case_Type_District360__c: "Cleaning Request", Sub_type_District360__c: "Alley Cleaning", Status: "New", Priority: "Low", success: { (response) in
            if let res = response as? BaseResponse {
                print("res->\(res)")
            }
        }) { (error) in
            print("error:: \(error)")
        }
    }
}
