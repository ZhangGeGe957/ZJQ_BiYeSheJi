//
//  ARModelView.swift
//  Age Mark
//
//  Created by 张佳乔 on 2023/6/20.
//

import UIKit
import ARKit
import SceneKit
import RealityKit

class ARModelView: UIView, ARSCNViewDelegate {
    
    // AR模型
    lazy private var ARSceneView: SCNView = makeARSceneView()
    // 背景图
    lazy public var backgroundImageView: UIImageView = makeBackgroundImageView()
    // 数据
    private let screenWidth: CGFloat = DefaultData.shared().screenWidth
    private let screenHeight: CGFloat = DefaultData.shared().screenHeight
    public var ARName: String = "" {
        didSet {
            guard let usdzURL = Bundle.main.url(forResource: ARName, withExtension: "usdz") else { return }
            let scene = try! SCNScene(url: usdzURL, options: nil)
            
            ARSceneView.backgroundColor = UIColor.clear
            ARSceneView.accessibilityViewIsModal = false // 标识用户界面元素是否具有模态行为
            ARSceneView.isUserInteractionEnabled = true // 启用交互
            
            ARSceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 确定视图的自动调整行为
            
            ARSceneView.scene = scene // 设置AR模型
            
            let lightNode = SCNNode()
            lightNode.light = SCNLight()
            lightNode.light?.type = .directional
            lightNode.position = SCNVector3(x: 0, y: 0, z: 0)
            scene.rootNode.addChildNode(lightNode)
            
            ARSceneView.allowsCameraControl = true
            ARSceneView.showsStatistics = true
        }
    }
    
    // 相机AR
    lazy private var ARCameraView: ARSCNView = makeARCameraSCNView()
    lazy private var coachingOverlay: ARCoachingOverlayView = makeARCoachingOverlayView()
    lazy private var session: ARSession = makeARSession()
    lazy private var ARConfiguration: ARWorldTrackingConfiguration = makeARWorldTrackingConfiguration()
    private var isModelAdded = false // 用于跟踪模型是否已添加的标记
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        // 设置UI
        setupUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置UI
    private func setupUI() {
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(ARSceneView)
        ARSceneView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(backgroundImageView)
            make.width.equalTo(screenWidth)
            make.height.equalTo(screenHeight)
        }
        
        ARCameraView.session = session
        addSubview(ARCameraView)
        ARCameraView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        coachingOverlay.session = session
        ARCameraView.addSubview(coachingOverlay)
        coachingOverlay.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        session.run(ARConfiguration)
    }
    
    func createPlaneNode(anchor: ARPlaneAnchor) -> SCNNode {
        // 使用检测到的平面的尺寸创建平面几何图形
        let planeGeometry = SCNPlane(width: 0.5, height: 0.5)
        
        // 设置平面几何体的材质为透明
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white.withAlphaComponent(0.5)
        planeGeometry.materials = [material]
        
        // 使用平面几何创建平面节点
        let planeNode = SCNNode(geometry: planeGeometry)
        
        // 将平面节点的位置设置为检测到的平面的中心
        planeNode.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        
        return planeNode
    }
    
    func addARModel(to parentNode: SCNNode) {
        // 加载AR模型
        guard let usdzURL = Bundle.main.url(forResource: ARName, withExtension: "usdz") else { return }
        let modelScene = try! SCNScene(url: usdzURL, options: nil)
        // 从加载的场景创建一个节点
        let modelNode = modelScene.rootNode.clone()
        
        // 缩小模型节点
        let scale: CGFloat = 0.1 // 根据需要调整比例因子
        modelNode.scale = SCNVector3(scale, scale, scale)
        
        // 将模型节点放置在检测到的平面顶部
        modelNode.position = SCNVector3(0, 0, 0) // 根据需要调整高度
        
        // 将模型节点添加到父节点
        parentNode.addChildNode(modelNode)
    }
    
}

// MARK: - Public
extension ARModelView {
    
    public func loadARModel() {
        
        self.ARSceneView.isHidden = true
        
        self.ARCameraView.isHidden = false
        
        ARCameraView.session.run(ARConfiguration) // 启动 AR 会话
    }
    
    public func loadObjectModel() {
        
        self.ARSceneView.isHidden = false
        
        self.ARCameraView.isHidden = true
        
        self.backgroundImageView.image = UIImage(named: "ARModel_BackgroundImage")
        
        ARCameraView.session.pause() // 暂停 AR 会话
        
        isModelAdded = false
    }
    
}

// MARK: - ARSessionDelegate
extension ARModelView: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        // 处理新检测到的锚点（平面）
        for anchor in anchors {
            if let planeAnchor = anchor as? ARPlaneAnchor {
                // 检测到新的水平面
                
                if isModelAdded {
                    return
                }
                
                // 创建一个代表检测到的平面的新节点
                let planeNode = createPlaneNode(anchor: planeAnchor)
                                
                // 将平面节点添加到场景中
                ARCameraView.scene.rootNode.addChildNode(planeNode)
                                
                // 添加AR模型
                addARModel(to: planeNode)
                
                // 将标志设置为 true 以防止添加多个模型
                isModelAdded = true
            }
        }
    }
}

// MARK: - 工厂方法
extension ARModelView {
    
    private func makeBackgroundImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ARModel_BackgroundImage")
        imageView.isUserInteractionEnabled = true
        return imageView
    }
    
    // 展示AR模型
    private func makeARSceneView() -> SCNView {
        guard let usdzURL = Bundle.main.url(forResource: ARName, withExtension: "usdz") else { return SCNView() }
        let scene = try! SCNScene(url: usdzURL, options: nil)
        
        let ARView = SCNView()
        ARView.backgroundColor = UIColor.clear
        ARView.accessibilityViewIsModal = false // 标识用户界面元素是否具有模态行为
        ARView.isUserInteractionEnabled = true // 启用交互
        
        ARView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 确定视图的自动调整行为
        
        ARView.scene = scene // 设置AR模型
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .directional
        lightNode.position = SCNVector3(x: 0, y: 0, z: 0)
        scene.rootNode.addChildNode(lightNode)
        
        ARView.allowsCameraControl = true
        ARView.showsStatistics = true
        
        return ARView
    }

    private func makeARCameraSCNView() -> ARSCNView {
        let arView = ARSCNView()
        arView.isHidden = true
        arView.showsStatistics = true
        arView.automaticallyUpdatesLighting = true
        return arView
    }
    
    private func makeARCoachingOverlayView() -> ARCoachingOverlayView {
        let arCoachingOverlayView = ARCoachingOverlayView()
        arCoachingOverlayView.isHidden = true
        arCoachingOverlayView.goal = .horizontalPlane // 设置目标为水平面检测
        arCoachingOverlayView.activatesAutomatically = true // 自动激活
        return arCoachingOverlayView
    }
    
    private func makeARSession() -> ARSession {
        let session = ARSession()
        session.delegate = self
        return session
    }
    
    private func makeARWorldTrackingConfiguration() -> ARWorldTrackingConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal] // 启用水平面检测
        return configuration
    }
}
