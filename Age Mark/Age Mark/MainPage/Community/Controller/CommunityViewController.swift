//
//  CommunityViewController.swift
//  Age Mark
//
//  Created by 张佳乔 on 2023/9/5.
//

import UIKit
import SnapKit

class CommunityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, WaterfallMutiSectionDelegate, UIViewControllerTransitioningDelegate {
    
    // Model
    private let communityModel = CommunityModel()
    
    // View
    private var communityCollectionView: UICollectionView! // CollectionView
    private var detailsPage: DetailsPageViewController = DetailsPageViewController() // 详情页
    lazy private var searchResultView = makeSearchResultView()
        
    private var keyboardShow: Bool = false // 标识键盘状态
    
    override func viewWillAppear(_ animated: Bool) {
        // 键盘状态通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        
        initCollectionView() // 初始化CollectionView
        
        setupUI()
        
        searchResultView.clickResultNameBlock = { [weak self] name in
            self?.detailsPage.modalPresentationStyle = .custom
            self?.detailsPage.transitioningDelegate = self
            self?.detailsPage.itemInfo = (self?.communityModel.itemInfo[name] as! MonumentsInfo)
            self?.present(self!.detailsPage, animated: true)
        }
    }
    
    private func setupUI() {
        communityCollectionView.addSubview(searchResultView)
    }
    
    private func showSearchView() {
        // 展示搜索页
        let searchIndexPath = IndexPath(row: 0, section: 1)
        let cell = self.communityCollectionView.cellForItem(at: searchIndexPath) as? CommunitySearchCell

        searchResultView.isHidden = false
        searchResultView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cell?.snp_bottom ?? 0)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(DefaultData.shared().screenHeight - (cell?.frame.height ?? 0))
        }
        
        var tempArray: Array<MonumentsInfo> = []
        for name in communityModel.itemNameArray {
            let nameString = name as? String
            let text: String = cell?.textField.text ?? ""
            if nameString?.contains(text) == true {
                tempArray.append(communityModel.itemInfo[nameString] as! MonumentsInfo)
            }
        }
        
        searchResultView.resultArray = tempArray
    }
    
    // MARK: - UICollectionDelegate
    // UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section == 0) {
            let WelcomeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Welcome", for: indexPath) as! CommunityWelcomeCell
            return WelcomeCell
        } else if (indexPath.section == 1) {
            let searchBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Search", for: indexPath) as! CommunitySearchCell
            searchBarCell.textField.delegate = self
            searchBarCell.closeButton.addTarget(self, action: #selector(clickCloseSearch), for: .touchUpInside)
            return searchBarCell
        } else {
            let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo", for: indexPath) as! CommunityPhotoCell
            let cellName = communityModel.itemNameArray[indexPath.row] as! String
            let cellInfo = communityModel.itemInfo[cellName] as? MonumentsInfo
            photoCell.photoImageView.image = UIImage(named: cellInfo!.photoArray[0])
            photoCell.itemName = cellName
            photoCell.titleLabel.text = cellName
            return photoCell
        }
    }
    
    // 点击Item响应
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 根据键盘状态：点击键盘之外收起键盘
        if keyboardShow {
            self.view?.endEditing(true)
            return
        }
        
        switch indexPath.section {
        case 2:
            if let cell = collectionView.cellForItem(at: indexPath) {
                let photoCell = cell as! CommunityPhotoCell
                detailsPage.modalPresentationStyle = .custom
                detailsPage.transitioningDelegate = self
                detailsPage.itemInfo = (communityModel.itemInfo[photoCell.itemName] as! MonumentsInfo)
                present(detailsPage, animated: true)
            }
        default:
            print(indexPath)
        }
    }
    
    // 获取分区数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    // 获取每个分区里单元格数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section <= 1 {
            return 1
        } else {
            return communityModel.itemInfo.count
        }
    }
    
    // MARK: - WaterfallMutiSectionLayoutDelegate
    // collectionItem高度
    func heightForRowAtIndexPath(collectionView collection: UICollectionView, layout: WaterfallMutiSectionFlowLayout, indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat {
        switch indexPath.section {
            case 0:
                return 100
            case 1:
                return 50
            default:
                return self.communityModel.photoHeightWithArray(indexPath.row)
        }
    }
    
    // 每个section 列数（默认2列）
    func columnNumber(collectionView collection: UICollectionView, layout: WaterfallMutiSectionFlowLayout, section: Int) -> Int {
        switch section {
            case 0:
                return 1
            case 1:
                return 1
            default:
                return 2
        }
    }
    
    // 每个section 边距（默认为0）
    func insetForSection(collectionView collection: UICollectionView, layout: WaterfallMutiSectionFlowLayout, section: Int) -> UIEdgeInsets {
        if (section == 0) {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else if (section == 1) {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    // header高度（默认为0）
    func referenceSizeForHeader(collectionView collection: UICollectionView, layout: WaterfallMutiSectionFlowLayout, section: Int) -> CGSize {
        if (section <= 1) {
            return CGSize(width: DefaultData.shared().screenWidth, height: 0)
        }  else {
            return CGSize(width: DefaultData.shared().screenWidth, height: 20)
        }
    }
    
    // footer高度（默认为0）
    func referenceSizeForFooter(collectionView collection: UICollectionView, layout: WaterfallMutiSectionFlowLayout, section: Int) -> CGSize {
        if (section <= 1) {
            return CGSize(width: DefaultData.shared().screenWidth, height: 0)
        }  else {
            return CGSize(width: DefaultData.shared().screenWidth, height: 20)
        }
    }
    
    // 每个section item上下间距（默认为0）
    func lineSpacing(collectionView collection: UICollectionView, layout: WaterfallMutiSectionFlowLayout, section: Int) -> CGFloat {
        if (section <= 1) {
            return 0
        }  else {
            return 20
        }
    }
    
    func interitemSpacing(collectionView collection: UICollectionView, layout: WaterfallMutiSectionFlowLayout, section: Int) -> CGFloat {
        if (section <= 1) {
            return 0
        }  else {
            return 20
        }
    }
    
    // MARK: - UITextField
    // TextField内容改变时调用
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("zhangjiaqiao: \(textField.text as Any)")
        
        if textField.text != "" {
            showSearchView()
        } else {
            searchResultView.isHidden = true
        }
    }
    
    // TextField开始编辑
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 将搜索框滚动到顶
        let searchIndexPath = IndexPath(row: 0, section: 1)
        let cell = self.communityCollectionView.cellForItem(at: searchIndexPath) as? CommunitySearchCell
        cell?.closeButton.isHidden = false // 展示清除搜索按钮
        self.communityCollectionView.scrollToItem(at: searchIndexPath, at: .top, animated: true)
        
        if textField.text != "" {
            showSearchView()
        }
    }
    
    // TextField结束编辑
    func textFieldDidEndEditing(_ textField: UITextField) {
        let searchIndexPath = IndexPath(row: 0, section: 1)
        let cell = self.communityCollectionView.cellForItem(at: searchIndexPath) as? CommunitySearchCell
        cell?.closeButton.isHidden = true // 隐藏清除搜索按钮
        // 恢复初始状态
        let indexPath = IndexPath(row: 0, section: 0)
        self.communityCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        // 隐藏搜索页
        searchResultView.isHidden = true
    }
    
    // MARK: - UIViewControllerTransitioningDelegate 转场动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideRightToLeftAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideLeftToRightAnimator()
    }
    
    // MARK: - UI Init
    // 初始化CollectionView
    private func initCollectionView() {
        // CollectionViewLayout
        let commuityCollectionViewLayout = WaterfallMutiSectionFlowLayout()
        commuityCollectionViewLayout.scrollDirection = .vertical // 竖向滑动
        commuityCollectionViewLayout.delegate = self
        
        // CollectionView
        self.communityCollectionView = UICollectionView(frame: CGRect(x: 0, y: DefaultData.shared().statusBarHeight, width: DefaultData.shared().screenWidth, height: DefaultData.shared().screenHeight - DefaultData.shared().statusBarHeight), collectionViewLayout: commuityCollectionViewLayout)
        // 注册
        self.communityCollectionView?.register(CommunityWelcomeCell.self, forCellWithReuseIdentifier: "Welcome")
        self.communityCollectionView?.register(CommunitySearchCell.self, forCellWithReuseIdentifier: "Search")
        self.communityCollectionView?.register(CommunityPhotoCell.self, forCellWithReuseIdentifier: "Photo")
        self.communityCollectionView.delegate = self
        self.communityCollectionView.dataSource = self
        communityCollectionView.backgroundColor = .white
        self.view.addSubview(self.communityCollectionView)
    }
}

// MARK: - 响应事件
extension CommunityViewController {
    @objc
    private func clickCloseSearch() {
        print("zhangjiaqiao:close")
        if keyboardShow {
            self.view?.endEditing(true)
        }
    }
    
    // 键盘状态通知
    @objc
    func keyboardWillShow(_ sender: Notification) {
        // 获取键盘的frame
        guard let keyboardFrame = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue else {
            return
        }
        keyboardShow = true // 改变键盘当前状态
    }

    @objc
    func keyboardWillHide(_ sender: Notification) {
        keyboardShow = false // 改变键盘当前状态
    }
}


// MARK: - 工厂方法
extension CommunityViewController {
    private func makeSearchResultView() -> SearchResultView {
        let view = SearchResultView(frame: CGRectZero)
        view.isHidden = true
        return view
    }
}
