
import UIKit
 
class TimerViewController: UIViewController {
 
    let startButton: UIButton = UIButton()
    let mainLabel = UILabel()
    let textViewMinutes = UITextView(), textViewSeconds = UITextView()
    let timerLabel = UILabel()
    var isTimerRun = false
    var timer: Timer? = nil
    var time: Int = 0, seconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        setUpViews()
   }
    
    
    
    private func setupMainViews() {
        mainLabel.font = .systemFont(ofSize: 50, weight: .regular)
        mainLabel.textColor = .black
        mainLabel.numberOfLines = 0
        mainLabel.textAlignment = .center
        mainLabel.text = "Timer"
        self.view.addSubview(mainLabel)
        mainLabel.pin(to: self.view, [ .left: 15, .right:15, .top:30])
        
        timerLabel.font = .systemFont(ofSize: 70, weight: .regular)
        timerLabel.textColor = .black
        timerLabel.numberOfLines = 0
        timerLabel.textAlignment = .center
        timerLabel.text = "00:00"
        
        textViewMinutes.font = .systemFont(ofSize: 40, weight: .regular)
        textViewMinutes.textColor = .black
        textViewMinutes.backgroundColor = .white
        textViewMinutes.textContainer.maximumNumberOfLines = 1
        textViewMinutes.layer.cornerRadius = 10
        textViewMinutes.textAlignment = .center
        textViewSeconds.font = .systemFont(ofSize: 40, weight: .regular)
        textViewSeconds.textColor = .black
        textViewSeconds.backgroundColor = .white
        textViewSeconds.textContainer.maximumNumberOfLines = 1
        textViewSeconds.layer.cornerRadius = 10
        textViewSeconds.textAlignment = .center
    }
    
    private func setUpViews(){
        
        setupMainViews()
        
        let text = UILabel()
        text.text = ":"
        text.font = .systemFont(ofSize: 40, weight: .regular)
        text.textColor = .black
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.setHeight(to: 50)
        text.setWidth(to: 5)
        text.numberOfLines = 0
        text.layer.cornerRadius = 0
        
        let textStack = UIStackView(arrangedSubviews: [textViewMinutes, text, textViewSeconds])
        textStack.spacing = 0
        textStack.axis = .horizontal
        textStack.distribution = .fillEqually
        
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.backgroundColor = .white
        startButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .regular)
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action:
           #selector(reuseTimer), for:.touchUpInside)
        startButton.contentHorizontalAlignment = .center
        

        
        let timerView = UIStackView(arrangedSubviews: [textStack, timerLabel, startButton])
        self.view.addSubview(timerView)
        timerView.spacing = self.view.frame.height / 6
        timerView.axis = .vertical
        timerView.layer.cornerRadius = 20
        timerView.pin(to: self.view, [.top: 20 + self.view.frame.height / 5, .left: 15, .right: 15, .bottom: self.view.frame.height / 5])
        
        
        
    }
    
    func assignBackground(){
        let background = UIImage(named: "timerBackground")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        }
    
    @objc
    func reuseTimer(){
        time = Int(textViewMinutes.text) ?? -1
        let sec = Int(textViewSeconds.text) ?? -1
        if (!isTimerRun){
            if ((time < 0) || (sec < 0)){
                return
            }
            time = time * 60 + sec
        }
        
        isTimerRun.toggle()
        if (isTimerRun){
            startButton.setTitle("Stop", for: .normal)
            textViewMinutes.isEditable = false
            textViewSeconds.isEditable = false
            textViewMinutes.text = ""
            textViewSeconds.text = ""
            seconds = 0
            runTimer()
        }
        else{
            timer?.invalidate()
            stopTimer()
        }
    }
    
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        startButton.setTitle("Start", for: .normal)
        textViewMinutes.isEditable = true
        textViewSeconds.isEditable = true
        textViewMinutes.text = ""
        textViewSeconds.text = ""
        timerLabel.text = "00:00"
        seconds = 0
        isTimerRun = false
    }
    
    @objc
    func updateTimer(){
        seconds += 1
        if (seconds >= time){
            startButton.setTitle("Start", for: .normal)
            textViewMinutes.isEditable = true
            textViewSeconds.isEditable = true
            textViewMinutes.text = ""
            textViewSeconds.text = ""
            timerLabel.text = "00:00"
            seconds = 0
            isTimerRun = false
            timer?.invalidate()
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
        else{
            var textTime = ""
            let timeLeft: Int = time - seconds
            if (timeLeft <= 599){
                textTime += "0"
            }
            textTime += String(timeLeft / 60) + ":"
            if (timeLeft % 60 < 10){
                textTime += "0"
            }
            textTime += String(timeLeft % 60)
            timerLabel.text = textTime
        }
    }
    
}
