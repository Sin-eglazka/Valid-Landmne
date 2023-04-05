//
//  GameViewController.swift
//  eeakstHW3
//
//  Created by Kate on 05.03.2023.
//

import Foundation
import UIKit

class GameViewController: UIViewController, UIScrollViewDelegate, DismissWithChild{
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let difficulty: Difficulty
    private var field: Field
    private var fieldCells: [[FieldCell]] = []
    private var stackViews: [UIStackView] = []
    private let size:Int
    private var isFirst: Bool = true, isFlag = false
    private let flagButton = UIButton(), mineButton = UIButton()
    private let labelClue = UILabel(), labelMines = UILabel()
    var delegate: DisableContinueButton?
    
    init(difficultyGame: Difficulty, delegate: DisableContinueButton){
        self.delegate = delegate
        self.difficulty = difficultyGame
        field = Field(difficulty: self.difficulty)
        size = field.getSize()
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        setUpViews()
        setupSettingsButtons()
        setUpFlagsButtons()
        setScrollView()
        setUpButtonsUp()
    }
    
    func setScrollView(){
        scrollView.addSubview(contentView)
        self.view.addSubview(scrollView)
        scrollView.pin(to: self.view, [.top: 150, .bottom: 60, .right: 1, .left: 1])
        contentView.pin(to: self.view, [.top: 150, .bottom: 60, .right: 1, .left: 1])
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
        scrollView.zoomScale = 1

    }
    
    func setUpButtonsUp(){
        let buttonHelp = UIButton()
        buttonHelp.setTitle("Help", for: .normal)
        buttonHelp.setTitleColor(.black, for: .normal)
        buttonHelp.setHeight(to: 40)
        buttonHelp.setWidth(to: 100)
        buttonHelp.backgroundColor = .systemGreen
        buttonHelp.heightAnchor.constraint(equalTo: buttonHelp.widthAnchor).isActive = true
        self.view.addSubview(buttonHelp)
        buttonHelp.pin(to: self.view, [.right: 20, .bottom: 20])
        buttonHelp.addTarget(self, action:
                                    #selector(helpButtonPressed), for:.touchUpInside)
        buttonHelp.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        let buttonClue = UIButton()
        buttonClue.setImage(UIImage(named: "clue"), for: .normal)
        buttonClue.layer.cornerRadius = 5
        buttonClue.setHeight(to: 30)
        buttonClue.setWidth(to: 30)
        buttonClue.heightAnchor.constraint(equalTo: buttonClue.widthAnchor).isActive = true
        buttonClue.backgroundColor = .systemGray
        buttonClue.addTarget(self, action:
                                    #selector(clueButtonPressed), for:.touchUpInside)
        
        
        labelClue.text = String(Settings.clues)
        labelClue.font = .systemFont(ofSize: 20, weight: .bold)
        
        switch(difficulty){
        case .easy:
            labelMines.text = String("10")
        case .normal:
            labelMines.text = String("40")
        case .hard:
            labelMines.text = String("99")
        }
        labelMines.font = .systemFont(ofSize: 20, weight: .bold)
        
        let uiImageView = UIImageView(image: UIImage(named: "mine"))
        uiImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let view = UIView()
        view.addSubview(uiImageView)
        
        let stackView = UIStackView(arrangedSubviews: [labelClue, buttonClue, labelMines, view])
        self.view.addSubview(stackView)
        stackView.spacing = 3
        //stackView.distribution = .equalSpacing
        stackView.pin(to: self.view, [.left: 20, .top: 90])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
     
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
     
        return contentView
    }
    
    private func setUpFlagsButtons(){
        flagButton.setImage(UIImage(named: "flag"), for: .normal)
        flagButton.setHeight(to: 30)
        flagButton.setWidth(to: 30)
        flagButton.heightAnchor.constraint(equalTo: flagButton.widthAnchor).isActive = true
        flagButton.backgroundColor = .gray
        self.view.addSubview(flagButton)
        flagButton.pin(to: self.view, [.right: 100, .top: 90])
        flagButton.addTarget(self, action:
                                    #selector(flagButtonPressed), for:.touchUpInside)
        
        mineButton.setImage(UIImage(named: "click"), for: .normal)
        mineButton.setHeight(to: 30)
        mineButton.setWidth(to: 30)
        mineButton.heightAnchor.constraint(equalTo: mineButton.widthAnchor).isActive = true
        mineButton.backgroundColor = .green
        self.view.addSubview(mineButton)
        mineButton.pin(to: self.view, [.right: 50, .top: 90])
        mineButton.addTarget(self, action:
                                    #selector(mineButtonPressed), for:.touchUpInside)
    }
    
    private func setupSettingsButtons(){
        let buttonSettings = UIButton()
        buttonSettings.setImage(UIImage(named: "settings"), for: .normal)
        buttonSettings.setHeight(to: 30)
        buttonSettings.setWidth(to: 30)
        buttonSettings.heightAnchor.constraint(equalTo: buttonSettings.widthAnchor).isActive = true
        buttonSettings.addTarget(self, action:
                                    #selector(settingsButtonPressed), for:.touchUpInside)
        //.view.addSubview(buttonSettings)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonSettings)
        //.pin(to: self.view, [.right: 20, .top: 30])
        
        let buttonBack = UIButton()
        buttonBack.setTitle("Back", for: .normal)
        buttonBack.backgroundColor = .green
        buttonBack.setHeight(to: 30)
        buttonBack.setWidth(to: 70)
        buttonBack.setTitleColor(.black, for: .normal)
        buttonBack.layer.cornerRadius = 5
        buttonBack.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        buttonBack.heightAnchor.constraint(equalTo: buttonBack.widthAnchor).isActive = true
        buttonBack.addTarget(self, action:
                                    #selector(dismissViewController), for:.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: buttonBack)
        
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
    
    func assignBackground(){
        let background = UIImage(named: "gameBackGround")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        }
    
    func setUpViews(){
        let length = Float(min(self.view.frame.size.width - 30, self.view.frame.size.height - 180)) - Float(size - 1)
        for i in 0..<size{
            var temporaryButtons: [FieldCell] = []
            for j in 0..<size{
                temporaryButtons.append(FieldCell(indexCell: i * size + j, size: Double(length / Float(size))))
                temporaryButtons[j].addTarget(self, action: #selector(cellButtonPressed), for:.touchUpInside)
            }
            fieldCells.append(temporaryButtons)
        }
        for i in 0..<size{
            stackViews.append(UIStackView(arrangedSubviews: fieldCells[i]))
            stackViews[i].axis = .horizontal
            stackViews[i].spacing = 1
            //stackViews[i].distribution = .equalSpacing
        }
        let gameView = UIStackView(arrangedSubviews: stackViews)
        gameView.axis = .vertical
        gameView.spacing = 1
        gameView.distribution = .equalSpacing
        contentView.addSubview(gameView)
        gameView.pin(to: contentView, [.left: 15, .right: 15])
        gameView.pinTop(to: contentView.topAnchor, 15)
         
    }
    
    private func updateField(){
        let formatCells = field.returnFormats()
        for i in 0...size-1{
            for j in 0...size-1{
                fieldCells[i][j].setFormat(format: formatCells[i][j])
            }
        }
    }
    
    @objc
    private func cellButtonPressed(button: FieldCell) {
        if (isFirst){
            isFirst = false
            field.createField(indexFirst: button.getIndex())
            if !field.openCell(index: button.getIndex()){
                button.setFormat(format: field.returnFormatByIndex(index: button.getIndex()))
            }
            else{
                updateField()
            }
            
        }
        else{
            if (isFlag){
                button.setFormat(format: field.setFlag(index: button.getIndex()))
            }
            else{
                if !field.openCell(index: button.getIndex()){
                    button.setFormat(format: field.returnFormatByIndex(index: button.getIndex()))
                }
                else{
                    updateField()
                }
            }
        }
        labelMines.text = String(field.getLastMines())
        if (field.isGameOver()){
            let gameOverViewController: GameOverViewController
            if (field.isWin()){
                switch(difficulty){
                case .easy:
                    Settings.coins += 1
                case .normal:
                    Settings.coins += 2
                case .hard:
                    Settings.coins += 3
                }
                userDefaults.set(Settings.coins, forKey: "coins")
                gameOverViewController = GameOverViewController(text: "С победой!", delegate: self)
            }
            else{
                gameOverViewController = GameOverViewController(text: "Прости, но это была ошибка", delegate: self)
            }
            self.addChild(gameOverViewController)
            gameOverViewController.view.frame = self.view.frame
            self.view.addSubview(gameOverViewController.view)
            gameOverViewController.didMove(toParent: self)
            
            
        }
    }
    
    
    @objc
    func dismissViewController(){
        delegate?.disablecontinueButton()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func helpButtonPressed(){
        let solution = field.isHasSolution()
        cellButtonPressed(button: fieldCells[solution.1 / size][solution.1 % size])
        if solution.0{
            fieldCells[solution.1 / size][solution.1 % size].backgroundColor = .red
            let gameOverViewController: GameOverViewController
            gameOverViewController = GameOverViewController(text: "Ты ошибся. Решение было", delegate: self)
            self.addChild(gameOverViewController)
            gameOverViewController.view.frame = self.view.frame
            
            self.view.addSubview(gameOverViewController.view)
            gameOverViewController.didMove(toParent: self)
        }
    }
    @objc
    private func clueButtonPressed(){
        if (Settings.clues > 0){
            let answer = field.getRandomCloseCell()
            cellButtonPressed(button: fieldCells[answer / size][answer % size])
            Settings.clues -= 1
            userDefaults.set(Settings.clues, forKey: "clues")
            labelClue.text = String(Settings.clues)
        }
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
    private func flagButtonPressed() {
        isFlag = true
        flagButton.backgroundColor = .green
        mineButton.backgroundColor = .gray
        
    }
    
    @objc
    private func mineButtonPressed() {
        isFlag = false
        flagButton.backgroundColor = .gray
        mineButton.backgroundColor = .green
    }
    
    @objc
    private func settingsButtonPressed() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func setFormat(cellFormat: [CellFormat]){
        
    }
    
}

protocol DismissWithChild: AnyObject{
    func dismissViewController()
}
