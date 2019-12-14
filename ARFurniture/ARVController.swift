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
    @IBOutlet weak var infoLabel: UILabel!
    private var hud : MBProgressHUD!
    //let configuration = ARWorldTrackingConfiguration()
    var touchPoint : CGPoint?
    var object: SCNNode!
    var count = 1
    var currentAngleY: Float = 0.0
     var prodimgname:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ARSceneView.showsStatistics = true
        self.ARSceneView.autoenablesDefaultLighting = true
        self.ARSceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        let scene = ARSceneView.scene
        ARSceneView.delegate = self
        self.hud = MBProgressHUD.showAdded(to: self.ARSceneView, animated: true)
        self.hud.label.text = "Detecting Plane"
        registerGestureRecognizers()
        
         print("Image Name \(prodimgname!)")
    }
    
    func registerGestureRecognizers(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        //let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned))
        let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(panned))
        self.ARSceneView.addGestureRecognizer(tapGestureRecognizer)
        //self.ARSceneView.addGestureRecognizer(panGestureRecognizer)
        self.ARSceneView.addGestureRecognizer(rotateGestureRecognizer)
    }
    
    @objc func tapped(recognizer: UITapGestureRecognizer){
        
        guard let sceneView = recognizer.view as? ARSCNView else {return}
        let touch = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(touch, types: .existingPlane)
        
        if count == 1{
            if let hitTest = hitTestResults.first {
                let arscene = SCNScene(named: "\(prodimgname!).scn")
                guard let arnode = arscene?.rootNode.childNode(withName: "\(prodimgname!)", recursively: true) else {return}
                arnode.position = SCNVector3(hitTest.worldTransform.columns.3.x, hitTest.worldTransform.columns.3.y, hitTest.worldTransform.columns.3.z)
                self.ARSceneView.scene.rootNode.addChildNode(arnode)
                count += 1
            }
        }
    }
    
    @objc func panned(recognizer: UIRotationGestureRecognizer){
        recognizer.isEnabled = true
        if recognizer.state == .changed{
            guard let sceneView = recognizer.view as? ARSCNView else {return}
            let touch = recognizer.location(in: sceneView)
            let hitTestResults = sceneView.hitTest(touch, options: nil)
            if let hitTest = hitTestResults.first{
                let arnode = hitTest.node
                let rotation = Float(recognizer.rotation)
                //let translation = recognizer.translation(in: recognizer.view!)
                //var newAngleY = (Float)(translation.x)*(Float)(Double.pi)/180.0
                var newAngleY = currentAngleY + rotation
                //newAngleY += currentAngleY
                arnode.eulerAngles.y = newAngleY
                if(recognizer.state == .ended){
                    currentAngleY = newAngleY
                    //recognizer.isEnabled = false
                }
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }

            DispatchQueue.main.async {
                self.hud.animationType = .zoomOut
                self.hud.label.text = "Plane Detected"
                self.hud.hide(animated: true, afterDelay: 1.5)
            }
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
            self.hud.label.text = "Session was interrupted"
    }
     
    func sessionInterruptionEnded(_ session: ARSession) {
        self.hud.label.text = "Session interruption ended"
        resetTracking()
    }
 
    func session(_ session: ARSession, didFailWithError error: Error) {
        self.hud.label.text = "Session failed: \(error.localizedDescription)"
        resetTracking()
    }
 
     func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        ARSceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
     
    override func viewWillAppear(_ animated: Bool) {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        ARSceneView.session.run(configuration)
    }
}
