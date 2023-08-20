//
//  Button.swift
//  DailyPlanner
//
//  Created by Oliwia Procyk on 19/08/2023.
//

import UIKit

final class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        setImage(UIImage(systemName: "plus.app"), for: .normal)
        tintColor = .black
    }
}
