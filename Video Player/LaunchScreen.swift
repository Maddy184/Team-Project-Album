//
//  LaunchscreenViewController.swift
//  Video Player
//
//  Created by Madesh on 11/05/23.
//

import UIKit

class LaunchscreenViewController: UIViewController {

    let screenView:UIView = UIView()
    let logoImageView:UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        screenView.translatesAutoresizingMaskIntoConstraints = false
        screenView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0) .isActive = true
        screenView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0) .isActive = true
        screenView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0) .isActive = true
        screenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0) .isActive = true
        
        view.addSubview(screenView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        logoImageView.image = UIImage(named: "Image")
        view.addSubview(logoImageView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
