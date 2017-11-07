//
//  homepage.swift
//  Restaurant
//
//  Created by MACOS on 7/12/17.
//  Copyright © 2017 king. All rights reserved.
//

import UIKit

class homepage: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate {

    var finalarr :[Any] = [];
   // let arr = ["burger1.jpg","dosa.jpg","sand.jpg","sab.jpg","piza.jpg","drinks.jpg","milk.jpg","ice.jpg","brounie.jpg","panjabi.jpg"];
   // let brr = ["burger","dhosa","sandwitch","subway","pizza","coke","milk sheck","ice-cream","brounie","panjabi"];

    @IBOutlet var coll: UICollectionView!
    @IBOutlet var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        admindata()
        cartbutton()
        img.animationImages = [UIImage(named: "GujaratiThali.jpg")!, UIImage(named: "panjabi.jpg")!, UIImage(named: "chhole.jpg")!, UIImage(named: "pizza.jpg")!, UIImage(named: "burger.jpg")!];
        img.animationDuration = 5.0;
        img.highlightedImage = UIImage(named: "burger.jpg");
        img.startAnimating();
        self.view.backgroundColor = UIColor.white;

        // Do any additional setup after loading the view.
    }
    
// get homepage data
    
    func admindata() {
        let url = URL(string: "http://localhost/restaurants/homepage.php");
        
        
        let request = URLRequest(url: url!);
        
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
                         temp.append(item["catename"] as! String);
                         temp.append(item["cateimage"] as! String);
                        temp.append(item["cateid"] as! String);
                        self.finalarr.append(temp);
                    }
                    print(self.finalarr);
                    self.coll.reloadData();
            
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
        // return arr.count;
        //  return brr.count;
        return finalarr.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! custcell;
        let temp = finalarr[indexPath.row] as! [String];
        
        cell.lbl.text = temp[0] ;
        var urlimg = "http://localhost/restaurants/";
        urlimg.append(temp[1]);
        let url12 = URL(string: urlimg);
        
        do {
            
            let dt = try Data(contentsOf: url12!)
            
            cell.img1.image = UIImage(data: dt)
            
        } catch  {
            
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pc = self.storyboard?.instantiateViewController(withIdentifier: "4") as! subViewController;
        let temp = finalarr[indexPath.row] as! [String];
        pc.brr = temp[2];
        pc.brr0 = temp[0];
        self.navigationController?.pushViewController(pc, animated: true);
        
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


class custcell: UICollectionViewCell {
    
    
    @IBOutlet var img1: UIImageView!
    
    @IBOutlet var lbl: UILabel!
}
