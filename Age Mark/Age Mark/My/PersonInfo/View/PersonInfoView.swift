//
//  PersonInfoView.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/4/23.
//

import Foundation
import UIKit
import SnapKit

class PersonInfoView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    lazy private var tableView = makeTableView()
    private var viewModel = PersonInfoViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate
extension PersonInfoView {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PersonInfoTableViewCell
        cell?.selectionStyle = .none
        cell?.nameString = viewModel.nameArray[indexPath.row]
        cell?.contentString = viewModel.contentArray[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.nameArray.count
    }
}

extension PersonInfoView {
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(PersonInfoTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }
}
