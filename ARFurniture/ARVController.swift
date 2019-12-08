//
//  ARVController.swift
//  ARFurniture
//
//  Created by Akshay Relekar on 12/3/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARVController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    
    @IBOutlet weak var addObjectBtn: UIButton!
    @IBOutlet weak var ARSceneView: ARSCNView!
    var touchPoint : CGPoint?
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ARSceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.ARSceneView.session.run(configuration)
        self.ARSceneView.autoenablesDefaultLighting = true
        self.ARSceneView.automaticallyUpdatesLighting = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ARVController.tapped(tapGesture:)))
        view.addGestureRecognizer(tapGesture)
        //addObjectBtn.layer.cornerRadius = addObjectBtn.bounds.width / 2
        
    }
    
    @objc func tapped(tapGesture: UITapGestureRecognizer){
        
        let touchPosition = tapGesture.location(in: ARSceneView)
        
        touchPoint = tapGesture.location(in: self.view)
        print("Touch coordinates: (\(touchPoint!.x),\(touchPoint!.y))")
        guard let sofaScene = SCNScene(named: "Barstool.scn"), let sofaNode = sofaScene.rootNode.childNode(withName: "Barstool", recursively: true) else {
            print("not found")
            return
        }
        sofaNode.position = SCNVector3(0, -0.5, -0.6)
        self.ARSceneView.scene.rootNode.addChildNode(sofaNode)
        
    }
    
    @IBAction func addObjectBtnPressed(_ sender: Any) {
//        let node = SCNNode()
//        node.geometry = SCNPyramid(width: 0.1, height: 0.2, length: 0.1)
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//        node.geometry?.firstMaterial?.specular.contents = UIColor.white
//        node.position = SCNVector3(0,0,-0.5)
//        self.ARSceneView.scene.rootNode.addChildNode(node)
        
        guard let sofaScene = SCNScene(named: "stool2.scn"), let sofaNode = sofaScene.rootNode.childNode(withName: "stool2", recursively: true) else {
            print("not found")
            return
        }
        sofaNode.position = SCNVector3(1, -0.5, -0.6)
        self.ARSceneView.scene.rootNode.addChildNode(sofaNode)
    }
}
