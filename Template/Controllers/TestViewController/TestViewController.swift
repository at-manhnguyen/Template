//
//  TestViewController.swift
//  Template
//
//  Created by Nguyen Quang Manh on 3/22/18.
//  Copyright © 2018 Vinmas. All rights reserved.
//

import UIKit
import SwiftUtils
import ESTabBarController_swift

enum TemplateType: Int {
    case previewPhoto = 0
    case introduce
    case tabbar
    
    var titleText: String {
        switch self {
        case .previewPhoto:
            return "Preview Photo"
        case .introduce:
            return "Introduce"
        case .tabbar:
            return "Tabbar Animation"
        }
    }
    
    static let count: Int = {
        var max = 0
        while let _ = TemplateType.init(rawValue: max) {
            max += 1
        }
        return max
    }()
}

class TestViewController: BaseViewController {

    // MARK: - Define
    
    // MARK: - UI
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Data
    
    // MARK: - Method
    // MARK: Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    // MARK: SetupUI
    private func setupUI() {
        // Setup TableView
        tableView.register(TestTableViewCell.self)
    }
    // MARK: SetupData
    private func setupData() {
        
    }
    
    // MARK: Method
    private func setupTabbarController() {
        
        // Setup Tabbar Controller
        let tabbarController = ESTabBarController()
        tabbarController.tabBar.barTintColor = Colors.MainColor
        
        // setup action for center button
        tabbarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        tabbarController.didHijackHandler = {
            [weak tabbarController] tabBarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
                alertController.addAction(takePhotoAction)
                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
                alertController.addAction(selectFromAlbumAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                tabbarController?.present(alertController, animated: true, completion: nil)
            }
        }
        
        
        let homeViewController = HomeViewController()
        let homeItem = ESTabBarItem(TabBarItemContentView(), title: "Home", image: #imageLiteral(resourceName: "ic_tb_home"), selectedImage: #imageLiteral(resourceName: "ic_tb_home"), tag: 0)
        homeViewController.tabBarItem = homeItem
        
        let locationViewController = PhotoPreviewViewController()
        let locationItem = ESTabBarItem(TabBarItemContentView(), title: "Định vị", image: #imageLiteral(resourceName: "ic_tb_location"), selectedImage: #imageLiteral(resourceName: "ic_tb_location"), tag: 1)
        locationViewController.tabBarItem = locationItem
        
        let bookViewController = IntroduceViewController()
        let bookItem = ESTabBarItem(IrregularityTabBarItemContentView(), title: nil, image: #imageLiteral(resourceName: "ic_tb_center"), selectedImage:#imageLiteral(resourceName: "ic_tb_center"), tag: 2)
        bookViewController.tabBarItem = bookItem
        
        let historyViewController = IntroduceViewController()
        let historyItem = ESTabBarItem(TabBarItemContentView(), title: "Lịch sử", image: #imageLiteral(resourceName: "ic_tb_history"), selectedImage: #imageLiteral(resourceName: "ic_tb_history"), tag: 3)
        historyViewController.tabBarItem = historyItem
        
        let moreViewController = PhotoPreviewViewController()
        let moreItem = ESTabBarItem(TabBarItemContentView(), title: "Thêm", image: #imageLiteral(resourceName: "ic_tb_more"), selectedImage: #imageLiteral(resourceName: "ic_tb_more"), tag: 4)
        moreViewController.tabBarItem = moreItem
        
        
        tabbarController.viewControllers = [homeViewController, locationViewController, bookViewController, historyViewController, moreViewController]
        present(tabbarController, animated: true, completion: nil)
    }
    
    // MARK: - Action
    
}

extension TestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TemplateType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TestTableViewCell.self)
        if let templateType = TemplateType.init(rawValue: indexPath.row) {
            cell.title.text = templateType.titleText
        }
        return cell
    }
}

extension TestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let templateType = TemplateType.init(rawValue: indexPath.row) else { return }
        switch templateType {
        case .previewPhoto:
            let previewPhotoViewController = PhotoPreviewViewController()
            present(previewPhotoViewController, animated: true, completion: nil)
        case .introduce:
            let introduceViewController = IntroduceViewController()
            present(introduceViewController, animated: true, completion: nil)
        case .tabbar:
            setupTabbarController()
        }
    }
}
