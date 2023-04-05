//
//  ViewController.swift
//  eeakstHW2
//
//  Created by Kate on 21.09.2022.
//

import UIKit
import SwiftUI

let userDefaults = UserDefaults.standard

protocol DisableContinueButton: AnyObject{
    func disablecontinueButton()
}


class MainViewController: UIViewController {

    
    
    private let mainLabel = UILabel()
    
    private var commentView = UIView()
    private var gameViewController: GameViewController? = nil
    private var continueButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSettings()
        setupView()
        
    }
    
    func setUpSettings(){
        Settings.isMusic = userDefaults.bool(forKey: "isMusic")
        Settings.musicType = Music(rawValue: userDefaults.string(forKey: "musicType") ?? "Dark") ?? Music.Dark
        Settings.clues = userDefaults.integer(forKey: "clues")
        Settings.coins = userDefaults.integer(forKey: "coins")
        Settings.fieldTheme = FieldTheme(rawValue: userDefaults.string(forKey: "fieldTheme") ?? "standart") ?? FieldTheme.standart
        Settings.difficulty = Difficulty(rawValue: userDefaults.string(forKey: "difficulty") ?? "easy") ?? Difficulty.easy
    }
    
    func assignBackground(){
        let background = UIImage(named: "mainBackGround")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
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
        mainLabel.text = "Сапер"
         commentView.addSubview(mainLabel)
         mainLabel.pin(to: commentView, [.top: 30, .left: 16, .bottom: 30, .right: 16])
         return commentView
     }
    
    private func setupView() {
        
        assignBackground()
        commentView = setupCommentView()
        setupMenuButtons()
        setupRulesButton()
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .black
        if (Settings.isMusic){
            MusicPlayer.shared.startBackgroundMusic(music: Settings.musicType)
        }
     }
    
    private func setupRulesButton(){
        
        let buttonRules = UIButton()
        buttonRules.setImage(UIImage(named: "help"), for: .normal)
        buttonRules.setHeight(to: 40)
        buttonRules.setWidth(to: 40)
        buttonRules.heightAnchor.constraint(equalTo: buttonRules.widthAnchor).isActive = true
        self.view.addSubview(buttonRules)
        buttonRules.pin(to: self.view, [.left: 20, .bottom: 20])
        buttonRules.addTarget(self, action:
                                    #selector(rulesButtonPressed), for:.touchUpInside)
    }
    
    
    private func makeMenuButton(title: String) -> UIButton {
         let button = UIButton()
         button.setTitle(title, for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
         button.backgroundColor = .blue
         button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
         return button
     }
    
    private func setupMenuButtons() {
         let newGameButton = makeMenuButton(title: "Новая игра")
         newGameButton.addTarget(self, action:
            #selector(startGameButtonPressed), for:.touchUpInside)
         
        continueButton = makeMenuButton(title: "Продолжить")
        continueButton.isEnabled = false
        continueButton.backgroundColor = .lightGray
        continueButton.addTarget(self, action: #selector(continueGameButtonPressed), for:.touchUpInside)
        
        let shopButton = makeMenuButton(title: "Магазин")
        shopButton.addTarget(self, action: #selector(shopButtonPressed), for: .touchUpInside)
        
        let exitButton = makeMenuButton(title: "Настройки")
        exitButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        
        let allButtons = UIStackView(arrangedSubviews: [newGameButton, continueButton, shopButton, exitButton])
        allButtons.spacing = 20
        allButtons.axis = .vertical
        allButtons.distribution = .fillEqually
         self.view.addSubview(allButtons)
        allButtons.pin(to: self.view, [.left:self.view.frame.size.width / 10, .right: self.view.frame.size.width / 10, .bottom: self.view.frame.size.height / 7, .top: self.view.frame.size.height / 3])
         
     }
    
    @objc
    private func rulesButtonPressed() {
        
        let popUpStudent = RulesViewController()
        self.addChild(popUpStudent)
        popUpStudent.view.frame = self.view.frame
        
        self.view.addSubview(popUpStudent.view)
        popUpStudent.didMove(toParent: self)
    }	
    
    @objc
    private func startGameButtonPressed() {
        gameViewController = GameViewController(difficultyGame: Settings.difficulty)
        continueButton.backgroundColor = .blue
        continueButton.isEnabled = true
        navigationController?.pushViewController(gameViewController ?? GameViewController(difficultyGame: Settings.difficulty), animated: true)
    }
    
    @objc
    private func continueGameButtonPressed() {
        if gameViewController != nil{
            navigationController?.pushViewController(gameViewController ?? GameViewController(difficultyGame: Settings.difficulty), animated: true)
        }
    }
    
    @objc
    private func settingsButtonPressed() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @objc
    private func shopButtonPressed() {
        let shopViewController = ShopViewController()
        navigationController?.pushViewController(shopViewController, animated: true)
    }
    
    
    @objc
    private func groupButtonPressed() {
        let shopViewController = ShopViewController()
        navigationController?.pushViewController(shopViewController, animated: true)
    }
    
    
}

extension MainViewController: DisableContinueButton{
    
    func disablecontinueButton() {
        continueButton.backgroundColor = .lightGray
        continueButton.isEnabled = false
        gameViewController = nil
    }
}

	
