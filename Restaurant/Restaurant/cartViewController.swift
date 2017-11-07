//
//  cartViewController.swift
//  Restaurant
//
//  Created by TOPS on 10/2/17.
//  Copyright © 2017 king. All rights reserved.
//

import UIKit

class cartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var total : Int = 0;
    var price1: String = "";
    var sed: String = "";
    var prid : String = "";
    
    var finalprdt : [Any] = []
    var cartdel :[Any] = []
    
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var tbl1: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        cartdel = []
        display()

        // Do any additional setup after loading the view.
    }
    
    func display()
    {
        
        
        let url = URL(string: "http://localhost/restaurants/cartdisplay.php")
        let dif = UserDefaults();
        
        let userid = dif.value(forKey: "user");
        
        
        let strbody = "user_id=\(userid!)"
        
        print(strbody);
        
        
        let length = strbody.characters.count;
        
        var request = URLRequest(url: url!);
        request.addValue(String(length), forHTTPHeaderField: "Content-Length");
        request.httpBody  = strbody.data(using: String.Encoding.utf8);
        request.httpMethod = "POST";
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: {(data1,response, error ) in
            
            let str = String(data: data1!, encoding: String.Encoding.utf8)
            
            print(str!)
            
            DispatchQueue.main.async {
                do {
                    
                    let arr = try JSONSerialization.jsonObject(with: data1!, options: []) as! [[String:Any]]
                    
                    for item in arr
                    {
                        
                        
                        let t1 =  Int(item["price"] as! String);
                        print(t1 ?? "ok")
                        self.total = self.total + t1!;
                        
                        self.finalprdt.append(item)
                        self.cartdel = []
                        self.cartdel.append(item["cid"]!)
                    }
                    print(self.finalprdt)
                    self.tbl1.reloadData()
                    self.lbl.text = "Total                                                     ₹ \(self.total) ";
                    
                    
                    
                    
                }
                catch{}
            }
            
            
        })
        task.resume()
        
    }
    
// delete item in cart
    
    func deletprdt(sender:UIButton)
    {
        
        
        let url = URL(string: "http://localhost/restaurants/cartdelete.php")
        
        let de = cartdel[0]
        let strbody = "cid=\(de)"
        print(de)
        print(strbody);
        
        
        let length = strbody.characters.count;
        
        var request = URLRequest(url: url!);
        request.addValue(String(length), forHTTPHeaderField: "Content-Length");
        request.httpBody  = strbody.data(using: String.Encoding.utf8);
        request.httpMethod = "POST";
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: {(data1,response, error ) in
            
            let str = String(data: data1!, encoding: String.Encoding.utf8)
            
            print(str!)
            
            DispatchQueue.main.async {
                do {
                    
                    let arr = try JSONSerialization.jsonObject(with: data1!, options: []) as! [[String:Any]]
                    
                    for item in arr
                    {
                        
                        
                        let t1 =  Int(item["cid"] as! String);
                        print(t1 ?? "ok")
                     //   self.total = self.total + t1!;
                        
                        self.prid.append(item["cid"] as! String)
                        
                    }
                    print(self.prid)
                    self.tbl1.reloadData()
                      self.display()
               //     self.lbl.text = "Total                                                     ₹ \(self.total) ";
                    
                   
                    
                    
                }
                   
                catch{}
            }
            
            
        })
        task.resume()
        
    }   
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalprdt.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cartp;
        
        let dic = finalprdt[indexPath.row] as![String:String];
        var urlimg = "http://localhost/restaurants/"
        
        urlimg.append(dic["prodimage"]!)
        
        let url2 = URL(string: urlimg)
        
        do {
            
            let dt = try Data(contentsOf: url2!)
            
            cell.img.image = UIImage(data: dt)
            cell.lbl1.text = dic["prodname"];
            cell.lbl2.text = dic["size"];
            cell.lbl3.text = dic["price"];
            
        } catch  {
            
        }
       
        
        cell.delcart.addTarget(self, action: #selector(self.deletprdt), for:.touchUpInside)
    
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       let abc =  finalprdt.remove(at: indexPath.row)
      //  prid.append(abc) as! String;
        
   //  cartdelete()
        
    tbl1.reloadData()
    }
    
    
// delete product function
  /*  func  deletprdt(sender:UIButton)
    {
        
        
    }
*/
    @IBAction func placeorder(_ sender: Any) {
        
        
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


class  cartp: UITableViewCell {
    
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var delcart: UIButton!
}
