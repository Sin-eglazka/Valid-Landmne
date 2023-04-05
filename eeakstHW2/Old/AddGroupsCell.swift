

import UIKit

protocol AddGroupDelegate: AnyObject {
    func newGroupAdded(listStudents: [String])
    
    func deleteAllCells()
    
    func updateStudents() -> [String]
}

final class AddGroupsCells: UITableViewCell {
    
    static let reuseIdentifier = "AddGroupsCells"
    private var textView = UITextView()
    public var addButton = UIButton()
    
    var listStudentNames: [String] = []
    
    var delegate: AddGroupDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
    
    private func setupView() {
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 30, weight: .regular)
        textLabel.textColor = .black
        textLabel.text = "Number of groups"
        
        textView.font = .systemFont(ofSize: 40, weight: .regular)
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.setHeight(to: 50)
        textView.backgroundColor = .white
        textView.textAlignment = .center
        
        addButton.setTitle("Break Into Groups", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(to: 44)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addButton.isEnabled = true
        addButton.alpha = 0.5
        
        let stackView = UIStackView(arrangedSubviews: [textLabel, textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = .systemGray
 }
    
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        
        var peoplePerGroup = Int(textView.text) ?? 0
        var count: Int
        listStudentNames = delegate?.updateStudents() ?? listStudentNames
        if ((peoplePerGroup > 0) && (listStudentNames.count != 0)){
            delegate?.deleteAllCells()
            listStudentNames.shuffle()
            if (listStudentNames.count % peoplePerGroup != 0){
                count = listStudentNames.count % peoplePerGroup
                peoplePerGroup = listStudentNames.count / peoplePerGroup + 1
            }
            else{
                count = peoplePerGroup
                peoplePerGroup = listStudentNames.count / peoplePerGroup
            }
        
            var index = 0
            
            while (index < listStudentNames.count){
                if (count == 0){
                    peoplePerGroup -= 1
                    count = -1
                }
                if (count > 0){
                    count -= 1
                }
                var list: [String] = []
                for j in 0..<peoplePerGroup{
                    list.append(listStudentNames[index + j])
                }
                index += peoplePerGroup
                delegate?.newGroupAdded(listStudents: list)
            }
            
            textView.text = ""
        }
    }
    
    func setListStudents(list: [String]){
        listStudentNames = list
    }
}
