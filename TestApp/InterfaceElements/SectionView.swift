//
//  SectionView.swift
//  TestApp
//
//  Created by Yulia Ignateva on 16.03.2023.
//

import UIKit

final class SectonView: UIView {
    private let title: String
    private let iconStyle: Icons
    private let sectionStyle: SectionStyle?
    private var icon = UIImageView()
    
    init(title: String, iconStyle: Icons, sectionStyle: SectionStyle?) {
        self.title = title
        self.iconStyle = iconStyle
        self.sectionStyle = sectionStyle
        super.init(frame: .zero)
        configureIcon()
        configureTitle()
        configureDetailInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureIcon() {
        switch iconStyle {
        case .wallet: icon.image = UIImage(named: "Wallet")!
        case .restore: icon.image = UIImage(named: "Restore")!
        case .help: icon.image = UIImage(named: "Help")!
        case .logOut: icon.image = UIImage(named: "LogOut")!
        }
        
        self.addSubview(icon)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [icon.widthAnchor.constraint(equalToConstant: 40),
             icon.heightAnchor.constraint(equalToConstant: 40),
             icon.topAnchor.constraint(equalTo: self.topAnchor),
             icon.leftAnchor.constraint(equalTo: self.leftAnchor)])
        
    }
    
    private func configureTitle() {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.specialFont(size: 12, style: .regular)
        
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate(
            [titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
             titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8.5)])
    }
    
    private func configureDetailInfo() {
        guard let sectionStyle = sectionStyle else { return }
        let detailView = UIImageView()
        
        switch sectionStyle {
        case .information: detailView.image = UIImage(named: "InformationSection")
        case .transition: detailView.image = UIImage(named: "TransitionSection")
        }
        
        self.addSubview(detailView)
        NSLayoutConstraint.activate(
            [detailView.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
             detailView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 45.5)])
    }
    
    enum Icons {
        case wallet
        case restore
        case help
        case logOut
    }

    enum SectionStyle {
        case information
        case transition
    }
}
