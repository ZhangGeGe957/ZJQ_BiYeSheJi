//
//  DetailsPageViewController.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2023/12/17.
//

import UIKit
import SnapKit

let BaseTableViewCellString = "BaseTableViewCell"

class DetailsPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Model
    var detailsViewModel: DetailsPageViewModel = DetailsPageViewModel()
    var itemInfo: MonumentsInfo? {
        didSet {
            topView.titleLabel.text = itemInfo?.name
            
            showImageView.photoArray = itemInfo?.photoArray
            ARModelController.ARName = itemInfo?.name ?? ""
            
            contentView.contentLabel?.text = itemInfo?.describe
            
            detailsTableView.reloadData()
        }
    }
    
    // TableView
    lazy var detailsTableView: UITableView = makeDetailsTableView()
    
    lazy var topView: ZJQTopView = makeTopView()
    lazy var showImageView: DetailsPageShowImageView = makeShowImageView()
    lazy var contentView: DetailsPageContentView = makeContentView()
    
    lazy var ARModelController: ARModelViewController = ARModelViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        
        detailsTableView.register(BaseTableViewCell.self, forCellReuseIdentifier: BaseTableViewCellString)
    }
    
    private func setupUI() {
        
    }
}

// MARK: - TableViewDelegate
extension DetailsPageViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsViewModel.tableViewSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableViewCellString, for: indexPath) as! BaseTableViewCell
        switch indexPath.row {
        case 0:
            cell.baseView.addSubview(showImageView)
            showImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            return cell
        case 1:
            cell.baseView.addSubview(contentView)
            contentView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            }
            return cell
        default:
            return cell
        }
    }
    
    // cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - 点击事件
extension DetailsPageViewController {
    // 返回按钮
    @objc 
    private func clickBackButton() {
        self.dismiss(animated: true)
    }
    
    // 推出AR
    @objc
    private func pushARView(_ sender: UITapGestureRecognizer) {
        ARModelController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        ARModelController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(ARModelController, animated: false)
    }
}

// MARK: - 工厂方法
extension DetailsPageViewController {
    private func makeTopView() -> ZJQTopView {
        let makeView = ZJQTopView(frame: CGRectZero)
        makeView.backButton.addTarget(self, action: #selector(clickBackButton), for: .touchUpInside)
        view.addSubview(makeView)
        makeView.snp.updateConstraints({ make in
            make.top.equalToSuperview().offset(DefaultData.shared().statusBarHeight)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
        })
        
        let ARButton = EnterARButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pushARView(_:)))
        ARButton.addGestureRecognizer(tapGesture)
        makeView.addSubview(ARButton)
        ARButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(88)
            make.height.equalTo(39)
        }
        return makeView
    }
    
    private func makeShowImageView() -> DetailsPageShowImageView {
        let makeView = DetailsPageShowImageView()
        return makeView
    }
    
    private func makeContentView() -> DetailsPageContentView {
        let makeView = DetailsPageContentView()
        return makeView
    }
    
    private func makeDetailsTableView() -> UITableView {
        let tableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp_bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp_bottom)
        }
        return tableView
    }
}
