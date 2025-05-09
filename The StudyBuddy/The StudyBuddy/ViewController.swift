//
//  ViewController.swift
//  The StudyBuddy
//
//  Created by Arvin on 5/7/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the SwiftUI View
        let mainView = TabBarView()

        // Embed it using UIHostingController
        let hostingController = UIHostingController(rootView: mainView)

        // Add as child view controller
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
