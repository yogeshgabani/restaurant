//
//  forgetpwdViewController.swift
//  Restaurant
//
//  Created by MACOS on 7/19/17.
//  Copyright © 2017 king. All rights reserved.
//

import UIKit

let REGEX_MAIL = "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

class forgetpwdViewController: UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    var arry : [Any] = [];
    @IBOutlet var emailreset: TextFieldValidator!
    @IBOutlet var lbl: UILabel!
   
    @IBOutlet var view3: UIView!
    @IBOutlet var reset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl.isHidden = true;
        validate();
        resetdec()
        viewdec()


        // Do any additional setup after loading the view.
    }
    
    func validate() {
        
        emailreset.addRegx(REGEX_MAIL, withMsg: "Enter valid email to reset password");
        emailreset.presentInView = self.view;
        
    }
    
//reset password
    @IBAction func resetpaswd(_ sender: Any) {
        
        if emailreset.validate()
        {
            forgot();
            print("success")
        }
        else
        {
            var alert = UIAlertView(title: "Alert", message: "enter your email id", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            print("invalid email id");
            print("unsuccess")
        }
        
    }

// get password function
    
    func forgot() {
        
            let url = URL(string: "http://localhost/restaurants/forgot.php");
            
            let strbody = "email=\(emailreset.text!)";
            
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
                            self.arry.append(item["password"] as! String);
                        }
                        
                        if self.arry.count == 1
                        {
                            //self.lbl.isHidden = false;
                           self.lbl.text = String(describing: self.arry[0]);
                            let alert = UIAlertView(title: "Your password is", message: "\(self.lbl.text!)", delegate: self, cancelButtonTitle: "OK");
                            alert.show();
                          //  let p = self.storyboard?.instantiateViewController(withIdentifier: "1")
                          //  self.navigationController?.popViewController(animated: true)
                        }
                        else
                        {
                            var alert = UIAlertView(title: "Unsuccess", message: "Enter valid email id", delegate: self, cancelButtonTitle: "OK")
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
    func resetdec()
    {
        reset.layer.shadowColor = UIColor.black.cgColor
        reset.layer.shadowOffset = CGSize(width: 0, height: 0)
        reset.layer.shadowOpacity = 0.5
        reset.layer.shadowRadius = 10
        reset.layer.borderColor = UIColor.red.cgColor
        reset.layer.borderWidth = 2.5;
        reset.clipsToBounds = true;
        reset.layer.masksToBounds = false;
        reset.layer.cornerRadius = 18;
        
    }
    
    func viewdec()
    {
        view3.layer.cornerRadius = 8
        view3.clipsToBounds = true
        view3.layer.shadowColor = UIColor.black.cgColor
        view3.layer.shadowOffset = CGSize(width: 0, height: 0)
        view3.layer.shadowOpacity = 0.5
        view3.layer.shadowRadius = 10
        view3.layer.masksToBounds = false
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
