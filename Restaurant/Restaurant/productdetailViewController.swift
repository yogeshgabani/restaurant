//
//  productdetailViewController.swift
//  Restaurant
//
//  Created by MACOS on 8/14/17.
//  Copyright © 2017 king. All rights reserved.
//

import UIKit

class productdetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    var pr  = "";
    var brr1 :String = "";
    var brr2 :String = "";
    var brr3 :String = "";
    var finalarr3 :[Any] = [];
    var desc : [Any] = []
    var spec : [Any] = []
    var buycrt : [Any] = []
    var prdtid : [Any] = []
    var size = "";
    var price = "";

    @IBOutlet weak var tblprod: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        admindata()
        cartbutton()
        print(brr1)
        print(brr2)
        print(brr3)

        // Do any additional setup after loading the view.
    }
    
    // view product name
    
    func admindata() {
        
        finalarr3  = [];
        
        let url = URL(string: "http://localhost/restaurants/displayproduct.php");
        
        let strbody = "Id=\(brr3)";
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
                        var temp : [String] = [];
                        temp.append(item["prodname"] as! String);
                        temp.append(item["prodimage"] as! String)
                        temp.append(item["prodid"] as! String);
                        temp.append(item["prod_disc"] as! String);
                        temp.append(item["price"] as! String)
                        temp.append(item["size"] as! String);
                        self.finalarr3.append(temp);
                        self.prdtid.append(temp[2])
                        
                        
                    }
                    print(self.finalarr3);
                    self.tblprod.reloadData();
                    
                }
                catch {
                    
                }
            }
        })
        task.resume();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
        return finalarr3.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell6", for: indexPath) as! custcell4;
        let temp = finalarr3[indexPath.row] as! [String];
        var urlimg = "http://localhost/restaurants/";
        urlimg.append(temp[1]);
        
        let url12 = URL(string: urlimg);
        do {
            let dt = try Data(contentsOf: url12!)
    
            cell.img4.image = UIImage(data: dt)
        
        } catch  {
    
        }
        
        cell.lbls.text = temp[0]
        cell.txtdesc.text = temp[3]
         pr = temp[4] 
        let sg = temp[5]
        let test = sg.components(separatedBy: ",")
        let seg = UISegmentedControl(items: test)
        seg.frame = CGRect(x: 20, y: 260, width: 320, height: 30)
        seg.tintColor = UIColor.purple
        let test1 = pr.components(separatedBy: ",")
        seg.selectedSegmentIndex = .allZeros;
        cell.lbl1.text = "₹ " + test1[0]
            size = "Regular"
            price = test1[0]
        cell.addSubview(seg)
        seg.addTarget(self, action: #selector(self.handle), for: .valueChanged)
        
        return cell
       }
        
        else {
            
            
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "buycell", for: indexPath) as! buy
            
            cell3.cart.addTarget(self, action: #selector(self.carthandle), for:.touchUpInside)
            cell3.buynow.addTarget(self, action: #selector(self.buyhandle), for: .touchUpInside)
            
            
            return cell3
        }
    }
    
    func handle(sender: UISegmentedControl) {
        
        
        
        
        
        let indexpath = IndexPath(row: 0, section: 0)
        
        
        let cell = tblprod .cellForRow(at: indexpath)  as! custcell4
        
        let test1 = pr.components(separatedBy: ",")
        
        if sender.selectedSegmentIndex == 0 {
            cell.lbl1.text = "₹ " + test1[0]
            size = "regular"
            price = test1[0];
            
            
            
        }
        else if sender.selectedSegmentIndex == 1 {
            cell.lbl1.text = "₹ " + test1[1]
            
            size = "Medium"
            price = test1[1];
        }
        else  {
            cell.lbl1.text = "₹ " + test1[2]

            size = "Large"
            price = test1[2];
        }
        
    }
    
    func  carthandle(sender:UIButton)
    {
        
        let url1 = URL(string: "http://localhost/restaurants/cart.php")
        
        
        let dif = UserDefaults();
        
        let userid = dif.value(forKey: "user");
        print(userid)
        
        let strbody = "id=\(prdtid[0])&user_id=\(userid!)&size=\(size)&price=\(price)"
        
        let length = strbody.characters.count;
        
        
        
        var request1 = URLRequest(url: url1!);
        request1.addValue(String(length), forHTTPHeaderField: "Content-Length");
        request1.httpBody  = strbody.data(using: String.Encoding.utf8);
        request1.httpMethod = "POST";
        
        let session1 = URLSession.shared
        
        let task1 = session1.dataTask(with: request1, completionHandler: {(data3,response, error ) in
            
            let str1 = String(data: data3!, encoding: String.Encoding.utf8)
            
            print(str1!)
            let alt = UIAlertController(title: "Confirmation", message: "Item added Successfully to Cart", preferredStyle: .alert);
            
            let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
                
                
                self.navigationController?.popViewController(animated: true);
                
                
            });
            
            alt.addAction(ok);
            
            
            self.present(alt, animated: true, completion: nil);
            
        })
        task1.resume()
        
        
        
        
    }
    func buyhandle(sender:UIButton)
    {
        
        
    }

  
// cart button add in tab bar
    func cartbutton()
    {
        
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(self.barbtn), for: .touchUpInside)
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btn.setImage(UIImage(named: "images1.jpg" ), for: .normal)
        
        let baritem = UIBarButtonItem(customView: btn)
        
        
        self.navigationItem.rightBarButtonItem = baritem
        
    }
    func barbtn(sender:UIButton)
    {
        
        
        let pc = self.storyboard?.instantiateViewController(withIdentifier: "7") as! cartViewController
        
        
        
        self.navigationController?.pushViewController(pc, animated: true)
        
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


class custcell4: UITableViewCell {
    
    
    @IBOutlet var img4: UIImageView!
    
    @IBOutlet weak var lbls: UILabel!
    @IBOutlet weak var txtdesc: UITextView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var buybtn: UIButton!
    @IBOutlet weak var addcartbtn: UIButton!
}

class buy: UITableViewCell {
    
    @IBOutlet weak var buynow: UIButton!
    @IBOutlet weak var cart: UIButton!
}





