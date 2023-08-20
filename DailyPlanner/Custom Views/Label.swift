//
//  Label.swift
//  DailyPlanner
//
//  Created by Oliwia Procyk on 19/08/2023.
//

import UIKit

final class Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textColor = .black
        numberOfLines = 3
    }
}
