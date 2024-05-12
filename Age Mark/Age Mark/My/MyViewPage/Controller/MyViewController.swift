//
//  MyViewController.swift
//  Age Mark
//
//  Created by zjq on 2023/6/13.
//

import UIKit
import SnapKit

class MyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {
    
    // 获取屏幕的宽和高
    private let Width = DefaultData.shared().screenWidth
    private let Height = DefaultData.shared().screenHeight
    private let topSafeAreaHeight = DefaultData.shared().topSafeAreaHeight
    
    // Model
    private let myTableViewModel = MyTableViewModel()
    private let userInfo = UserInfoModel()
    
    private var myTableView : UITableView!
    lazy private var topView = makeTopView()
    
    let imagePicker = UIImagePickerController() // 相册

    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationController?.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topSafeAreaHeight)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        myTableView = UITableView(frame: CGRectZero, style: .grouped)
        myTableView.separatorStyle = .none
        myTableView.backgroundColor = UIColor.white
        myTableView.delegate = self
        myTableView.dataSource = self
        view.addSubview(self.myTableView)
        myTableView.snp.updateConstraints({ make in
            make.top.equalTo(topView.snp_bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        myTableView.register(MyTableViewDefaultCell.self, forCellReuseIdentifier: "Default")
        myTableView.register(MyTableViewPersonCell.self, forCellReuseIdentifier: "Person")
        
        imagePicker.delegate = self
    }
    
    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let myTableViewPersonCell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath) as? MyTableViewPersonCell
            myTableViewPersonCell?.selectionStyle = .none // 取消选中
            // 头像
            if let avatarImage = userInfo.avatarImage {
                myTableViewPersonCell?.avatarImageView.image = avatarImage
            } else {
                myTableViewPersonCell?.avatarImageView.image = UIImage(named: "Avatar")
            }
            // 头像点击事件
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarImageViewTapped))
            myTableViewPersonCell?.avatarImageView.addGestureRecognizer(tapGesture)
            // 用户信息
            myTableViewPersonCell?.personNameLabel.text = userInfo.userName
            myTableViewPersonCell?.personSignLabel.text = userInfo.userSign
            // 编辑点击事件
            myTableViewPersonCell?.editButton.addTarget(self, action: #selector(pushPersonalInformationEditingPage), for: .touchUpInside)
            return myTableViewPersonCell!
        } else {
            let myTableViewDefaultCell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath) as? MyTableViewDefaultCell
            // 取消选中
            myTableViewDefaultCell?.selectionStyle = .none
            // 图片
            let photoModelArray = self.myTableViewModel.photoModelArrayWithSection(section: indexPath.section)
            myTableViewDefaultCell?.iconImageView.image = UIImage(named: photoModelArray[indexPath.row] as! String)
            // 内容
            let modelArray = self.myTableViewModel.modelArrayWithSection(section: indexPath.section)
            let contentString = modelArray[indexPath.row] as? String
            myTableViewDefaultCell?.contentLabel.text = contentString
            // 右侧功能按钮
            myTableViewDefaultCell?.rightFuncItem(rightView: contentString == "消息提醒" ? .switchView : .arrowView)
            return myTableViewDefaultCell!
        }
    }
    
    // 组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4;
    }
    
    // 每组cell数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return self.myTableViewModel.modelArrayWithSection(section: section).count
        }
    }
    
    // cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 120
        } else {
            return 50
        }
    }
    
    // 头视图高度
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        } else {
            let headerView = MyTableViewSectionHeader()
            headerView.titleLabel.text = myTableViewModel.sectionNameArray[section] as? String
            return headerView
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 50
        }
    }
    
    // 脚视图高度
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        } else {
            return MyTableViewSectionFooter()
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 40
        }
    }
    
    // 选中cell后执行此方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectCell = tableView.cellForRow(at: indexPath) as? MyTableViewDefaultCell
        
        switch indexPath.section {
        case 0:
            return
        case 1:
            switch indexPath.row {
            case 0:
                let viewController = PersonInfoViewController()
                self.present(viewController, animated: true)
            default:
                showWarningAlert()
            }
        case 2:
            break
        case 3:
            switch indexPath.row {
            case 0:
                showGoogleMail()
            case 2:
                let viewController = MySettingPageViewController()
                self.present(viewController, animated: true)
            default:
                showWarningAlert()
            }
        default:
            showWarningAlert()
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
    // UIImagePickerControllerDelegate 方法 - 用户选择了图片后调用
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userInfo.avatarImage = pickedImage
            // 获取tableView对应列，刷新对应列
            let indexPath = IndexPath(row: 0, section: 0)
            myTableView.reloadRows(at: [indexPath], with: .none)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    // UIImagePickerControllerDelegate 方法 - 用户取消选择图片后调用
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIViewControllerTransitioningDelegate 转场动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideRightToLeftAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideLeftToRightAnimator()
    }
}

// MARK: - 点击事件
extension MyViewController {
    @objc
    private func avatarImageViewTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc
    private func pushPersonalInformationEditingPage() {
        let personalInfoEditView = PersonalInfoEditingPage()
        personalInfoEditView.modalPresentationStyle = .custom
        personalInfoEditView.transitioningDelegate = self
        personalInfoEditView.sureButtonCallBack = { [weak self] (editInfo: EditItemInfo) in
            guard let strongSelf = self else { return }
            strongSelf.userInfo.userName = editInfo.itemName
            strongSelf.userInfo.userSign = editInfo.itemDescribe
            // 获取tableView对应列，刷新对应列
            let indexPath = IndexPath(row: 0, section: 0)
            strongSelf.myTableView.reloadRows(at: [indexPath], with: .none)
        }
        present(personalInfoEditView, animated: true)
    }
    
    @objc
    private func showWarningAlert() {
        let alertController = UIAlertController(title: "提示", message: "敬请期待！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc
    private func showGoogleMail() {
        let alertController = UIAlertController(title: "提示", message: "请联系邮箱：zhangjiaqiaoedc@gmail.com", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension MyViewController {
    private func makeTopView() -> MyTopView {
        let view = MyTopView()
        return view
    }
}
