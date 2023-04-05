

import UIKit

final class BreakGroupsViewController: UIViewController {
    
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private var studentsNames: [String] = []
    
    var size: Int = 0
    
    private var dataSource = [[String]]()
    
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .systemBackground
    }
        
    override func viewWillAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         setupView()
    }
        
    private func setupView() {
        setupTableView()
        setupNavBar()
        assignBackground()
    }
    
    func assignBackground(){
        let background = UIImage(named: "groupedBackground")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        }
    
     private func setupTableView() {
         tableView.register(GroupCell.self,forCellReuseIdentifier: GroupCell.reuseIdentifier)
         tableView.register(AddGroupsCells.self, forCellReuseIdentifier: AddGroupsCells.reuseIdentifier)
         view.addSubview(tableView)
         tableView.backgroundColor = .clear
         tableView.keyboardDismissMode = .onDrag
         tableView.dataSource = self
         view.addSubview(tableView)
         tableView.pin(to: self.view)
     }
        
     private func setupNavBar() {
         let closeButton = UIButton(type: .close)
         closeButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
     }
    
    func updateStudentList(listStudents: [String]){
        studentsNames = listStudents
        dataSource.removeAll()
        tableView.reloadData()
    }
    
     
    @objc
     private func dismissViewController() {
         self.dismiss(animated: true, completion: nil)
     }
    
}

extension BreakGroupsViewController: AddGroupDelegate {
    func newGroupAdded(listStudents: [String]) {
        dataSource.insert(listStudents, at: 0)
        tableView.reloadData()
    }
    
    func deleteAllCells() {
        dataSource = []
        tableView.reloadData()
    }
    
    func updateStudents() -> [String] {
        return studentsNames
    }
}

extension BreakGroupsViewController: UITableViewDataSource {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
     switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                if let addNewCell = tableView.dequeueReusableCell(withIdentifier: AddGroupsCells.reuseIdentifier, for: indexPath) as? AddGroupsCells {
                    addNewCell.delegate = self
                    return addNewCell
                }
            default:
                let list = dataSource[indexPath.row]
                if let groupCell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseIdentifier, for: indexPath) as? GroupCell {
                    groupCell.configure(listStudents: list)
                        return groupCell
                }
            }
        return UITableViewCell()
    }
}




