//
//  ShopViewController.swift
//  eeakstHW3
//
//  Created by Kate on 05.03.2023.
//

import UIKit

class ShopViewController: UIViewController{
    private let mainLabel = UILabel()
    private var commentView = UIView()
    private let labelClue = UILabel(), labelCoins = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    private func setupView() {
        
        assignBackground()
        commentView = setupCommentView()
        setupUpBar()
        setUpShopItems()
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .black
        
     }
    
    private func setupUpBar(){
//        let imageClue = UIImageView(image: UIImage(named: "clue"))
//        imageClue.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        let clueView = UIView()
//        clueView.addSubview(imageClue)
        
        let buttonClue = UIButton()
        buttonClue.setImage(UIImage(named: "clue"), for: .normal)
        buttonClue.layer.cornerRadius = 5
        buttonClue.setHeight(to: 30)
        buttonClue.setWidth(to: 30)
        buttonClue.heightAnchor.constraint(equalTo: buttonClue.widthAnchor).isActive = true
        
        labelClue.text = String(Settings.clues)
        labelClue.font = .systemFont(ofSize: 20, weight: .bold)
        let clueLabelView = UIView()
        clueLabelView.addSubview(labelClue)
        
        labelCoins.text = String(Settings.coins)
        labelCoins.font = .systemFont(ofSize: 20, weight: .bold)
        
        let buttonCoin = UIButton()
        buttonCoin.setImage(UIImage(named: "coin"), for: .normal)
        buttonCoin.layer.cornerRadius = 5
        buttonCoin.setHeight(to: 30)
        buttonCoin.setWidth(to: 30)
        buttonCoin.heightAnchor.constraint(equalTo: buttonCoin.widthAnchor).isActive = true
        
//        let uiImageView = UIImageView(image: UIImage(named: "coin"))
//        uiImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        
        let stackView = UIStackView(arrangedSubviews: [labelClue, buttonClue, labelCoins, buttonCoin])
        self.view.addSubview(stackView)
        stackView.spacing = 5
        //stackView.distribution = .equalSpacing
        stackView.pin(to: self.view, [.left: 20, .top: 120])
    }
    
    private func createViewItem(text: String, topHeight: Double, clue: Int, coin: Int){
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        self.view.addSubview(view)
        view.pin(to: self.view, [.top: topHeight, .left: 16, .right: 16])
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = text
        view.addSubview(label)
        label.pin(to: view, [.top: 15, .left: 5, .bottom: 15])
        let uiButton = ShopCell(coins: coin, clues: clue)
        view.addSubview(uiButton)
        uiButton.backgroundColor = .systemGreen
        uiButton.setTitle("+", for: .normal)
        uiButton.setTitleColor(.black, for: .normal)
        uiButton.layer.cornerRadius = 5
        uiButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
        uiButton.pin(to: view, [.top:15, .right: 5, .bottom: 15])
        uiButton.addTarget(self, action: #selector(buyButtonPressed), for: .touchUpInside)
        
        let buttonCoin = UIButton()
        buttonCoin.setImage(UIImage(named: "coin"), for: .normal)
        buttonCoin.layer.cornerRadius = 5
        buttonCoin.setHeight(to: 30)
        buttonCoin.setWidth(to: 30)
        buttonCoin.heightAnchor.constraint(equalTo: buttonCoin.widthAnchor).isActive = true
        
        view.addSubview(buttonCoin)
        buttonCoin.pin(to: view, [.top:15, .right: 50, .bottom: 15])
        
        let labelCoin = UILabel()
        labelCoin.font = .systemFont(ofSize: 20)
        labelCoin.textColor = .black
        labelCoin.numberOfLines = 0
        labelCoin.textAlignment = .left
        labelCoin.text = String(coin)
        view.addSubview(labelCoin)
        labelCoin.pin(to: view, [.top: 15, .right: 90, .bottom: 15])
    }

    private func setUpShopItems(){
        let height = self.view.frame.size.height / 4 + 80
        createViewItem(text: "1 подсказка", topHeight: height, clue: 1, coin: 5)
        
        createViewItem(text: "5 подсказок", topHeight: height + 80, clue: 5, coin: 20)
    
        createViewItem(text: "15 подсказок", topHeight: height + 160, clue: 15, coin: 50)

    }
    
    private func setupCommentView() -> UIView {
         let commentView = UIView()
         commentView.backgroundColor = .white
         commentView.layer.cornerRadius = 0
         view.addSubview(commentView)
         commentView.pinTop(to:
         self.view.topAnchor)
         commentView.pin(to: self.view, [.left: 0, .right: 0])
        mainLabel.font = .systemFont(ofSize: 35, weight: .heavy)
        
         mainLabel.textColor = .black
         mainLabel.numberOfLines = 0
         mainLabel.textAlignment = .center
         mainLabel.text = "Магазин"
         commentView.addSubview(mainLabel)
         mainLabel.pin(to: commentView, [.top: 30, .left: 16, .bottom: 30, .right: 16])
         return commentView
     }
    
    
    func assignBackground(){
        let background = UIImage(named: "shopBackGround")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        }

    @objc
    func buyButtonPressed(button: ShopCell){
        if (Settings.coins >= button.getCoins()){
            Settings.coins -= button.getCoins()
            Settings.clues += button.getClues()
            userDefaults.set(Settings.clues, forKey: "clues")
            userDefaults.set(Settings.coins, forKey: "coins")
            labelClue.text = String(Settings.clues)
            labelCoins.text = String(Settings.coins)
        }
    }
    
}
