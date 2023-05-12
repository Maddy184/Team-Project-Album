//
//  CityCollectionViewController.swift
//  Cities
//
//  Created by Yasar on 29.01.2021.
//

import UIKit
import AVKit

class PhotoCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    // Intialize the variables
    var count = 0
    
    // Declaring the value for the varible using the array value
    private var images : [Photos] = [ Photos(PhotoImages: "Deer", details: "Deer"),
                                      Photos(PhotoImages: "Dog", details: "Dog"),
                                      Photos(PhotoImages: "zebra", details: "zebra"),
                                      Photos(PhotoImages: "Peacock", details: "peacock"),
                                      Photos(PhotoImages: "Earth",details: "video"),
                                      Photos(PhotoImages: "Forest",details: "video"),
                                      Photos(PhotoImages: "song",details: "video"),
                                      Photos(PhotoImages: "horse",details: "horse"),
                                      Photos(PhotoImages: "owl",details: "owl"),
                                      Photos(PhotoImages: "rabbit",details: "rabbit"),
                                      Photos(PhotoImages: "1",details: "1"),
                                      Photos(PhotoImages: "2",details: "3"),
                                      Photos(PhotoImages: "3",details: "3"),
                                      Photos(PhotoImages: "4",details: "4"),
                                      Photos(PhotoImages: "5",details: "5"),
                                      Photos(PhotoImages: "6",details: "6"),
                                      Photos(PhotoImages: "7",details: "7"),
                                      Photos(PhotoImages: "8",details: "8"),
                                      Photos(PhotoImages: "9",details: "9"),
                                      Photos(PhotoImages: "10",details: "10"),
                                      Photos(PhotoImages: "11",details: "11")
    ] // remove this
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = creatingLayout()
        self.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(changingToNextVC))
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = "Album"
    }
    
    @objc func changingToNextVC(){
        
//        let videoLinkVC = UINavigationController(rootViewController: VideoLinkViewController())//VideoLinkViewController()
////        self.navigationController?.pushViewController(videoLinkVC, animated: true)
//        self.present(videoLinkVC, animated: true)
        
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Alert", message: "Enter a video link ", preferredStyle: .alert)

        // Add text field
        dialogMessage.addTextField(configurationHandler: { textField in
            textField.placeholder = ""
        })
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            let me = dialogMessage.textFields?.first?.text
            let vid = VideoPreviewerViewController()
            vid.videoLink = me!
            self.navigationController?.pushViewController(vid, animated: true)
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true)

        
        
        
    }
    // MARK: UICollectionViewDataSource
    // Returning the number of the section
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        let data = images[indexPath.row]
        
        if data.details == "video"{
            
            let videoPreviewVC = VideoPreviewerViewController()
            let dur = videoPreviewVC.videoDurationTimeLabel
            
//            cell.PhotoImage.image = UIImage(named: "Dog")
            let videoURL = URL(fileURLWithPath: "/Users/madesh/Desktop/ZS2025/Video Player/Video/\(data.PhotoImages).mp4")
            let asset = AVAsset(url: videoURL)
            let durationVideo  = Int(CMTimeGetSeconds(asset.duration))
            let totalMinutes1 = durationVideo / 60
            let totalSeconds1 = durationVideo % 60
            let durStart1 = NSString(format: "%d:%02d", totalMinutes1, totalSeconds1) as String

            let imgGenerator = AVAssetImageGenerator(asset: asset)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            
            let time = CMTime(seconds: 1, preferredTimescale: 1)

            
            do {
                // Generate the thumbnail
                let thumbnailCGImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: thumbnailCGImage)
                
                // Use the thumbnail image
                let imageView = UIImageView(image: thumbnail)

                cell.PhotoImage.image = UIImage(cgImage: thumbnailCGImage )
                cell.imageDuration.image = UIImage(systemName: "play.fill")
                print(durStart1)
                cell.videoDurationLabel.text = durStart1
                
                

            }
            catch let error {
                print("Error generating thumbnail: \(error.localizedDescription)")
            }
            
//            cell.PhotoImage.image = UIImage(cgImage: thumbnailCGImage )
        }
        else{
            cell.PhotoImage.image = UIImage(named: data.PhotoImages)
            
        }
        //        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 250, height: 150)
        }
        return CGSize(width: 175, height: 100 )
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ima = images[indexPath.row]
        if ima.details != "video"{
            let imagePreviewVC = imagePreviewViewController()
            self.navigationController?.pushViewController(imagePreviewVC, animated: true)
            imagePreviewVC.animal = images[indexPath.row]
            imagePreviewVC.img = images
            imagePreviewVC.currentIndex = indexPath.row
        }
        else{
            let videoPreviewVC = VideoPreviewerViewController()
            
            self.navigationController?.pushViewController(videoPreviewVC, animated: true)
            videoPreviewVC.animal = ima
            
        }
        
    }
    func creatingLayout() -> UICollectionViewCompositionalLayout{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33333333), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item,item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
        
        return UICollectionViewCompositionalLayout(section: section)
    }

}
