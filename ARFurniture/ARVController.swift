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

class ARVController: UIViewController {

    
    @IBOutlet weak var addObjectBtn: UIButton!
    @IBOutlet weak var ARSceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ARSceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints] //ARSCNDebugOptions.showWorldOrigin]
        self.ARSceneView.session.run(configuration)
        self.ARSceneView.autoenablesDefaultLighting = true
        //addObjectBtn.layer.cornerRadius = addObjectBtn.bounds.width / 2
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addObjectBtnPressed(_ sender: Any) {
        let node = SCNNode()
        node.geometry = SCNPyramid(width: 0.1, height: 0.2, length: 0.1)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        node.position = SCNVector3(0,0,-0.5)
        self.ARSceneView.scene.rootNode.addChildNode(node)
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
