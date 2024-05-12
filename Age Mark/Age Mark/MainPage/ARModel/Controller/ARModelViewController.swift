//
//  ARModelViewController.swift
//  Age Mark
//
//  Created by 张佳乔 on 2023/6/20.
//

import UIKit
import AVFoundation

class ARModelViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    // 顶部视图
    lazy var topView: ARTopChangeModelView = makeTopView()
    // AR模型视图
    lazy var ARView: ARModelView = makeARView()
    
    var ARName: String = "" {
        didSet {
            ARView.ARName = self.ARName 
        }
    }
    
    // AVCaptureSession是用于管理实时视频流的对象
    var captureSession: AVCaptureSession?
    
    // AVCaptureVideoPreviewLayer用于在视图中呈现相机捕捉的实时视频
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI
        setupUI()
        
        setupCamera()
    }
    
    // 设置UI
    private func setupUI() {
        view.addSubview(ARView)
        ARView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(65)
        }
    }
    
    private func setupCamera() {
        // 初始化captureSession
        captureSession = AVCaptureSession()

        // 设置捕捉设备为后置摄像头
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Unable to access back camera")
            return
        }

        do {
            // 创建一个AVCaptureDeviceInput对象，并将其添加到captureSession中
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession?.addInput(input)
        } catch {
            print("Error creating AVCaptureDeviceInput: \(error.localizedDescription)")
            return
        }

        // 创建一个AVCaptureVideoPreviewLayer对象，并将其添加到视图的layer中
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.frame = self.ARView.bounds
        self.ARView.layer.addSublayer(previewLayer!)

        // 初始化AVCaptureVideoDataOutput并将其添加到captureSession中
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession?.addOutput(videoOutput)
    }
    
    // AVCaptureVideoDataOutputSampleBufferDelegate方法，当新的视频帧可用时被调用
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // 在这里处理实时视频帧，例如将其显示在视图上
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let uiImage = UIImage(ciImage: ciImage, scale: 1, orientation: .right)

        // 在主线程上更新UI
        DispatchQueue.main.async {
            // 将捕捉到的图像显示在视图上
            // imageView.image = uiImage
            // 此处假设你有一个名为imageView的UIImageView来显示图像
            self.ARView.backgroundImageView.image = uiImage
        }
    }
}

// MARK: - 工厂方法
extension ARModelViewController {
    private func makeARView() -> ARModelView {
        let ARView = ARModelView()
        return ARView
    }
    
    private func makeTopView() -> ARTopChangeModelView {
        let view = ARTopChangeModelView()
        view.backButtonCallBack = { [weak self] in
            self?.dismiss(animated: true)
        }
        view.tabButtonCallBack = { [weak self] (isAR) in
            if isAR {
                DispatchQueue.main.async {
                    self?.captureSession?.startRunning()
                    self?.ARView.loadARModel()
                }
            } else {
                DispatchQueue.main.async {
                    self?.captureSession?.stopRunning()
                    self?.ARView.loadObjectModel()
                }
            }
        }
        view.shareButtonCallBack = { [weak self] in
            
        }
        return view
    }
}
