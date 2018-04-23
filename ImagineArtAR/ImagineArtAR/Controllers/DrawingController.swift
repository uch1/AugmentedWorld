//
//  DrawingController.swift
//  ImagineArtAR
//
//  Created by Uchenna  Aguocha on 4/21/18.
//  Copyright © 2018 Uchenna  Aguocha. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit

protocol DrawingPaletteDelegate {
    
}

class DrawingController: UIViewController {
    
    // MARK: UIComponents
    var sceneView: ARSCNView = {
        let sv = ARSCNView()
        sv.backgroundColor = UIColor.blue
        return sv
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(handleAdd), for: .touchDragInside)
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(handleResetSession), for: .touchDragInside)
        return button
    }()
    
    // Track the position of your device relative to world around it
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSceneView()
    }
    
    // MARK: Methods
    
    func setupSceneView() {
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
        
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        
        view.addSubview(sceneView)
        sceneView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(addButton)
        addButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: 80, height: 80)
        
        view.addSubview(resetButton)
        resetButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 20, width: 80, height: 80)
    }
    
    func randomNumber(firstNumber: CGFloat, secondNumber: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNumber - secondNumber) + min(firstNumber, secondNumber)
    }
    
    // MARK: ObjC Methods
    
    @objc func handleAdd() {
        
        let planeNode = SCNNode(geometry: SCNPlane(width: 0.3, height: 0.3))
        planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        planeNode.position = SCNVector3(0,0,-0.3)
        planeNode.eulerAngles = SCNVector3(0,90.degreesToRadians,0)
        
        sceneView.scene.rootNode.addChildNode(planeNode)
        
//        let pyramidNode = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
//        pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        pyramidNode.position = SCNVector3(0,0,-0.3)
//        pyramidNode.eulerAngles = SCNVector3(Float(90.degreesToRadians),0,0)
//
//        sceneView.scene.rootNode.addChildNode(pyramidNode)
        
//        let node = SCNNode()
//        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
//        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        node.position = SCNVector3(0.2,0.3,-0.2)
//
//        let cylinderNode  = SCNNode()
//        cylinderNode.geometry = SCNCylinder(radius: 0.1, height: 0.3)
//        cylinderNode.geometry?.firstMaterial?.specular.contents = UIColor.red
//        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
//        cylinderNode.position = SCNVector3(-0.1,0.5,-0.5)
//
//        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
//        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//        boxNode.geometry?.firstMaterial?.specular.contents = UIColor.white
//        boxNode.position = SCNVector3(0,-0.05,0)
//
//        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
//        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
//        doorNode.position = SCNVector3(0,-0.02,0.053)
//
//        node.addChildNode(boxNode)
//        boxNode.addChildNode(doorNode)
//        sceneView.scene.rootNode.addChildNode(node)
        //sceneView.scene.rootNode.addChildNode(cylinderNode)
    }
    
    @objc func handleResetSession() {
        /* Remove the existing node from the root node
         , reset tracking, & remove anchors
         */
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

extension Int {
    var degreesToRadians: Float {
        return Float(Double(self) * .pi / 180)
    }
}





















