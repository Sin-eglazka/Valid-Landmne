
import UIKit
 
class GameOverViewController: UIViewController {
 
    let closeButton: UIButton = UIButton()
    let rulesTextView = UITextView()
    let text:String
    var delegate: DismissWithChild?
    init(text:String, delegate: DismissWithChild){
        self.text = text
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        setUpViews()
        moveIn()
   }
    
    @objc
    func closePopUp(_ sender: UIButton) {
        moveOut()
    }
    
    
    func setUpViews(){
        rulesTextView.isEditable = false
        rulesTextView.font = .systemFont(ofSize: 30, weight: .regular)
        rulesTextView.textColor = .black
        rulesTextView.backgroundColor = UIColor(red: 1.00, green: 0.75, blue: 0.63, alpha: 0)
        rulesTextView.textAlignment = .center
        rulesTextView.text = text
        
        let closeButtonRight = UIButton(type: .close)
        closeButtonRight.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
        let viewButton = UIView()
        viewButton.addSubview(closeButtonRight)
        viewButton.setHeight(to: 30)
        closeButtonRight.pin(to: viewButton, [.right:5, .top:3])
        
        closeButton.setTitle("OK", for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .regular)
        closeButton.addTarget(self, action:
           #selector(closePopUp), for:.touchUpInside)
        
        let rulesView = UIStackView(arrangedSubviews: [viewButton, rulesTextView, closeButton])
        self.view.addSubview(rulesView)
        rulesView.spacing = 35
        rulesView.isLayoutMarginsRelativeArrangement = true
        rulesView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        rulesView.axis = .vertical
        rulesView.backgroundColor = UIColor(red: 1.00, green: 0.75, blue: 0.63, alpha: 0.5)
        rulesView.layer.cornerRadius = 20
        rulesView.pinTop(to:
        self.view.centerYAnchor)
        rulesView.pin(to: self.view, [.left: 30, .right: 30, .bottom: self.view.frame.size.height / 5, .top: self.view.frame.size.height / 5])
        
        
        
    }
     
    func moveIn() {
        self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        self.view.alpha = 0.0
         
        UIView.animate(withDuration: 0.24) {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0
        }
    }
     
    func moveOut() {
        delegate?.dismissViewController()
        UIView.animate(withDuration: 0.24, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            self.view.alpha = 0.0
        }) { _ in
            
            self.view.removeFromSuperview()
        }
    }
}
