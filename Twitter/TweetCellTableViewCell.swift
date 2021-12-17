//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by AJM on 10/12/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favourited:Bool = false
    var tweetId:Int = -1
    
    
    func setFavourite(_ isFavourited: Bool){
        favourited = isFavourited
        if (favourited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func favouriteTweet(_ sender: Any) {
        let tobeFavourited = !favourited
        if (tobeFavourited){
            TwitterAPICaller.client?.favouriteTweet(tweetId: tweetId, success: {
                self.setFavourite(true)
            }, failure:{Error in
                print(Error.localizedDescription)
                
            })
        }else{
            TwitterAPICaller.client?.unfavouriteTweet(tweetId: tweetId, success: {
                self.setFavourite(false)
            }, failure:{Error in
                print(Error.localizedDescription)
                
            })
        }
    }
    func setRetweeted(_ isRetweeted:Bool){
        if (isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.reTweet(tweetId: tweetId, success:{
            self.setRetweeted(true)
        }, failure: {Error in print(Error.localizedDescription)
        })
    }
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
