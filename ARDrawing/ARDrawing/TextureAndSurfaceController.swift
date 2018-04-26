//
//  TextureAndSurfaceController.swift
//  ARDrawing
//
//  Created by Uchenna  Aguocha on 4/24/18.
//  Copyright © 2018 Uchenna  Aguocha. All rights reserved.
//

import UIKit
import ARKit

class TextureAndSurfaceController: UIViewController {
    
    let configuration = ARWorldTrackingConfiguration()
    
    let sceneView: ARSCNView = {
        let sv = ARSCNView()
        return sv
    }()
    
    override func viewDidLoad() {
        setupSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "sun ")
        sun.position = SCNVector3(0,0,-1)
        sceneView.scene.rootNode.addChildNode(sun)
        
        
        let mercery = createPlanet(geometry: SCNSphere(radius: 0.2), position: SCNVector3(1.2,0,0), diffuse: #imageLiteral(resourceName: "earthDay"), specular: nil, normal: nil, emission: #imageLiteral(resourceName: "clouds "))
        sun.addChildNode(mercery)
        
        let venus = createPlanet(geometry: SCNSphere(radius: 0.2), position: SCNVector3(1.2,0,0), diffuse: #imageLiteral(resourceName: "earthDay"), specular: nil, normal: nil, emission: #imageLiteral(resourceName: "clouds "))
        sun.addChildNode(venus)
        
        let earth = createPlanet(geometry: SCNSphere(radius: 0.2), position: SCNVector3(1.2,0,0), diffuse: #imageLiteral(resourceName: "earthDay"), specular: nil, normal: nil, emission: #imageLiteral(resourceName: "clouds "))
        sun.addChildNode(earth)
        
        let mars = createPlanet(geometry: SCNSphere(radius: 0.2), position: SCNVector3(1.2,0,0), diffuse: #imageLiteral(resourceName: "earthDay"), specular: nil, normal: nil, emission: #imageLiteral(resourceName: "clouds "))
        sun.addChildNode(mars)
        
        let jupiter = createPlanet(geometry: SCNSphere(radius: 0.2), position: SCNVector3(1.2,0,0), diffuse: #imageLiteral(resourceName: "earthDay"), specular: nil, normal: nil, emission: #imageLiteral(resourceName: "clouds "))
        sun.addChildNode(jupiter)
        
        let saturn = createPlanet(geometry: SCNSphere(radius: 0.2), position: SCNVector3(1.2,0,0), diffuse: #imageLiteral(resourceName: "earthDay"), specular: nil, normal: nil, emission: #imageLiteral(resourceName: "clouds "))
        sun.addChildNode(saturn)
        
        let uranus = createPlanet(geometry: SCNSphere(radius: 0.2), position: SCNVector3(1.2,0,0), diffuse: #imageLiteral(resourceName: "earthDay"), specular: nil, normal: nil, emission: #imageLiteral(resourceName: "clouds "))
        sun.addChildNode(uranus)
        
        let neptune = createPlanet(geometry: SCNSphere(radius: 0.2), position: SCNVector3(1.2,0,0), diffuse: #imageLiteral(resourceName: "earthDay"), specular: nil, normal: nil, emission: #imageLiteral(resourceName: "clouds "))
        sun.addChildNode(neptune)
        
        
        
        
//        let earthNode = SCNNode()
//        earthNode.geometry = SCNSphere(radius: 0.2)
//        earthNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "earthDay")
//        earthNode.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "clouds ")
//        earthNode.position = SCNVector3(1.2,0,0)
//        sun.addChildNode(earthNode)
//
//        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadian), z: 0, duration: 8)
//        let foreverAction = SCNAction.repeatForever(action)
//        earthNode.runAction(foreverAction)
    }
    
    func createPlanet(geometry: SCNGeometry?, position: SCNVector3?, diffuse: UIImage?, specular: UIImage?, normal: UIImage?, emission: UIImage?) -> SCNNode {
        
        guard let geometry = geometry, let position = position, let diffuse = diffuse, let specular = specular, let normal = normal, let emission = emission else {
            let node = SCNNode()
            return node
        }
        
        let node = SCNNode(geometry: geometry)
        
        node.geometry?.firstMaterial?.diffuse.contents = diffuse
        node.geometry?.firstMaterial?.specular.contents = specular
        node.geometry?.firstMaterial?.normal.contents = normal
        node.geometry?.firstMaterial?.emission.contents = emission
        node.position = position
        
        return node
    }
    
    func setupSceneView() {
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.session.run(configuration)
        //sceneView.delegate = self
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        view.addSubview(sceneView)
        sceneView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
//
//func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
//    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
//}

extension Int {
    var degreesToRadian: Double {
        return Double(self) * .pi / 180
    }
}
