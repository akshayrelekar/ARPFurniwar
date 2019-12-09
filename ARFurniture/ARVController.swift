//
//  ARVController.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 12/8/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARVController: UIViewController,ARSCNViewDelegate,ARSessionDelegate {

         @IBOutlet weak var addObjectBtn: UIButton!
         @IBOutlet weak var ARSceneView: ARSCNView!
         @IBOutlet weak var infoLabel: UILabel!
     
      var touchPoint : CGPoint?
      var configuration = ARWorldTrackingConfiguration()
      var prodimgname:String?
       
      override func viewDidLoad() {
        super.viewDidLoad()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.isLightEstimationEnabled = true
        self.ARSceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.ARSceneView.session.run(configuration)
        self.ARSceneView.autoenablesDefaultLighting = true
        self.ARSceneView.automaticallyUpdatesLighting = true
    //    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ARVController.tapped(tapGesture:)))
    //    view.addGestureRecognizer(tapGesture)
        //addObjectBtn.layer.cornerRadius = addObjectBtn.bounds.width / 2
         
        
        print("Image Name \(prodimgname!)")
      }
    //  @objc func tapped(tapGesture: UITapGestureRecognizer){
    //
    //    let touchPosition = tapGesture.location(in: ARSceneView)
    //
    //    touchPoint = tapGesture.location(in: self.view)
    //    print(“Touch coordinates: (\(touchPoint!.x),\(touchPoint!.y))“)
    //    guard let sofaScene = SCNScene(named: “Barstool.scn”), let sofaNode = sofaScene.rootNode.childNode(withName: “Barstool”, recursively: true) else {
    //      print(“not found”)
    //      return
    //    }
    //    sofaNode.position = SCNVector3(0, -0.5, -0.6)
    //    self.ARSceneView.scene.rootNode.addChildNode(sofaNode)
    //
    //  }
       
      @IBAction func addObjectBtnPressed(_ sender: Any) {
    //    let node = SCNNode()
    //    node.geometry = SCNPyramid(width: 0.1, height: 0.2, length: 0.1)
    //    node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
    //    node.geometry?.firstMaterial?.specular.contents = UIColor.white
    //    node.position = SCNVector3(0,0,-0.5)
    //    self.ARSceneView.scene.rootNode.addChildNode(node)
        guard let sofaScene = SCNScene(named: "\(prodimgname!).scn"), let sofaNode = sofaScene.rootNode.childNode(withName: "\(prodimgname!)", recursively: true) else {
          print("not found")
          return
        }
        sofaNode.position = SCNVector3(1, -0.5, -0.6)
        self.ARSceneView.scene.rootNode.addChildNode(sofaNode)
      }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
