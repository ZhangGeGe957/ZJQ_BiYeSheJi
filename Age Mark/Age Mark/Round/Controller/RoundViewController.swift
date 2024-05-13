//
//  RoundViewController.swift
//  Age Mark
//
//  Created by 王璐 on 2023/6/13.
//

import UIKit
import SnapKit

class RoundViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {

    private var segmentedControl: UISegmentedControl! = nil
    lazy private var addContentButton: UIButton = makeAddContentButton()
    private var backgroundScrollView: UIScrollView!
    
    // tableViewController
    private var recommendTableView = UITableView()
    private var focusOnTableView = UITableView()
    private var nearbyTableView = UITableView()
    
    private var detailsPage: DetailsPageViewController = DetailsPageViewController() // 详情页
    
    // Model
    private let roundModel = RoundModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTopView()
        setupBackgroundScrollView()
        setupTableView()
    }
    
    
    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tableViewInfo = Array<MonumentsInfo>()
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            tableViewInfo = roundModel.recommendInfo
        case 1:
            tableViewInfo = roundModel.focusOnInfo
        case 2:
            tableViewInfo = roundModel.nearbyInfo
        default:
            tableViewInfo = roundModel.recommendInfo
        }
        
        return tableViewInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoundCell", for: indexPath) as! RoundTableViewCell
        
        var tableViewInfo = Array<MonumentsInfo>()
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            tableViewInfo = roundModel.recommendInfo
        case 1:
            tableViewInfo = roundModel.focusOnInfo
        case 2:
            tableViewInfo = roundModel.nearbyInfo
        default:
            tableViewInfo = roundModel.recommendInfo
        }
        
        // 图片
        if let imageName: String = tableViewInfo[indexPath.row].photoArray[0] as? String {
            cell.contentImageView.image = UIImage(named: imageName)
        } else {
            cell.contentImageView.image = UIImage(named: "placeholder_image")
        }

        // 用户信息
        cell.userContentView.userAvatarImage.image = UIImage(named: "Avatar")
        cell.userContentView.userNameLabel.text = "Uphold.957"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var tableViewInfo = Array<MonumentsInfo>()
        
        switch tableView.tag {
        case 0:
            tableViewInfo = roundModel.recommendInfo
        case 1:
            tableViewInfo = roundModel.focusOnInfo
        case 2:
            tableViewInfo = roundModel.nearbyInfo
        default:
            tableViewInfo = roundModel.recommendInfo
        }
        
        detailsPage.modalPresentationStyle = .custom
        detailsPage.transitioningDelegate = self
        detailsPage.itemInfo = tableViewInfo[indexPath.row]
        present(detailsPage, animated: true)
    }
    
    // 顶部选择器
    private func setupTopView() {
        segmentedControl = UISegmentedControl(items: roundModel.segmentedArray as? [Any])
        segmentedControl.selectedSegmentIndex = 0
        let normalTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 25),
            .foregroundColor: UIColor.black
        ]
        let selectedTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 26),
            .foregroundColor: UIColor.black
        ]
        
        segmentedControl.setTitleTextAttributes(normalTitleAttributes, for: UIControl.State.normal)
        segmentedControl.setTitleTextAttributes(selectedTitleAttributes, for: UIControl.State.selected)
        segmentedControl.setBackgroundImage(UIImage(named: "BackImage_Blank"), for: .normal, barMetrics: .default)
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        segmentedControl.tintColor = .clear
        segmentedControl.selectedSegmentTintColor = .clear
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(20 + DefaultData.shared().topSafeAreaHeight)
            make.height.equalTo(30)
        }
        
        view.addSubview(addContentButton)
        addContentButton.snp.makeConstraints { make in
            make.centerY.equalTo(segmentedControl)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(30)
        }
    }
    
    // 底层滚动视图
    private func setupBackgroundScrollView() {
        backgroundScrollView = UIScrollView(frame: CGRect(x: 0, y: DefaultData.shared().topSafeAreaHeight + 60, width: DefaultData.shared().screenWidth, height: DefaultData.shared().screenHeight - DefaultData.shared().topSafeAreaHeight - 60))
        backgroundScrollView.contentSize = CGSize(width: DefaultData.shared().screenWidth * CGFloat(roundModel.segmentedArray.count), height: DefaultData.shared().screenHeight - DefaultData.shared().topSafeAreaHeight - 60)
        backgroundScrollView.delegate = self
        backgroundScrollView.isPagingEnabled = true
        backgroundScrollView.showsHorizontalScrollIndicator = false
        view.addSubview(backgroundScrollView)
    }
    
    // tableView
    private func setupTableView() {
        
        recommendTableView = UITableView(frame: CGRect(x: 0, y: 0, width: DefaultData.shared().screenWidth, height: DefaultData.shared().screenHeight - DefaultData.shared().topSafeAreaHeight - 60), style: .plain)
        recommendTableView.tag = 0
        recommendTableView.delegate = self
        recommendTableView.dataSource = self
        recommendTableView.backgroundColor = .white
        backgroundScrollView.addSubview(recommendTableView)
        recommendTableView.register(RoundTableViewCell.self, forCellReuseIdentifier: "RoundCell")
        
        focusOnTableView = UITableView(frame: CGRect(x: DefaultData.shared().screenWidth, y: 0, width: DefaultData.shared().screenWidth, height: DefaultData.shared().screenHeight - DefaultData.shared().topSafeAreaHeight - 60), style: .plain)
        focusOnTableView.tag = 1
        focusOnTableView.delegate = self
        focusOnTableView.dataSource = self
        focusOnTableView.backgroundColor = .white
        backgroundScrollView.addSubview(focusOnTableView)
        focusOnTableView.register(RoundTableViewCell.self, forCellReuseIdentifier: "RoundCell")
        
        nearbyTableView = UITableView(frame: CGRect(x: DefaultData.shared().screenWidth * 2, y: 0, width: DefaultData.shared().screenWidth, height: DefaultData.shared().screenHeight - DefaultData.shared().topSafeAreaHeight - 60), style: .plain)
        nearbyTableView.tag = 2
        nearbyTableView.delegate = self
        nearbyTableView.dataSource = self
        nearbyTableView.backgroundColor = .white
        backgroundScrollView.addSubview(nearbyTableView)
        nearbyTableView.register(RoundTableViewCell.self, forCellReuseIdentifier: "RoundCell")
    }
    
    // MARK: ScrollView
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let currentIndex = segmentedControl.selectedSegmentIndex
        segmentedControl.selectedSegmentIndex = Int(scrollView.contentOffset.x / DefaultData.shared().screenWidth)
        if currentIndex != segmentedControl.selectedSegmentIndex {
            reloadAllTableView()
        }
    }
    
    // 刷新tableView
    private func reloadAllTableView() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            recommendTableView.reloadData()
        case 1:
            focusOnTableView.reloadData()
        case 2:
            nearbyTableView.reloadData()
        default:
            recommendTableView.reloadData()
        }
    }
}

// MARK: - 点击事件
extension RoundViewController {
    @objc
    private func segmentedControlValueChanged() {
        backgroundScrollView.setContentOffset(CGPoint(x: Int(DefaultData.shared().screenWidth) * segmentedControl.selectedSegmentIndex, y: 0), animated: true)
        
        reloadAllTableView()
    }
    
    @objc
    private func clickAddContentButton() {
        print("click")
    }
}

// MARK: - 工厂方法
extension RoundViewController {
    private func makeAddContentButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Round_AddContent_Button"), for: .normal)
        button.addTarget(self, action: #selector(clickAddContentButton), for: .touchUpInside)
        return button
    }
}
