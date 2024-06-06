# Zealgrid

Zealgrid is a Flutter package that provides a convenient way to access and retrieve data from a Firebase Realtime Database. It simplifies the process of fetching data from the database and allows you to access the data using a hierarchical path structure.

## Features

- Retrieve data from a Firebase Realtime Database using a hierarchical path structure.
- Support for retrieving data of different types, including strings, integers, booleans, maps, and lists.
- Dynamic getter methods and square bracket notation for easy access to nested data.
- Automatic data caching to improve performance and reduce unnecessary database calls.

## Getting started

To use the Zealgrid package, follow these steps:

1. Add the `zealgrid` package to your project's dependencies in the `pubspec.yaml` file:

```yaml
dependencies:
  zealgrid: ^1.0.0
  ```

Import the zealgrid package in your Dart code:
Initialize the Zealgrid instance with the desired path:
Zealgrid zealgridConstant = Zealgrid.getInstance(path: 'app');

## Usage
Here are a few examples of how to use the Zealgrid package to retrieve data from a Firebase Realtime Database:
Retrieving data using dynamic getter methods

String? content = await zealgridConstant.x.y.z.getString('content');
String? heading1 = await zealgridConstant.x.y.x.getString('heading_1');
String? heading2 = await zealgridConstant.x.y.z
getString('heading_2');

Retrieving data using the getValue method

String? content = await zealgridConstant.getValue('x/y/z/content');
String? heading1 = await zealgridConstant.getValue('x/y/z/heading_1');
String? heading2 = await zealgridConstant.getValue(x/y/z/heading_2');
Make sure to replace 'app' and'x,y,z' with the actual path to your Firebase Realtime Database data.

## Additional information
For more information and advanced usage, please refer to the API documentation.
If you encounter any issues or have suggestions for improvements, please file an issue on the GitHub repository.
Contributions are welcome! If you would like to contribute to the Zealgrid package, please see the contribution guidelines.

For any questions or inquiries, please contact the package author at manipoint@gmail.com.com.