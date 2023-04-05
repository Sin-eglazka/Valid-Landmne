
import UIKit
 
class RulesViewController: UIViewController {
 
    let closeButton: UIButton = UIButton()
    let rulesTextView = UITextView()
     
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
        rulesTextView.isScrollEnabled = true
        rulesTextView.font = .systemFont(ofSize: 16, weight: .regular)
        rulesTextView.textColor = .black
        rulesTextView.backgroundColor = UIColor(red: 1.00, green: 0.75, blue: 0.63, alpha: 1.00)
        rulesTextView.textAlignment = .center
        rulesTextView.text = "Главная цель игры — найти и отметить мины флажками. Игра заканчивается в случае, если все мины были отмечены, или если игрок открывает клетку, под которой прячется бомба. В открытых клетках могут содержаться цифры - количество бомб вокруг этой клетки с цифрой.\nЕсли игрок уверен, что нет ни одного безопасного хода (то есть он не может отметить или открыть клетку без бомбы гарантированно), тогда он может нажать на кнопку помощи. Она откроет другую закрытую клетку. Нажимать кнопку помощи можно неограниченное количество раз, пока вы уверены, что точного решения нет. Но если игрок ошибается, и такой ход существовал, он проигрывает."
        
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
        rulesView.backgroundColor = UIColor(red: 1.00, green: 0.75, blue: 0.63, alpha: 1.00)
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
        UIView.animate(withDuration: 0.24, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            self.view.alpha = 0.0
        }) { _ in
            self.view.removeFromSuperview()
        }
    }
}
