//
//  SettingsViewController.swift
//  eeakstHW3
//
//  Created by Kate on 05.03.2023.
//

import UIKit
import DropDown
import SwiftUI

class SettingsViewController: UIViewController{
    private let mainLabel = UILabel()
    private var commentView = UIView()
    private let switchMusic = UISwitch()
    private let dropDownMusic = DropDown(), dropDownDifficulty = DropDown(), dropDownTheme = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    private func setupView() {
        
        assignBackground()
        commentView = setupCommentView()
        setupDropdowns()
        setSwitch()
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .black
        
     }
    
    private func setSwitch(){
        let topHeight = self.view.frame.size.height / 4
        let musicIsOnView = createViewSettings(text: "Музыка", topHeight: topHeight)
        switchMusic.frame = CGRect(x: 100, y: 100, width: 0, height: 0)
        switchMusic.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
        switchMusic.setOn(Settings.isMusic, animated: false)
        musicIsOnView.0.addSubview(switchMusic)
        switchMusic.pin(to: musicIsOnView.0, [.right: 10, .top: 15, .bottom: 15])
    }
    
    @objc
    private func switchDidChange(_ sender: UISwitch){
        Settings.isMusic = sender.isOn
        userDefaults.set(sender.isOn, forKey: "isMusic")
        MusicPlayer.shared.stopBackgroundMusic()
        if Settings.isMusic{
            MusicPlayer.shared.startBackgroundMusic(music: Settings.musicType)
        }
    }
    
    private func createViewSettings(text: String, topHeight: Double) -> (UIView, UILabel){
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
        return (view, label)
    }
    
    private func setupDropdowns(){
        let gestureMusic = UITapGestureRecognizer(target: self, action:  #selector(self.tapMusic))
        let height = self.view.frame.size.height / 4 + 80
        let musicView = createViewSettings(text: "Выбрать тип музыки", topHeight: height)
        musicView.0.addGestureRecognizer(gestureMusic)
        addUIImage(view: musicView.0)
        dropDownMusic.dataSource = Music.allCases.map { $0.rawValue}
        dropDownMusic.anchorView = musicView.0
        dropDownMusic.selectionAction = { [unowned self] (index: Int, item: String) in
            musicView.1.text = item
            Settings.musicType = Music(rawValue: item) ?? Music.Guitar
            userDefaults.set(item, forKey: "musicType")
            if Settings.isMusic{
                MusicPlayer.shared.stopBackgroundMusic()
                MusicPlayer.shared.startBackgroundMusic(music: Settings.musicType)
            }
        }
        
        let gestureDifficulty = UITapGestureRecognizer(target: self, action:  #selector(self.tapDifficulty))
        let difficultyView = createViewSettings(text: "Выбрать сложность", topHeight: height + 80)
        difficultyView.0.addGestureRecognizer(gestureDifficulty)
        addUIImage(view: difficultyView.0)
        dropDownDifficulty.dataSource = Difficulty.allCases.map { $0.rawValue}
        dropDownDifficulty.anchorView = difficultyView.0
        dropDownDifficulty.selectionAction = { [unowned self] (index: Int, item: String) in
            difficultyView.1.text = item
            Settings.difficulty = Difficulty(rawValue: item) ?? Difficulty.easy
            userDefaults.set(item, forKey: "difficulty")
        }
        
        let gestureTheme = UITapGestureRecognizer(target: self, action:  #selector(self.tapTheme))
        let themeView = createViewSettings(text: "Выбрать тип поля", topHeight: height + 160)
        themeView.0.addGestureRecognizer(gestureTheme)
        addUIImage(view: themeView.0)
        dropDownTheme.dataSource = FieldTheme.allCases.map { $0.rawValue}
        dropDownTheme.anchorView = themeView.0
        dropDownTheme.selectionAction = { [unowned self] (index: Int, item: String) in
            themeView.1.text = item
            Settings.fieldTheme = FieldTheme(rawValue: item) ?? FieldTheme.standart
            userDefaults.set(item, forKey: "fieldTheme")
        }


    }
    
    func addUIImage(view: UIView){
        let uiImageView = UIImageView(image: UIImage(named: "arrow"))
        view.addSubview(uiImageView)
        //uiImageView.frame.size.height = 100
        //uiImageView.frame.size.width = 100
        let left = self.view.frame.size.width - 96
        uiImageView.frame = CGRect(x: left, y: 0, width: 50, height: 50)
        uiImageView.contentMode = UIView.ContentMode.scaleAspectFill
        //uiImageView.pin(to: view, [.top: 15])
    }
    
    @objc func tapTheme(sender : UITapGestureRecognizer) {
        dropDownTheme.show()
    }

    
    @objc func tapDifficulty(sender : UITapGestureRecognizer) {
        dropDownDifficulty.show()
    }
    
    
    @objc func tapMusic(sender : UITapGestureRecognizer) {
        dropDownMusic.show()
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
         mainLabel.text = "Настройки"
         commentView.addSubview(mainLabel)
         mainLabel.pin(to: commentView, [.top: 30, .left: 16, .bottom: 30, .right: 16])
         return commentView
     }
    
    
    func assignBackground(){
        let background = UIImage(named: "settingsBackGround")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        }

}
