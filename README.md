<h1 align=center>Arslan Kaan AYDIN  Mobilium Case</h1> 

I model the data I got from a movie database site and transferred it to the application with Alamofire. I created a detail page for the movies and showed the pictures by downloading them with Kingfisher. I made the auto layout of the application programmatically with Snapkit. I hope you like.

## Technologies
+ MVVM Architecture ✅ 
+ Programmatically ✅ 
+ CocoaPods for 3rd Party Libraries✅
+ Kingfisher ✅ 
+ Alamofire ✅
+ SnapKit ✅
+ Scroll View ✅ 
+ Collection View ✅
+ Table View ✅
+ Pull to Refresh ✅

## Demo

![giphy](https://user-images.githubusercontent.com/44496296/174503900-2239129c-7992-4bc6-8f82-368a21e5077e.gif)
![giphy-2](https://user-images.githubusercontent.com/44496296/174503904-18e48df6-25ef-4179-9fc4-93e137ed054c.gif)

## API

UpComingMovies: https://api.themoviedb.org/3/movie/upcoming?api_key="YOUR_API_KEY"

NowPlayingMovies: https://api.themoviedb.org/3/movie/now_playing?api_key="YOUR_API_KEY"

```swift
{
    class NetworkConstant{
        
        enum MovieServiceEndPoint: String {
            
        case BASE_URL = "https://api.themoviedb.org"
        case API_KEY = "YOUR_API_KEY"
        case IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w1280"
            
            static func fetchUpComingMovies() -> String {
                "\(BASE_URL.rawValue)/3/movie/upcoming?api_key=\(API_KEY.rawValue)"
            }
            
            static func fetchNowPlayingMovies() -> String {
                "\(BASE_URL.rawValue)/3/movie/now_playing?api_key=\(API_KEY.rawValue)"
            }
            
            static func fetchMovieDetail(movieID: Int) -> String {
                "\(BASE_URL.rawValue)/3/movie/\(movieID)?api_key=\(API_KEY.rawValue)"
            }
            
        }
    }
}
```
