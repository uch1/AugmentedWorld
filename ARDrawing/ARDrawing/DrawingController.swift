//
//  DrawingController.swift
//  ARDrawing
//
//  Created by Uchenna  Aguocha on 4/22/18.
//  Copyright © 2018 Uchenna  Aguocha. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class DrawingController: UIViewController, ARSCNViewDelegate {
    
    // MARK: Properties
    let configuration = ARWorldTrackingConfiguration()

    
    // MARK: UIComponents
    var sceneView: ARSCNView = {
        let sv = ARSCNView()
        sv.backgroundColor = UIColor.blue
        return sv
    }()
    
    let drawButton: UIButton = {
        let button = UIButton()
        button.setTitle("Draw", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(handleDraw), for: .touchUpInside)
        return button
    }()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSceneView()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = sceneView.pointOfView else { return }
        
        let transform = pointOfView.transform
        let orientation = SCNVector3(transform.m31, transform.m32, transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        
        let currentPositionOfCamera = orientation + location
        //print(orientation.x, orientation.y, orientation.y)
        
        DispatchQueue.main.async {
            if self.drawButton.isHighlighted {
                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                sphereNode.position = currentPositionOfCamera
                self.sceneView.scene.rootNode.addChildNode(sphereNode)
                
                print("Draw button is being pressed")
            } else {
                
                let pointerNode = SCNNode(geometry: SCNSphere(radius: 0.01))
                pointerNode.name = "pointer"
                pointerNode.position = currentPositionOfCamera
                
                self.sceneView.scene.rootNode.enumerateHierarchy({ (node, _) in
                    if node.name == "pointer" {
                        node.removeFromParentNode()
                    }
                })
                
                self.sceneView.scene.rootNode.addChildNode(pointerNode)
                pointerNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            }
        }
        

    }
    
    
    
    func setupSceneView() {
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.session.run(configuration)
        sceneView.showsStatistics = true 
        sceneView.autoenablesDefaultLighting = true
        
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        
        view.addSubview(sceneView)
        sceneView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(drawButton)
        drawButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 65, height: 45)
        drawButton.centerAnchor(centerX: view.centerXAnchor, centerY: nil)
        
    }
    
    // MARK: Objc-Methods
    @objc func handleDraw() {
        
    }
    
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}




















