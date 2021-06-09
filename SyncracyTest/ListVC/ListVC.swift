//
//  ListVC.swift
//  SyncracyTest
//
//  Created by Anil on 02/04/21.
//

import UIKit

protocol ListVCLogic: class {
    func displayLogic(viewModel : ListModel.Process.ViewModel)
}

class ListVC: UIViewController, ListVCLogic{
    
    var list : [data]?
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        Language.language = Language.english
        methodForSetUpTableview(tableViewObj : tableView)
        methodForInteractWithJson()
        
    }
    
    func methodForSetUpTableview(tableViewObj : UITableView){
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewObj.register(UINib(nibName: "ListTableviewCell", bundle: nil), forCellReuseIdentifier: "ListTableviewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
        view.addSubview(tableViewObj)
        tableViewObj.frame = view.bounds
    }
    
    var interactor: ListBusinessLogic?
    var router: ListRoutingLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp(){
        
        let viewController = self
        let interactor = ListInteractor()
        let router = ListRouter()
        let presenter = ListPresenter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        
    }
    
    func methodForInteractWithJson(){
        Spinner.start(from: self.view)
        let request = ListModel.Process.Request(type : "json")
        interactor?.List(request: request, languageType: Language.language.rawValue, countryType: "in", email: "jbrown%40twr.ca")
    }
    
    func displayLogic(viewModel: ListModel.Process.ViewModel) {
        DispatchQueue.main.async {
            Spinner.stop()
            if !viewModel.success{
                self.tableView.isHidden = true
                self.list = []
                self.tableView.reloadData()
            }else{
                self.tableView.isHidden = false
                self.list = (viewModel.list?.data ?? []).filter({$0.cId! % 2 == 0})
                self.tableView.reloadData()
            }
        }
    }
    
}
extension ListVC : UITableViewDelegate, UITableViewDataSource, ListHeaderViewDelegate{
    
    func listToChangeInOtheranguage() {
        
        CommonClass.shared.methodForShow(vc: self) { (value) in
            self.methodForInteractWithJson()
            let window = self.view.superview
            self.view.removeFromSuperview()
            window?.addSubview(self.view)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        header.delegate = self
        header.changeLanBtn.setTitle("Changelanguage".localized, for: .normal)
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableviewCell") as? ListTableviewCell
        if list != nil{
            cell?.displayContent(item : list![indexPath.row])
        }
        
        if cell != nil{
            return cell!
        }
        return UITableViewCell()
    }
    
}
