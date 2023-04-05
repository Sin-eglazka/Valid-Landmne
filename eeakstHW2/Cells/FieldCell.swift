//
//  Cell.swift
//  eeakstHW3
//
//  Created by Kate on 05.03.2023.
//


import UIKit


final class FieldCell: UIButton {
    private var index: Int
    private var cellFormat: CellFormat
    required init(indexCell: Int, size: Double, type: UIButton.ButtonType = .system) {
        self.index = indexCell
        self.cellFormat = CellFormat.invisible
        super.init(frame: .zero)
        layer.cornerRadius = 0
        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        setHeight(to: size)
        setWidth(to: size)
        setInvisibleFormat()
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getIndex() -> Int{
        return self.index
    }
    
    func getFormat() -> CellFormat{
        return cellFormat
    }
    
    func setFormat(format: CellFormat){
        cellFormat = format
        updateImage()
    }
    
    func setInvisibleFormat(){
        self.setImage(nil, for: .normal)
        switch (Settings.fieldTheme){
        case .standart:
            self.backgroundColor = .gray
        case .green:
            self.backgroundColor = UIColor(red: Double.random(in: 0...1), green: 1, blue: Double.random(in: 0...1), alpha: 1)
        case .blue:
            self.backgroundColor = UIColor(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: 1, alpha: 1)
        case .red:
            self.backgroundColor = UIColor(red: 1, green: Double.random(in: 0...1), blue: Double.random(in: 0...1), alpha: 1)
        default:
            self.backgroundColor = UIColor(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), alpha: 1)
            
        }
        
    }
    
    private func updateImage(){
        self.setTitle("", for: .normal)
        switch (cellFormat){
        case .invisible:
            setInvisibleFormat()
        case .flag:
            self.backgroundColor = .lightGray
            self.setImage(UIImage(named: "flag"), for: .normal)
        case .bomb:
            self.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            self.setImage(UIImage(named: "mine"), for: .normal)
        case .empty:
            self.setImage(nil, for: .normal)
            self.backgroundColor = .lightGray
        case .eight:
            self.setImage(nil, for: .normal)
            self.backgroundColor = .lightGray
            self.setTitle("8", for: .normal)
            self.setTitleColor(.red, for: .normal)
        case .seven:
            self.setImage(nil, for: .normal)
            self.backgroundColor = .lightGray
            self.setTitle("7", for: .normal)
            self.setTitleColor(.purple, for: .normal)
        case .six:
            self.setImage(nil, for: .normal)
            self.backgroundColor = .lightGray
            self.setTitle("6", for: .normal)
            self.setTitleColor(.brown, for: .normal)
        case .five:
            self.setImage(nil, for: .normal)
            self.backgroundColor = .lightGray
            self.setTitle("5", for: .normal)
            self.setTitleColor(.cyan, for: .normal)
        case .four:
            self.setImage(nil, for: .normal)
            self.backgroundColor = .lightGray
            self.setTitle("4", for: .normal)
            self.setTitleColor(.orange, for: .normal)
        case .three:
            self.setImage(nil, for: .normal)
            self.backgroundColor = .lightGray
            self.setTitle("3", for: .normal)
            self.setTitleColor(.magenta, for: .normal)
        case .two:
            self.setImage(nil, for: .normal)
            self.backgroundColor = .lightGray
            self.setTitle("2", for: .normal)
            self.setTitleColor(.blue, for: .normal)
        case .one:
            self.setImage(nil, for: .normal)
            self.backgroundColor = .lightGray
            self.setTitle("1", for: .normal)
            self.setTitleColor(.green, for: .normal)
            
        }
    }
    
}
