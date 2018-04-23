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

class DrawingController: UIViewController {
    
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
    
    @objc func handleDraw() {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSceneView()
    }
    
    // MARK: Methods
    
    func setupSceneView() {
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
//        drawButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        drawButton.centerAnchor(centerX: view.centerXAnchor, centerY: nil)
        
    }
    
}






















