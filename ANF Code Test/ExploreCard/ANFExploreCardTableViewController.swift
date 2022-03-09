//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {

    private let viewModel = ANFExploreCardTableViewModel()
    private let alertPresenter: AlertPresenter_Proto = AlertPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ExploreContentCell", bundle: nil), forCellReuseIdentifier: "ExploreContentCell")
        tableView.register(UINib(nibName: "ExploreFullPhotoContentCell", bundle: nil), forCellReuseIdentifier: "ExploreFullPhotoContentCell")

        self.title = viewModel.title
        loadExploreData()
    }
    
    private func loadExploreData() {
        viewModel.fetchFeedElements { [unowned self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.update()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.display(error: error)
                }
            }
        }
    }
    
    private func update() {
        tableView.reloadData()
    }
    
    private func display(error: Error) {
        alertPresenter.present(from: self,
                               title: "Unexpected Error",
                               message: "\(error.localizedDescription)",
                               dismissButtonTitle: "OK")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feedElements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = viewModel.feedElements[indexPath.row]
        
        switch element.feedType {
        case .fullItem:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreContentCell", for: indexPath) as? ExploreContentCell {
                cell.model = element
                return cell
            }
        case .fullPhotoItem:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreFullPhotoContentCell", for: indexPath) as? ExploreFullPhotoContentCell {
                cell.model = element
                return cell
            }
        }
        return UITableViewCell()
    }
}
