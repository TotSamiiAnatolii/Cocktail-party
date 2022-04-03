//
//  MainView.swift
//  Cocktail party
//
//  Created by APPLE on 01.04.2022.
//

import UIKit
import SnapKit

final class MainView: UIView {
    
    //MARK: - Properties
    var collectionView: UICollectionView!
    
    let searchTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        let layout: UICollectionViewFlowLayout = TagLayout()
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CocktailCell.self, forCellWithReuseIdentifier: CocktailCell.identifiere)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.backgroundColor = .white
        setupView()
        configureCollectionView()
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- View hierarhies
    private func setupView(){
        self.addSubview(collectionView)
        self.addSubview(searchTextField)
    }
    
    //MARK: - Public(Сonfiguration setting)
    func configureTextField(){
        searchTextField.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).inset(-30)
        }
        
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.gray.cgColor
        searchTextField.placeholder = "Cocktail name"
        searchTextField.layer.cornerRadius = 5
        searchTextField.textAlignment = .center
        searchTextField.layer.masksToBounds = false
        searchTextField.layer.shadowRadius = 2.0
        searchTextField.layer.shadowColor = UIColor.black.cgColor
        searchTextField.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        searchTextField.layer.shadowOpacity = 0.5
        searchTextField.backgroundColor = .white
    }
    
    func configureCollectionView(){
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(self.frame.height / 5)        }
    }
}
