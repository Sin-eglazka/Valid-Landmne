

import UIKit


final class GroupCell: UITableViewCell {
    
    static let reuseIdentifier = "GroupCell"
    private var students: [String]
    let scrollView = UIScrollView()
    let content = UIStackView()
    var labels:[UILabel] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        students = []
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
        //contentView.addSubview(scrollView)
        //scrollView.addSubview(content)
        contentView.backgroundColor = .clear
        content.backgroundColor = getRandomColor()
        content.axis = .vertical
        content.spacing = 5
        content.distribution = .fillEqually
        contentView.addSubview(content)
        content.pin(to: contentView, [.bottom:10, .left: 5, .right: 5, .top: 10])
        //scrollView.backgroundColor = .clear
        //scrollView.translatesAutoresizingMaskIntoConstraints = false
        //scrollView.layoutMargins = .zero
        
        //content.translatesAutoresizingMaskIntoConstraints = false
        content.alignment = .fill
        
        
        
        /*NSLayoutConstraint.activate([
                        scrollView.topAnchor.constraint(equalTo: topAnchor),
                        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                        content.topAnchor.constraint(equalTo: scrollView.topAnchor),
                        content.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                        content.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                        content.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                        content.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                    ])
        scrollView.contentSize = CGSize(width: self.frame.width, height: 150)*/
 }
    
    func configure(listStudents: [String]){
        students = listStudents
        labels = []
        for label in content.subviews{
            label.removeFromSuperview()
        }
        for i in 0..<listStudents.count{
            labels.append(makeStudentLabel(text: listStudents[i]))
            content.addArrangedSubview(labels.last!)
        }
    }
    
    private func makeStudentLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .regular)
        return label
     }
    
}
