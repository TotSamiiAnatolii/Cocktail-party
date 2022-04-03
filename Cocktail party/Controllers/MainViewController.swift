//
//  ViewController.swift
//  Cocktail party
//
//  Created by APPLE on 01.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var cocktailArray:[DrinkViewModel] = []
    
    private let cocktailAPI = CocktailAPI()
    
    private var mainView: MainView {return self.view as! MainView}
    
    private var tapGesture: UIGestureRecognizer!
    
    //MARK:- Lifecycle
    override func loadView() {
        super.loadView()
        self.view = MainView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.searchTextField.delegate = self
        
        cocktailAPI.getJSON { drinks in
            for drink in drinks {
                let drinkViewModel = DrinkViewModel(text: drink.strDrink, isSelected: false)
                self.cocktailArray.append(drinkViewModel)
            }
            self.mainView.collectionView.reloadData()
            
        }
        setTapGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK:- Action
   private func setTapGestureRecognizer() {
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapFunc))
        self.tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc func tapFunc() {
        mainView.searchTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let fullHeight = keyboardHeight + self.mainView.searchTextField.frame.height
            mainView.searchTextField.layer.cornerRadius = 0
            mainView.searchTextField.snp.removeConstraints()
            mainView.searchTextField.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview().inset(keyboardHeight)
            }
            
            mainView.collectionView.snp.removeConstraints()
            mainView.collectionView.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalToSuperview().inset(fullHeight)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            }
        }
    }
    
    @objc func keyboardWillHide() {
        mainView.searchTextField.snp.removeConstraints()
        mainView.configureTextField()
        mainView.collectionView.snp.removeConstraints()
        mainView.configureCollectionView()
    }
    
   private func searchText(textField: UITextField) {
        guard let text = textField.text else {return}
        for i in cocktailArray {
            if i.text.lowercased() == text.lowercased(){
                i.isSelected = true
            }
            mainView.collectionView.reloadData()
        }
    }
}

//MARK: - Extension
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cocktailArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CocktailCell.identifiere, for: indexPath) as! CocktailCell
        
        let model = cocktailArray[indexPath.row]
        
        cell.configureCell(model: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as! CocktailCell
        
        let model = cocktailArray[indexPath.row]
        
        model.isSelected = (model.isSelected == false) ? true : false

        cell.setupGradient(model: model)

    }
}

extension MainViewController: UITextFieldDelegate {
  
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchText(textField: textField)
    }
}

