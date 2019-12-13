//
//  HomeVController.swift
//  ARFurniture
//
//  Created by Akshay Relekar on 12/2/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit

class HomeVController: UIViewController, iCarouselDelegate, iCarouselDataSource,UINavigationControllerDelegate {
    
    
      var userid:Int16?
    
   
    
    @IBOutlet weak var carouselView: iCarousel!
    var producti : UIImageView?
    var images : [UIImage] = [
        UIImage(named: "dog1.png")!,
        UIImage(named: "dog2.png")!,
        UIImage(named: "dog3.png")!,
        UIImage(named: "dog4.png")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carouselView.dataSource = self
        carouselView.reloadData()
        carouselView.type = .coverFlow
        
       
        
       
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tapped(tapGesture: UITapGestureRecognizer){
        print("Its done")
        let tappedImage = tapGesture.view as! UIImageView
        producti = tappedImage
        self.performSegue(withIdentifier: "productDetails", sender: self)
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return images.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignInController.tapped(tapGesture:)))
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        let frame = CGRect(x: 0, y: 0, width: 240, height: 240)
        var imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFit
        imageView.image = images[index]
        print("index: \(index)")
        tempView.addSubview(imageView)
        //producti = imageView
        imageView.addGestureRecognizer(tapGesture)
        
        return tempView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing{
            print(value)
            return value * 1.2
        }
        return value
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
         guard let iden = segue.identifier else {return}
                        if(iden == "productDetails" ){
                            if let vd = segue.destination as? ProductDetailsVController  {
                                vd.productphoto = producti!.image
                            }
                        }
    }
    

}
