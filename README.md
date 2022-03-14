# MVVMForIS

## Technologies
`Generics`: This is being used for communication between ViewModel and ViewController
`Closures`: This is being used for network communications
`KeyChain`: This is used for managing secure user authentication
`CoreData`: This is being used for storing data persistently.

### ViewController under MVVM

`Reduced complexity`: LoginViewController is now much simpler.

`Specialized`: LoginViewController not dependand on any model types and only focuses on the view.

`Separated`: LoginViewController only interacts with the LoginViewModel by sending inputs, such as getAuthentication, or binding to its outputs.

`Expressive`: LoginViewModel separates the business logic from the low level view logic.

`Maintainable`: It’s simple to add a new feature with minimal modification to the LoginViewController.

`Testable`: The LoginViewModel is relatively easy to test.

However, there are some trade-offs to MVVM that you should consider:

`Extra type`: MVVM introduces an extra view model type to the structure of the app.

`Binding mechanism`: It requires some means of data binding, in this case the Box type.

`Boilerplate`: You need some extra boilerplate to implement MVVM.

`Memory`: You must be conscious of memory management and memory retain cycles when introducing the view model into the mix.
