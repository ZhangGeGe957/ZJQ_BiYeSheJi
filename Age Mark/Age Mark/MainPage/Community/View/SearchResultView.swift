//
//  SearchResultView.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/2/28.
//

import UIKit
import SnapKit

class SearchResultView: UIView, UIViewControllerTransitioningDelegate {
    
    lazy private var resultTableView = makeResultTableView()
    
    public var clickResultNameBlock: ((String) -> Void)?
    
    public var resultArray: Array<MonumentsInfo> = [] {
        didSet {
            resultTableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(resultTableView)
        
        resultTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchResultView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! SearchResultCell
        cell.titleString = resultArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if clickResultNameBlock != nil {
            clickResultNameBlock?(resultArray[indexPath.row].name)
        }
    }
}

extension SearchResultView {
    private func makeResultTableView() -> UITableView {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: "ResultCell")
        return tableView
    }
}
