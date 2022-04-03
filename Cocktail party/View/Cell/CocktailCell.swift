//
//  MainViewCell.swift
//  Cocktail party
//
//  Created by APPLE on 01.04.2022.
//

import UIKit

final class CocktailCell: UICollectionViewCell {
    
    //MARK: - Properties
    static var identifiere = "MainViewCell"
    
    lazy var gradientLayer = CAGradientLayer()
    
    private var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
        settingsCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureGradientBackground(frame: bounds)
    }
    
    
    //MARK: -Public
    func configureGradientBackground(frame: CGRect ) {
        let colorTop =  UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 128.0/255.0, green: 0.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.2, 1.0]
        gradientLayer.cornerRadius = 5
        gradientLayer.frame = frame
        gradientLayer.masksToBounds = true
    }
    
    func configureCell(model: DrinkViewModel) {
        textLabel.text = model.text
        
        if model.isSelected == true {
            contentView.layer.insertSublayer(gradientLayer, at:0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    func setupGradient(model: DrinkViewModel) {
        if model.isSelected == true {
            contentView.layer.insertSublayer(gradientLayer, at:0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    //MARK:- View hierarhies
    private func setupView(){
        contentView.addSubview(textLabel)
    }
    
    //MARK:- Constraints
    private func setupConstraint() {
        textLabel.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(8)
            maker.leading.equalToSuperview().inset(8)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Settings cell
    func settingsCell() {
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.cornerRadius = 5
    }
}
