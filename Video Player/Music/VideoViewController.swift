////
////  VideoViewController.swift
////  Video Player
////
////  Created by Madesh on 10/04/23.
////
//
//import UIKit
//import CoreData
//import AVKit
//
//private let reuseIdentifier = "Cell"
//
//
//
//class VideoViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
//
//    @IBOutlet weak var collectionView: UICollectionView!
//
//    private var images : [Photos] = [ Photos(PhotoImages: "Deer", details: "Deer"),
//                                      Photos(PhotoImages: "Dog", details: "Dog"),
//                                      Photos(PhotoImages: "zebra", details: "zebra"),
//                                      Photos(PhotoImages: "Peacock", details: "Peacock"),
//                                      Photos(PhotoImages: "lion",details: "lion")]
//
//    public let video = ["Earth","Forest"]
//
//
//
//    @IBAction func VideoButtonTapped(_ sender: Any) {
//        videoPlaying()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return video.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for:indexPath ) as! CollectionViewCell
//
//        return cell
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        collectionView.dataSource = self
////        collectionView.delegate = self
//
////        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
////
//    }
//
//    func videoPlaying(){
//        guard let videoPath = Bundle.main.path(forResource: "Earth", ofType: "mp4") else { return}
//        let videoURL = URL(fileURLWithPath: videoPath)
//        let player = AVPlayer(url: videoURL)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        present(playerViewController, animated: true) {
//            player.play()
//        }
//
//    }
//}
//// Hello buddy this is the sound of the work from the code flow of the tree that which we have to done this from the certain main things which are the custom work
////work force from the machine things fo the
////private let reuseIdentifier = "Cell"
////
////class PhotoCollectionViewController: UICollectionViewController {
////
//////    @IBAction func unwindToMain(segue: UIStoryboardSegue){
//////
//////    }
////
////    private var images : [Photos] = [ Photos(PhotoImages: "Deer", details: "Deer"),
////                                      Photos(PhotoImages: "Dog", details: "Dog"),
////                                      Photos(PhotoImages: "zebra", details: "zebra"),
////                                      Photos(PhotoImages: "Peacock", details: "Peacock"),
////                                      Photos(PhotoImages: "lion",details: "lion")
////]
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////    }
////
////    // MARK: UICollectionViewDataSource
////
////    override func numberOfSections(in collectionView: UICollectionView) -> Int {
////        // #warning Incomplete implementation, return the number of sections
////        return 1
////    }
////
////
////    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        // #warning Incomplete implementation, return the number of items
////        return images.count
////    }
////
////    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! PhotoCollectionViewCell
////
////        // Configure the cell
////
////        let data = images[indexPath.row]
////        cell.PhotoImage.image = UIImage(named: data.PhotoImages)
//////        cell.PhotoDetails.text = data.details
////
////        return cell
////    }
////
////
////
////
////
////
////
////
////
////
