//
//  VideoLinkViewController.swift
//  Video Player
//
//  Created by Madesh on 08/05/23.
//

import UIKit

class VideoLinkViewController: UIViewController {

    var inputBox:UITextField = UITextField()
    var label:UILabel = UILabel()
    var confirmButton:UIButton = UIButton()
    var mediaLink = String()
    
    let videoController = VideoPreviewerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.titleView?.tintColor = .black

        // Do any additional setup after loading the view.
    }
    
    func setup(){
        inputBox.translatesAutoresizingMaskIntoConstraints = false
//        inputBox.text = mediaLink
        inputBox.backgroundColor = .black
        inputBox.textColor = .white
        
        label.text = "Enter Your Video link "
        label.textColor = .black
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.addTarget(self, action: #selector(videoDataPassing), for: .touchUpInside)
        confirmButton.setTitle("Submit", for: .normal)
        confirmButton.backgroundColor = .black
        self.view.addSubview(label)
        self.view.addSubview(inputBox)
        self.view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0), label.heightAnchor.constraint(equalToConstant: 30),label.widthAnchor.constraint(equalToConstant: 200) ,inputBox.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 20),inputBox.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 0),inputBox.heightAnchor.constraint(equalToConstant: 30), inputBox.widthAnchor.constraint(equalToConstant: 200), confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 0),confirmButton.topAnchor.constraint(equalTo: inputBox.bottomAnchor,constant: 20)])
    }
    
    @objc func videoDataPassing(){
        guard let media = inputBox.text else{return}
        videoController.videoLink = media
//        dismiss(animated: true)
        self.navigationController?.pushViewController(videoController, animated: true)
    }
    
    

}
