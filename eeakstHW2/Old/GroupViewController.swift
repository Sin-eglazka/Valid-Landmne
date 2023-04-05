

import UIKit

final class GroupViewController: UIViewController {
    
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private var dataSource = [StudentName]()
    
    
    
    private var studentsNames: [String] = []
    
    
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
        let background = UIImage(named: "groupBackground")
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
         tableView.register(StudentCell.self,forCellReuseIdentifier:
         StudentCell.reuseIdentifier)
         tableView.register(AddStudentsCells.self,forCellReuseIdentifier:
         AddStudentsCells.reuseIdentifier)
         view.addSubview(tableView)
         tableView.backgroundColor = .clear
         tableView.keyboardDismissMode = .onDrag
         tableView.dataSource = self
         tableView.delegate = self
         view.addSubview(tableView)
         tableView.pin(to: self.view)
     }
        
     private func setupNavBar() {
         self.navigationController?.navigationBar.barStyle = .black
         self.navigationController?.navigationBar.tintColor = .black
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
         self.title = "Group"
         let closeButton = UIButton(type: .close)
         closeButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
     }
    
     private func handleDelete(indexPath: IndexPath) {
         dataSource.remove(at: indexPath.row)
         studentsNames.remove(at: indexPath.row)
         tableView.reloadData()
     }
    
    @objc
     private func dismissViewController() {
         self.dismiss(animated: true, completion: nil)
     }
    
}

extension GroupViewController: UITableViewDataSource {
 
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
                if let addNewCell = tableView.dequeueReusableCell(withIdentifier: AddStudentsCells.reuseIdentifier, for: indexPath) as? AddStudentsCells {
                    addNewCell.delegate = self
                    return addNewCell
                }
            default:
                let note = dataSource[indexPath.row]
                if let noteCell = tableView.dequeueReusableCell(withIdentifier: StudentCell.reuseIdentifier, for: indexPath) as? StudentCell {
                    noteCell.configure(shortnote: note)
                        return noteCell
                }
            }
        return UITableViewCell()
    }
}

extension GroupViewController: AddNoteDelegate {
    func newNoteAdded(note: StudentName) {
        dataSource.insert(note, at: 0)
        studentsNames.insert(note.text, at:0)
        tableView.reloadData()    }
    
    func deleteAllCells() {
        dataSource.removeAll()
        studentsNames.removeAll()
        tableView.reloadData()
    }
}

extension GroupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: .none
        ) { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(
            systemName: "trash.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
