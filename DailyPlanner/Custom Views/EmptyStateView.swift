//
//  EmptyStateView.swift
//  DailyPlanner
//
//  Created by Oliwia Procyk on 19/08/2023.
//

import UIKit
import SnapKit

final class EmptyStateView: UIView {
    private let messageLabel: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 28)
        lab.numberOfLines = 2
        lab.textColor = .secondaryLabel
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMessageLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configureMessageLabel() {
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
