# Headlines

## What were the priorities, and why?


1. Add the required functionality
2. Decouple the code following MVVM design pattern
3. Make the codebase testable
4. Simplify the logic removing constant and static functionality
5. Refactor network layer with generic response to make it reusable
6. Handling error response in cleaner way
7. Separate storage handler, to fetch data from data store
8. Add some unit test with mock data store and network manager

Presently implemented functionality -
1. Storyboard UI
2. Page swipe
3. Add/remove articles to favorite
4. Stored favorites in database to show on app relaunch
5. Favorite button state with animation
6. Search

## If I had another two days, what would I have tackled next?

1. Improve the page swipe functionality
2. Add few UI tests
3. Add more specific error handling
4. Add loading/error/empty article or favorite screen where needed with retry mechanism

## What would I change about the structure of the code?


1. Because the target is iOS 12, implemented the feature supported on iOS 12. Otherwise could have used SwiftUI and Async await
2. As its a simple project, here it might not be necessary. But definitely the network layer and data store handler can be improved with more decoupled generic way
3. More decoupled and exact mapping with data model and UI layer
4. It would be great if we could parse an article id to uniquely identify each article
5. Handling of more specific error scenario
6. Add accessibility and more tests 


## What would I change about the visual design of the app?


1. The favorite buttons are at the end of each page, may be that can be placed in a way it can always be visible
2. The title color is white, but in white background it is not visible
3. Improved page swipe functionality, presently in the UI it is not clear this is swipable
4. Improved UI on the fovorite screen with alignment of icon image and add loading indicator when image is loading. For loading failed, show placeholder image.
5. Improvement on text alignment and top bar
6. As we are already storing the data through realm, would be quite simple to add offline support.
7. Add error view with retry mechanism, empty state view
8. Remove article from favorite table cell

## Approximately how long I spent on this project.


1. Overall approx 3 hours, but not at a stretch 
