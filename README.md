# Introduction

This is movie shower that uses [RottenPotatoes](http://www.rottentomatoes.com/) API for fetching top ten box office movies. User can save movies as favorites for online viewing. App works supports both orientations on iPad and iPhone.

# Design

For storing favorites movies application uses CoreData - just for proof of my CoreData skills ;). Movie data stores as serialized dictionary in data field, and serialized poster image in another data field - it isn't best way, but works in our case.

For displaying of detail movie information app uses `UIWebView`. I would prefer to display movie poster image in that WebView too, but code challenge requires to use `UIScrollView`, so app has ScrollView with that WebView and poster `UIImageView`  

# Requirements

Project uses [MagicalRecord](https://github.com/magicalpanda/MagicalRecord), [SVProgressHUD](https://github.com/samvermette/SVProgressHUD), [AFNetworking](https://github.com/AFNetworking/AFNetworking). They all are in `libs` directory as git submodules.
