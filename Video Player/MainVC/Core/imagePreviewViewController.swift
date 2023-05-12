//
//  imagePreviewViewController.swift
//  Video Player
//
//  Created by Madesh on 17/04/23.
//

import UIKit
import AVKit

class imagePreviewViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    var animal = Photos()
    var nextImage = Photos()
    var img = [Photos]()
    var currentIndex = 0
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    var PlayingButton:UIButton = UIButton()
    var imageView:UIImageView = UIImageView()
    var buttonPlay:UIButton = UIButton()
    var scrollView:UIScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        scrollView.delegate = self
        let leftswipeGesture = UISwipeGestureRecognizer(target:self, action: #selector(leftSwipeGesture(_:)))
        let rightswipeGesture = UISwipeGestureRecognizer(target:self, action: #selector(rightSwipeGesture(_:)))
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.delaysTouchesBegan = true
        doubleTapGesture.delegate = self
        view.addGestureRecognizer(doubleTapGesture)
        leftswipeGesture.direction = .left
        rightswipeGesture.direction = .right
        self.view.addGestureRecognizer(leftswipeGesture)
        self.view.addGestureRecognizer(rightswipeGesture)
        imageView.image = UIImage(named: animal.PhotoImages )
        //        playbuttonAction()
        buttonPlay.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func VideoPlayButtonTaped(_ sender: Any) {
        avplayerControl()
        print("ButtonTapped")
        print(img[currentIndex].details)
    }
    func avplayerControl(){
        guard let videoURL = Bundle.main.url(forResource: "Earth", withExtension: "mp4") else { return }
        //                print(animal?.details)
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player.play()
    }
    func loadImageFile() {
        imageView.image = UIImage(named: img[currentIndex].PhotoImages )
        
        if img[currentIndex].details == "video"{
            buttonPlay.isHidden = false
        }else{
            buttonPlay.isHidden = true
        }
    }
    
    @objc func leftSwipeGesture (_ gesture: UISwipeGestureRecognizer) {
        if scrollView.zoomScale == 1{
            if gesture.direction == .left{
                print("Hello Left")
                print(img[currentIndex].details)
                currentIndex += 1
                if currentIndex >= img.count {
                    currentIndex = 0
                }
                loadImageFile()
            }
        }
    }
    
    @objc func rightSwipeGesture (_ gesture: UISwipeGestureRecognizer) {
        if scrollView.zoomScale == 1{
            if gesture.direction == .right{
                print("Hello Right")
                currentIndex -= 1
                if currentIndex < 0 {
                    currentIndex = img.count - 1
                }
                loadImageFile()
            }
        }
    }
    
    @objc func doubleTap (_ gesture: UITapGestureRecognizer){
        
        print("Hello Double Tapped")
        if scrollView.zoomScale > 1{
            scrollView.setZoomScale(1, animated: true)
            
        }
    }
    @objc func playbuttonAction(_ sender : UIButton){
        if animal.details == "video"{
            buttonPlay.isHidden = false
            avplayerControl()
        }else{
            buttonPlay.isHidden = true
        }
        
    }
    func setup(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = false
        self.view.addSubview(scrollView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.setImage(UIImage(systemName: "play.fill"), for: .normal)
        buttonPlay.addTarget(self, action: #selector(playbuttonAction), for: .touchUpInside)
        self.view.addSubview(buttonPlay)
        
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                                     scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                                     scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                     scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                                     imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                                     imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                     imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                                     imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                                     imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
                                     buttonPlay.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                                     buttonPlay.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)])
    }
}
extension imagePreviewViewController:UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


