//
//  productViewController.swift
//  Restaurant
//
//  Created by MACOS on 8/10/17.
//  Copyright © 2017 king. All rights reserved.
//

import UIKit

class productViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var brr1 :String = "";
    var brr2 :String = "";
    var finalarr2 :[Any] = [];

    @IBOutlet var coll3: UICollectionView!
    @IBOutlet var lbl4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        admindata()
        logindec()
        cartbutton()
        lbl4.text = brr2;

        // Do any additional setup after loading the view.
    }
    
//view product detail
    
    func admindata() {
        
        finalarr2  = [];
        let url = URL(string: "http://localhost/restaurants/viewproduct.php");
        
        let strbody = "Id=\(brr1)";
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
                        self.finalarr2.append(temp);
                    }
                    print(self.finalarr2);
                    self.coll3.reloadData();
                    
                }
                catch {
                    
                }
            }
        })
        task.resume();
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return finalarr2.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! custcell3;
        let temp = finalarr2[indexPath.row] as! [String];
        
        cell.lbl3.text = temp[0] ;
        var urlimg = "http://localhost/restaurants/";
        urlimg.append(temp[1]);
        let url12 = URL(string: urlimg);
        
        do {
            
            let dt = try Data(contentsOf: url12!)
            
            cell.img3.image = UIImage(data: dt)
            
        } catch  {
            
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pc = self.storyboard?.instantiateViewController(withIdentifier: "6") as! productdetailViewController;
        let temp = finalarr2[indexPath.row] as! [String];
        pc.brr1 = temp[0];
        pc.brr2 = temp[1];
        pc.brr3 = temp[2];
        self.navigationController?.pushViewController(pc, animated: true);
    }
    
//label style
    func logindec()
    {
        lbl4.layer.shadowColor = UIColor.black.cgColor
        lbl4.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl4.layer.shadowOpacity = 0.5
        lbl4.layer.shadowRadius = 10
        lbl4.layer.borderColor = UIColor.brown.cgColor
        lbl4.layer.borderWidth = 2.5;
        lbl4.clipsToBounds = true;
        lbl4.layer.masksToBounds = false;
        lbl4.layer.cornerRadius = 18;
        
    }
    
// cart button in toolbar
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

class custcell3: UICollectionViewCell {
    
    
    @IBOutlet var img3: UIImageView!
    
    @IBOutlet var lbl3: UILabel!
}
