//
//  PersonInfoViewController.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/4/23.
//

import Foundation
import UIKit
import SnapKit

class PersonInfoViewController: UIViewController {
    
    lazy private var personView = makePersonInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(personView)
        
        personView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - 工厂方法
extension PersonInfoViewController {
    private func makePersonInfoView() -> PersonInfoView {
        let view = PersonInfoView()
        return view
    }
}
