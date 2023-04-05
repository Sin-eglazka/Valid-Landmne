

import UIKit


final class StudentCell: UITableViewCell {
    
    static let reuseIdentifier = "StudentCell"
    private var note: StudentName
    private var text = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        note = StudentName(text: "-")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getRandomColor() -> UIColor {
        return UIColor(red: CGFloat(Int.random(in: 0..<256)) / 255, green: CGFloat(Int.random(in: 0..<256)) / 255, blue: CGFloat(Int.random(in: 0..<256)) / 255, alpha: 0.5)
    }
    
    
    private func setupView() {
         text.font = .systemFont(ofSize: 20, weight: .regular)
         text.textColor = .black
        text.backgroundColor = .clear
         text.setHeight(to: 20)
         let stackView = UIStackView(arrangedSubviews: [text])
         stackView.axis = .vertical
         stackView.spacing = 8
         stackView.distribution = .fill
        stackView.backgroundColor = .clear
         contentView.addSubview(stackView)
         stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = getRandomColor()
        
 }
    
    func configure(shortnote: StudentName){
         note = shortnote
         text.text = shortnote.text
    }
}
