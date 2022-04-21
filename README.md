# robin_book
Flutter test project that implements MVVM architecture pattern, Repository pattern, and Unit testing.

This app consist of a book finder. The books info is powered by [Open Library](https://openlibrary.org/developers/api/ "Open Library").
- For the ui state management the app makes use of [Provider](https://pub.dev/packages/provider "Provider").
- In order to keep things clean, the data layer is separated in two sublayers, the repository, and the datasource. The app have two datasources, one for fetching info from the network and another one for storing the favorite books in a local database. For the local database the app makes use of [Drift](https://pub.dev/packages/drift "Drift").
- In the domain layer, we define the classes for our models. For parsing the api json responses in our models classes we use the [Json Serializable](https://pub.dev/packages/json_serializable "Json Serializable") package.

In order to run this project, I recommend to use Android Studio Bumblebee (4.1) or above, and Flutter version must be 2.10.2 or above on Channel stable.