# Loading-View
A circle animation for loading used. (Swift 4, iOS 11, Xcode 9)

# Result
![image][resultA]
![image][resultB]

# How to using
Define a MLLoadingViewController as below:

```
//Loading view with text
let loadViewController = MLLoadingViewController(text: "Just Wait...")
```
```
//Loading view without text
let loadViewController = MLLoadingViewController()
```

### Start animation
Using `present` method to present loading view controller.
```
present(loadViewController, animated: true)
```

### Stop animation
Using `dismiss` method to dismiss loading view controller.
```
loadViewController.dismiss(animated: true)
```

[resultA]:https://github.com/JohnnyMilk/Loading-View/blob/master/Loading%20with%20text.gif
[resultB]:https://github.com/JohnnyMilk/Loading-View/blob/master/Loading%20without%20text.gif
