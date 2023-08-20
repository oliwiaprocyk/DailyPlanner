//
//  MainTableViewCell.swift
//  DailyPlanner
//
//  Created by Oliwia Procyk on 30/07/2023.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    static let reuseID = "MainTableViewCell"
    
    private let backView: View = {
        let bgView = View()
        bgView.backgroundColor = .systemGray5
        bgView.layer.borderColor = UIColor.systemOrange.cgColor
        return bgView
    }()
    
    let categoryName = Label(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(backView)
        backView.addSubview(categoryName)
        backView.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        categoryName.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
    }
}
