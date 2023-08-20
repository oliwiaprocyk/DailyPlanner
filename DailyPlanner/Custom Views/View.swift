//
//  View.swift
//  DailyPlanner
//
//  Created by Oliwia Procyk on 19/08/2023.
//

import UIKit

final class View: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 16
        layer.borderWidth = 2
    }
}
