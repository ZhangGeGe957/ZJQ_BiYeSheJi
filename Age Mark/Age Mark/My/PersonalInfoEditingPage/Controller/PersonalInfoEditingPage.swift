//
//  PersonalInfoEditingPage.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/1/29.
//

import UIKit
import SnapKit

class PersonalInfoEditingPage: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    lazy private var topView = makeTopView()
    lazy private var sureButton = makeSureButton()
    lazy private var editInfoTableView = makeEditInfoTableView()
    private var editViewModel = PersonInfoEditViewModel()
    private var editEndInfo: EditItemInfo = EditItemInfo() // block要回传的EditItemInfo数据
    public var sureButtonCallBack: ((EditItemInfo) -> Void)? // block回传数据
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let endEditTapGesture = UITapGestureRecognizer(target: self, action: #selector(retractKeyboard))
        view.addGestureRecognizer(endEditTapGesture)
        
        setupUI()
        
        editInfoTableView.register(BaseTableViewCell.self, forCellReuseIdentifier: BaseTableViewCellString)
    }
    
    private func setupUI() {
        view.addSubview(topView)
        topView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(DefaultData.shared().statusBarHeight)
            make.left.equalToSuperview()
            make.width.equalTo(DefaultData.shared().screenWidth)
        })
        
        topView.addSubview(sureButton)
        sureButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(88)
            make.height.equalTo(39)
        }
        
        editInfoTableView.delegate = self
        editInfoTableView.dataSource = self
        view.addSubview(editInfoTableView)
        editInfoTableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp_bottom)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - TableViewDelegate
extension PersonalInfoEditingPage {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editViewModel.tableViewCellNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableViewCellString, for: indexPath) as! BaseTableViewCell
        
        let inputView = makeInputCellView()
        inputView.iconImageView.image = UIImage(named: editViewModel.itemInfo[indexPath.row].imageName)
        inputView.nameLabel.text = editViewModel.itemInfo[indexPath.row].itemName
        // 输入框
        inputView.inputTextField.placeholder = editViewModel.itemInfo[indexPath.row].itemDescribe
        inputView.inputTextField.delegate = self
        inputView.inputTextField.tag = indexPath.row
        
        cell.baseView.addSubview(inputView)
        inputView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return cell
    }
    
    // cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - TextFieldDelegate
extension PersonalInfoEditingPage {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            editEndInfo.itemName = textField.text ?? ""
        case 1:
            editEndInfo.itemDescribe = textField.text ?? ""
        default:
            return
        }
    }
}

extension PersonalInfoEditingPage {
    @objc
    private func clickBackButton() {
        dismiss(animated: true)
    }
    
    @objc
    private func clickSureButton() {
        if sureButtonCallBack != nil {
            sureButtonCallBack!(editEndInfo)
        }
        dismiss(animated: true)
    }
    
    @objc
    private func retractKeyboard() {
        view.endEditing(true)
    }
}

extension PersonalInfoEditingPage {
    private func makeTopView() -> ZJQTopView {
        let view = ZJQTopView()
        view.backButton.addTarget(self, action: #selector(clickBackButton), for: .touchUpInside)
        view.titleLabel.text = "编辑个人信息"
        return view
    }
    
    private func makeSureButton() -> UIButton {
        let button = UIButton()
        button.setTitle("确定", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(UIImage(named: "ARModel_Button_BackgroundImageView"), for: .normal)
        button.addTarget(self, action: #selector(clickSureButton), for: .touchUpInside)
        return button
    }
    
    private func makeEditInfoTableView() -> UITableView {
        let tableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }
    
    private func makeInputCellView() -> PersonInfoEditingView {
        let inputView = PersonInfoEditingView()
        return inputView
    }
}

