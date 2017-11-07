//
//  ViewController.swift
//  Restaurant
//
//  Created by MACOS on 7/11/17.
//  Copyright © 2017 king. All rights reserved.
//

import UIKit

let REGEX_USER_NAME_LIMIT = "^.{3,10}$"
let REGEX_USER_NAME = "[A-Za-z0-9_]{3,10}"
let REGEX_EMAIL = "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
let REGEX_PASSWORD_LIMIT = "^.{6,20}$"
let REGEX_PASSWORD = "[A-Za-z0-9]{6,20}"

class ViewController: UIViewController,UITextFieldDelegate {

   // let cmd = common();
    var finalarr : [Any] = []
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    @IBOutlet weak var imglogo: UIImageView!
    @IBOutlet var username: TextFieldValidator!
    @IBOutlet var password: TextFieldValidator!
    @IBOutlet var btnlgn: UIButton!
    @IBOutlet var view1: UIView!
    @IBOutlet var forgot: UIButton!
    @IBOutlet var signup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        validation();
        logindec();
        viewdec();
        forgotdec();
        signupdec();
        
        imglogo.layer.cornerRadius = self.imglogo.frame.size.width/2
        self.imglogo.clipsToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func validation() {
        
        username.addRegx(REGEX_USER_NAME, withMsg: "username limit 3 to 10 character");
        username.presentInView = self.view;
        password.addRegx(REGEX_PASSWORD, withMsg: "password limit 8 to 15 character");
        password.presentInView = self.view;
        
    }
//login button
    @IBAction func login(_ sender: Any) {
        
        if username.validate() && password.validate()
        {
            login();
            
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)) as UIActivityIndicatorView
            spinner.startAnimating();
      
        }
        else
        {
          //  let p = self.storyboard?.instantiateViewController(withIdentifier: "2") as! homepage;
          //  self.navigationController?.pushViewController(p, animated: true)
            let alert = UIAlertView(title: "Alert", message: "enter valid username and password", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            print("invalid password or username");
        }
        
        
    }
//signup button
    @IBAction func signup(_ sender: Any) {
        
        let p1 = self.storyboard?.instantiateViewController(withIdentifier: "1") as! signupViewController;
        self.navigationController?.pushViewController(p1, animated: true)
        
    }
//forgot password button
    @IBAction func forgotpassword(_ sender: Any) {
        
        let p2 = self.storyboard?.instantiateViewController(withIdentifier: "3") as! forgetpwdViewController
        self.navigationController?.pushViewController(p2, animated: true);
        
    }
    
// login function
    func login()
    
    {
        let url = URL(string: "http://localhost/restaurants/checklogin.php");
        
        let strbody = "user=\(username.text!)&password=\(password.text!)";
        
        let length = strbody.characters.count;
        
        
        var request = URLRequest(url: url!);
        request.addValue(String(length), forHTTPHeaderField: "Content-Length");
        request.httpBody  = strbody.data(using: String.Encoding.utf8);
        request.httpMethod = "POST";
        
        let session = URLSession.shared;
        
        let task = session.dataTask(with: request, completionHandler: {(data1, responce, err) in
            
            
            let str = String(data: data1!, encoding: String.Encoding.utf8);
            
            print(str!);
            
             DispatchQueue.main.async {
                
            do
            {
                let arr = try JSONSerialization.jsonObject(with: data1!, options: []) as! [[String: Any]];
                
                for item in arr
                {
                   // temp.append(item["username"] as! String);
                   // temp.append(item["password"] as! String);
                    self.finalarr.append(item);
                }
                if self.finalarr.count == 1
                {
                    print(self.finalarr)
                    let dif = UserDefaults();
                    let id = self.finalarr[0] as! [String: String];
                    
                    let id1 = id["sr_no"];
                    print(id1!)
                    
                    dif.set(id1, forKey: "user");
                    
                    let alert = UIAlertView(title: "Success", message: "Enjoy Your Food", delegate: self, cancelButtonTitle: "OK");
                    alert.show();
                    let p = self.storyboard?.instantiateViewController(withIdentifier: "2") as! homepage;
                    self.navigationController?.pushViewController(p, animated: true);
                }
                else
                {
                    let alert = UIAlertView(title: "Unsuccess", message: "invalid username or password", delegate: self, cancelButtonTitle: "OK")
                    alert.show();
 
                }
               // print(self.finalarr)
                
            }
            catch
            {
               //
                
            }
        }
    })
        
        
        task.resume();
        
    }
 //button style
    func logindec()
    {
        btnlgn.layer.shadowColor = UIColor.black.cgColor
        btnlgn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btnlgn.layer.shadowOpacity = 0.5
        btnlgn.layer.shadowRadius = 10
        btnlgn.layer.borderColor = UIColor.brown.cgColor
        btnlgn.layer.borderWidth = 2.5;
        btnlgn.clipsToBounds = true;
        btnlgn.layer.masksToBounds = false;
        btnlgn.layer.cornerRadius = 18;
        
    }
    
    func viewdec()
    {
        view1.layer.cornerRadius = 15
        view1.clipsToBounds = true
        view1.layer.shadowColor = UIColor.black.cgColor
        view1.layer.shadowOffset = CGSize(width: 0, height: 0)
        view1.layer.shadowOpacity = 0.4
        view1.layer.shadowRadius = 25
        view1.layer.masksToBounds = false
        
    }
    func forgotdec()
    {
        forgot.layer.shadowColor = UIColor.black.cgColor
        forgot.layer.shadowOffset = CGSize(width: 0, height: 0)
        forgot.layer.shadowOpacity = 0.5
        forgot.layer.shadowRadius = 10
        forgot.clipsToBounds = true;
        forgot.layer.masksToBounds = false;
        
    }
    func signupdec()
    {
        signup.layer.shadowColor = UIColor.black.cgColor
        signup.layer.shadowOffset = CGSize(width: 0, height: 0)
        signup.layer.shadowOpacity = 0.5
        signup.layer.shadowRadius = 10
        signup.layer.borderColor = UIColor.red.cgColor
        signup.layer.borderWidth = 2.5;
        signup.clipsToBounds = true;
        signup.layer.masksToBounds = false;
        signup.layer.cornerRadius = 18;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

