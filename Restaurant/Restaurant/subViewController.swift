//
//  subViewController.swift
//  Restaurant
//
//  Created by MACOS on 8/10/17.
//  Copyright © 2017 king. All rights reserved.
//

import UIKit

class subViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var brr :String = "";
    var brr0 :String = "";
    var finalarr1 :[Any] = [];

    @IBOutlet var coll2: UICollectionView!
    @IBOutlet var lbl2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        admindata()
        logindec()
        cartbutton()
        lbl2.text = brr0;

        // Do any additional setup after loading the view.
    }
    
// get sub category data
    
// view sub category
    func admindata() {
        
        finalarr1  = [];
        let url = URL(string: "http://localhost/restaurants/viewsubcat.php");
        
        let strbody = "Id=\(brr)";
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
                        temp.append(item["subcatname"] as! String);
                        temp.append(item["subcatimage"] as! String)
                        temp.append(item["subid"] as! String);
                        self.finalarr1.append(temp);
                    }
                    print(self.finalarr1);
                    self.coll2.reloadData();
                    
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
        return finalarr1.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! custcell2;
        let temp = finalarr1[indexPath.row] as! [String];
        
        cell.lb2.text = temp[0] ;
        var urlimg = "http://localhost/restaurants/";
        urlimg.append(temp[1]);
        let url12 = URL(string: urlimg);
        
        do {
            
            let dt = try Data(contentsOf: url12!)
            
            cell.img2.image = UIImage(data: dt)
            
        } catch  {
            
        }
        
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pc = self.storyboard?.instantiateViewController(withIdentifier: "5") as! productViewController;
        let temp = finalarr1[indexPath.row] as! [String];
        pc.brr1 = temp[2];
        pc.brr2 = temp[0];
        self.navigationController?.pushViewController(pc, animated: true);
        
    }
    
//label style
    func logindec()
    {
        lbl2.layer.shadowColor = UIColor.black.cgColor
        lbl2.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl2.layer.shadowOpacity = 0.5
        lbl2.layer.shadowRadius = 10
        lbl2.layer.borderColor = UIColor.brown.cgColor
        lbl2.layer.borderWidth = 2.5;
        lbl2.clipsToBounds = true;
        lbl2.layer.masksToBounds = false;
        lbl2.layer.cornerRadius = 18;
        
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



class custcell2: UICollectionViewCell {
    
    
    @IBOutlet var img2: UIImageView!
    
    @IBOutlet var lb2: UILabel!
}
