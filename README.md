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

![giphy-2](https://user-images.githubusercontent.com/44496296/174503487-99a71f74-ff8d-4df2-b705-20bf5bf70d7c.gif)

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
