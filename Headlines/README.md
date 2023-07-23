1. what were the priorities, and why?


Add the required functionality
Decouple the code following MVVM design pattern
Make the codebase testable
Simplify the logic removing constant and static functionality
Refactor network layer with generic response to make it reusable
Handling error response in cleaner way
Separate storage handler, to fetch data from data store
Add some unit test with mock data store and network manager

Presently implemented functionality -
Storyboard UI
Page swipe
Add/remove articles to favorite
Stored favorites in database to show on app relaunch
Favorite button state with animation
Search

2. if I had another two days, what would I have tackled next?


Improve the page swipe functionality  
Add few more unit tests and UI tests
Add more specific error handling
Separate the reusable functionality in the code
Add loading/error/empty article or favorite screen where needed with retry mechanism

3. what would I change about the structure of the code?


Because the target is iOS 12, implemented the feature supported on iOS 12. Otherwise could have used SwiftUI and Async await
As its a simple project, here it might not be necessary. But definitely the network layer and data store handler can be improved with more decoupled generic way
More decoupled and exact mapping with data model and UI layer
It would be great if we could parse an article id to uniquely identify each article
Handling of more specific error scenario
Add accessibility and more tests 


4. what would I change about the visual design of the app?


The favorite buttons are at the end of each page, may be that can be placed in a way it can always be visible
The title color is white, but in white background it is not visible
Improved page swipe functionality, presently in the UI it is not clear this is swipable
Improved UI on the fovorite screen with alignment of icon image and add loading indicator when image is loading. For loading failed, show placeholder image.
Improvement on text alignment and top bar
As we are already storing the data through realm, would be quite simple to add offline support. 
Add error view with retry mechanism, empty state view
Remove article from favorite table cell

5. Approximately how long I spent on this project.


Overall approx 3 hours, but not at a stretch 
