//
//  BRActivityIndicator.swift
//  Booker
//
//  Created by Kryg Tomasz on 14.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import MBProgressHUD

final class BRActivityIndicator {
    
    private init() {}
    
    static let shared = BRActivityIndicator()
    private var progressHUD : MBProgressHUD = MBProgressHUD()
    private weak var navigationController: UINavigationController?
    
    func prepare(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showActivityIndicator(title: String) {
        if let navController = self.navigationController {
                self.progressHUD = MBProgressHUD.showAdded(to: navController.view, animated: true)
                self.progressHUD.mode = MBProgressHUDMode.indeterminate
                self.progressHUD.label.text = title
                self.progressHUD.activityIndicatorColor = UIColor.black
                self.progressHUD.label.textColor = UIColor.black
                //            progressHUD.detailsLabelColor = UIColor.black
                //            progressHUD.detailsLabelFont = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
                //            progressHUD.detailsLabelText = detailsLabelText
                //            progressHUD.color = UIColor.whiteColorWithAlpha(0.9)
                self.progressHUD.dimBackground = true
                //            progressHUD.minSize = CGSize(width: 300,height: 90)
        }
    }
    
    func hideActivityIndicator(success: Bool) {
        if success {
            DispatchQueue.main.async{ [weak self] in
                self?.progressHUD.hide(animated: true)
            }
        } else {
            DispatchQueue.main.async{ [weak self] in
                self?.progressHUD.mode = MBProgressHUDMode.customView
                self?.progressHUD.label.text = "booksDownloadError".localized()
            }
            let delayTime = DispatchTime.now() + .seconds(3)
            DispatchQueue.main.asyncAfter(deadline: delayTime) { [weak self] in
                self?.progressHUD.hide(animated: true)
            }
        }
    }
    
}
