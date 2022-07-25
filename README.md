# robin_book
Flutter test project that implements Clean Architecture with MVVM and Unit testing.

This app consist of a book finder where the user can save books as favorites. The books info is powered by [Open Library](https://openlibrary.org/developers/api/ "Open Library").
- For the ui state management the app makes use of [Provider](https://pub.dev/packages/provider "Provider"), using change notifiers for updating the value of observables, which are observed by consumers and selectors. Look at the guide for simple [state management](https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple) for more info.
- In order to keep things clean, the code is distributed on three main layers: the UI, the domain, and the data.
- The UI is separated onto two sublayers, the user interface itself (widgets) and the state management.
- The domain layer contains the class models, the use cases (interactors), and the repositories. For parsing the api json responses into our model classes we use the [Json Serializable](https://pub.dev/packages/json_serializable "Json Serializable") package.
- The data layer consist of two datasources, the remote datasource, for fetching info from the network, and the local datasource, for storing the info in a local database as a cache mecanism. For the local database the app makes use of [Drift](https://pub.dev/packages/drift "Drift").
- For version control [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) is used.

In order to run this project, Flutter version must be 2.10.2 or above on Channel stable.
