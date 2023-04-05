

import UIKit

protocol AddNoteDelegate: AnyObject {
    func newNoteAdded(note: StudentName)
    
    func deleteAllCells()
}

final class AddStudentsCells: UITableViewCell {
    
    static let reuseIdentifier = "AddStudentsCells"
    private var textView = UITextView()
    public var addButton = UIButton()
    
    var delegate: AddNoteDelegate?
    
    // MARK: - Init
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
         textView.font = .systemFont(ofSize: 14, weight: .regular)
         textView.textColor = .black
         textView.backgroundColor = .clear
         textView.setHeight(to: 140)
         addButton.setTitle("Create Group", for: .normal)
         addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
         addButton.setTitleColor(.systemBackground, for: .normal)
         addButton.backgroundColor = .label
         addButton.layer.cornerRadius = 8
         addButton.setHeight(to: 44)
         addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
         addButton.isEnabled = true
         addButton.alpha = 0.5
         let stackView = UIStackView(arrangedSubviews: [textView, addButton])
         stackView.axis = .vertical
         stackView.spacing = 8
         stackView.distribution = .fill
         contentView.addSubview(stackView)
         stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
         contentView.backgroundColor = .systemGray5
 }
    
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        if (textView.text != ""){
            delegate?.deleteAllCells()
            let studentNames = textView.text.split(whereSeparator: \.isNewline)
            studentNames.forEach({delegate?.newNoteAdded(note: StudentName(text: String($0)))})
            textView.text = ""
        }
    }
}
