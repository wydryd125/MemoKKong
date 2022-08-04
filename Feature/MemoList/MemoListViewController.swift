//
//  MemoListViewController.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NSObject_Rx

enum CellType: Int {
    case add = 0
    case notice = 1
    case memo = 2
}

final class MemoListViewController: BaseViewController, ViewModelBindableType {
    
    // MARK: - Property
    
    private let mainView = MemoListView()
    private let bag = DisposeBag()
    
    var viewModel: MemoListViewModel!
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.setNavigation(hidden: true, title: nil)
    }
    
    
    // MARK: - Interface
    func bindViewModel() {
        loadViewIfNeeded()
        
        self.bind()
        self.setTableView()
        
        self.viewModel.getMemoList()
        self.mainView.listTableView.reloadData()
        
    }
    
    private func bind() {
        
        // MARK: - Input
        
        // MARK: - Output
        
        self.viewModel.output.goToDetail
            .observe(on: MainScheduler.instance)
            .bind(onNext:{ [weak self] _ in
                let detailVC = MemoDetailViewController()
                self?.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: bag)
        
        self.viewModel.output.showMemoList
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] _ in
                self?.mainView.listTableView.reloadData()
            })
            .disposed(by: bag)
        
    }
    
    private func setTableView() {
        let tableView = self.mainView.listTableView
        
        tableView.register(MemoAddTableViewCell.self, forCellReuseIdentifier: MemoAddTableViewCell.identifier)
        
        tableView.register(NoticeMemoTableViewCell.self, forCellReuseIdentifier: NoticeMemoTableViewCell.identifier)
        
        tableView.register(MemoListTableViewCell.self, forCellReuseIdentifier: MemoListTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    
    private func goToCompose() {
        self.setNavigation(hidden: false, title: "")
        let composeViewModel = MemoComposeViewModel(title: "새 메모", sceneCoordinator: self.viewModel.sceneCoordinator, storage: self.viewModel.storage)
        
        let composeScene = Scene.compose(composeViewModel)

        self.viewModel.sceneCoordinator.transition(to: composeScene, using: .push, animated: true)
    }
    
    // 물어보자 MVVM-C vc 이동 간에 어떤 방식으로 데이터를 전달해야할까?
    // 현재 메모 리스트 중 한가지의 메모를 선택하면 해당 메모를 디테일 뷰컨으로 넘겨야 하는데 방법을 모르겠음...
    private func gotoDetail(memo: Memo) {
        self.setNavigation(hidden: false, title: "")
        
        let detailViewModel = MemoDetailViewModel(title: "", sceneCoordinator: self.viewModel.sceneCoordinator, storage: self.viewModel.storage)
        
        let detailScene = Scene.detail(detailViewModel)
        
        self.viewModel.sceneCoordinator.transition(to: detailScene, using: .push, animated: true)

    }
}

// MARK: - UICollectionViewDataSource
extension MemoListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.noticeMemoList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoticeMemoCollectionViewCell.identifier, for: indexPath) as? NoticeMemoCollectionViewCell else { return UICollectionViewCell() }
        
        if let memo = viewModel.noticeMemoList?[indexPath.row] {
            cell.drawCell(memo :memo)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let memo = viewModel.noticeMemoList?[indexPath.row] {
            gotoDetail(memo: memo)
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension MemoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width / 2.0)
        
        return CGSize(width: width, height: 140)
    }
}

// MARK: - UITableViewDataSource
extension MemoListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case CellType.add.rawValue:
            return 1
        case CellType.notice.rawValue:
            return 1
        case CellType.memo.rawValue:
            return viewModel.memoList?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case CellType.add.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoAddTableViewCell.identifier, for: indexPath) as? MemoAddTableViewCell else { return UITableViewCell() }
        
            cell.selectionStyle = .none
            
            return cell
            
        case CellType.notice.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeMemoTableViewCell.identifier, for: indexPath) as? NoticeMemoTableViewCell else { return UITableViewCell() }
            cell.noticeCollectionView.delegate = self
            cell.noticeCollectionView.dataSource = self
            cell.noticeCollectionView.register(NoticeMemoCollectionViewCell.self, forCellWithReuseIdentifier: NoticeMemoCollectionViewCell.identifier)
            
            cell.isSelected = false
            cell.noticeCollectionView.reloadData()

            return cell
            
        case CellType.memo.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.identifier, for: indexPath) as? MemoListTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            cell.drawCell(memo: viewModel.memoList?[indexPath.row])
            
            return cell
            
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 24, y: 8, width: 320, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 20)
        myLabel.textColor = .customLightGrayColor
        myLabel.text = "2022"
        
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return section != CellType.memo.rawValue || viewModel.memoList?.isEmpty == true ? nil : headerView
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.storage.delete(memo: self.viewModel.memoList![indexPath.row])
            self.viewModel.getMemoList()
            self.mainView.listTableView.reloadData()
            
            completionHandler(true)
            
        }
        
        deleteAction.image = UIImage(named: "deleteWhite.png")?.addBackgroundCircle(.customDeepPinkColor)
        deleteAction.backgroundColor = .backgroundColor
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return indexPath.section == CellType.memo.rawValue ? configuration : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == CellType.memo.rawValue ? 40 : .zero
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case CellType.add.rawValue:
            return 40
        case CellType.notice.rawValue:
            return viewModel.noticeMemoList?.isEmpty == true ?? 0 : 160
        case CellType.memo.rawValue:
            return 100
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case CellType.add.rawValue:
            goToCompose()

        case CellType.memo.rawValue:
            if let memo = viewModel.memoList?[indexPath.row] {
                gotoDetail(memo: memo)
            }
            
        default:
            break
        }
    }
}

//extension MemoListViewController: MemoAddTableViewCellDelegate {
//    func didTapCreateButton() {
//        goToCompose()
//    }
//}
