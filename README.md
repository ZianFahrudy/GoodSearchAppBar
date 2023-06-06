<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Good Search AppBar
AppBar with Animation SearchBar.

# Preview
https://github.com/ZianFahrudy/GoodSearchAppBar/assets/45583824/872a818e-c3bb-4d48-8abf-20c6aab4cd48

## Installation

In the `pubspec.yaml` of your flutter project, add the following dependency:

``` yaml
dependencies:
  ...
  good_search_appbar: ^0.0.1
```

## Basic example

``` dart
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoodSearchAppBar(
        title: 'Search',
        onSearchChanged: (query) {
          log(query);
        },
      ),
      body: const Center(
        child: Text('Search Page'),
      ),
    );
  }
}

```

## Atribut
![atribut](https://github.com/ZianFahrudy/GoodSearchAppBar/assets/45583824/a3c97bd2-e34d-44ae-92ab-736d1ead9059)

## Issues & Suggestions
If you encounter any issue you or want to leave a suggestion you can do it by filling an [issue](https://github.com/ZianFahrudy/GoodSearchAppBar/issues).

### Thank you for the support!
