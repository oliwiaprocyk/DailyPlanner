//
//  ItemTablewViewCell.swift
//  DailyPlanner
//
//  Created by Oliwia Procyk on 16/08/2023.
//

import Foundation
import UIKit

final class ItemTableViewCell: UITableViewCell {
    static let reuseID = "ItemTableViewCell"
    
    private let backView: View = {
        let bgView = View()
        bgView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.1)
        bgView.layer.borderColor = UIColor.systemOrange.cgColor
        return bgView
    }()
    let itemName = Label(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(backView)
        backView.addSubview(itemName)
        backView.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        itemName.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
    }
}
