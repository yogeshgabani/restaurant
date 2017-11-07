//
//  signupViewController.swift
//  Restaurant
//
//  Created by MACOS on 7/12/17.
//  Copyright © 2017 king. All rights reserved.
//

import UIKit
let REGEX_NAME_LIMIT = "^.{5,25}$"
let REGEX_NAME = "[A-Za-z ]{5,25}"
let REGEX_USER_LIMIT = "^.{3,10}$"
let REGEX_USER = "[A-Za-z0-9_]{3,10}"
let REGEX_EMAILID = "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
let REGEX_PASSWOR_LIMIT = "^.{6,20}$"
let REGEX_PASSWOR = "[A-Za-z0-9]{6,20}"
let REGEX_PHONE = "[0-9]{10}"

class signupViewController: UIViewController,UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

   // var gendr = ["male", "female"];
    
    @IBOutlet var img: UIImageView!
    @IBOutlet var name: TextFieldValidator!
    @IBOutlet var email: TextFieldValidator!
    @IBOutlet var user: TextFieldValidator!
    @IBOutlet var mobile: TextFieldValidator!
    @IBOutlet var gender: TextFieldValidator!
    @IBOutlet var password: TextFieldValidator!
    
    @IBOutlet var view2: UIView!
    @IBOutlet var sign: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setvalidator();
        signdec();
        viewdec();
        // Do any additional setup after loading the view.
    }
    
    func setvalidator() {
        
        name.addRegx(REGEX_NAME, withMsg: "enter your name between 5 to 50 char");
        name.presentInView = self.view;
        email.addRegx(REGEX_EMAIL, withMsg: "enter valid email");
        email.presentInView = self.view;
        user.addRegx(REGEX_USER, withMsg: "userlimit 3 to 10 char");
        user.presentInView = self.view;
        mobile.addRegx(REGEX_PHONE, withMsg: "enter valid 10 digit mobile number");
        mobile.presentInView = self.view;
        password.addRegx(REGEX_PASSWOR, withMsg: "pasword limit 6 to 10 char");
        password.presentInView = self.view;
    }
//signup button
    @IBAction func signup(_ sender: Any) {
     
        if name.validate() && email.validate() && user.validate() && mobile.validate() && gender.validate() && password.validate()  {
           
            validate();
            
            let p = self.storyboard?.instantiateViewController(withIdentifier: "1")
            self.navigationController?.popViewController(animated: true)
            let alert = UIAlertView(title: "Success", message: "Registered Successfull", delegate: self, cancelButtonTitle: "OK")
             alert.show()
            print("Registered successfully");
        }
        else
        {
            let alert = UIAlertView(title: "Alert", message: "Please Fill All The Fields", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            print("invalid");
        }
        
    }
    
    func validate(){
        
        
        let str = "http://localhost/restaurants/signup.php?name=\(name.text!)&email=\(email.text!)&user=\(user.text!)&mob=\(mobile.text!)&gender=\(gender.text!)&pass=\(password.text!)";
        
        let str1 =  str.addingPercentEscapes(using: String.Encoding.utf8);
        
        let url = URL(string: str1!);
        
        
    
        let request = URLRequest(url: url!);
        let session = URLSession.shared;
        let task = session.dataTask(with: request, completionHandler: {(data1, responce, err) in
            
            
            let str = String(data: data1!, encoding: String.Encoding.utf8)
            
            print(str);
            
        })
        
        
        task.resume();
        
    }
/*
// gender picker code
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 3 {
            
            let alert = UIAlertController(title: "Gender", message: "Select Your Gender", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            alert.addAction(UIAlertAction(title: "Male", style: UIAlertActionStyle.default, handler: {action in
                
                textField.text = "Male"
            }))
            
            alert.addAction(UIAlertAction(title: "Female", style: UIAlertActionStyle.default, handler: {action in
                
                textField.text = "Female"
            }))
            
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.cancel, handler: {action in
                
                textField.text = ""
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        return false        
    }
     */
//button style
    func signdec()
    {
        sign.layer.shadowColor = UIColor.black.cgColor
        sign.layer.shadowOffset = CGSize(width: 0, height: 0)
        sign.layer.shadowOpacity = 0.5
        sign.layer.shadowRadius = 10
        sign.layer.borderColor = UIColor.red.cgColor
        sign.layer.borderWidth = 2.5;
        sign.clipsToBounds = true;
        sign.layer.masksToBounds = false;
        sign.layer.cornerRadius = 18;
        
    }
    
    func viewdec()
    {
        view2.layer.cornerRadius = 15
        view2.clipsToBounds = true
        view2.layer.shadowColor = UIColor.black.cgColor
        view2.layer.shadowOffset = CGSize(width: 0, height: 0)
        view2.layer.shadowOpacity = 0.4
        view2.layer.shadowRadius = 25
        view2.layer.masksToBounds = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
