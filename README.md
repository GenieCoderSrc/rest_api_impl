# rest_api_impl

A Dart package providing a robust REST API service implementation, including HTTP request handling, CRUD operations, and file management.

## Features
- Dependency injection-based service registration
- HTTP methods: GET, POST, PUT, PATCH, DELETE
- Response handling with error management
- File upload and deletion support
- Configurable base URL and API key

## Installation
Add the following dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  rest_api_impl: latest_version
```

## Usage
### Register Services
```dart
void main() {
  restApiServiceGetItRegister();
}
```

### Make API Calls
#### CRUD Operations
```dart
final restApiService = sl<IRestApiCrudService>();

// Create Data
restApiService.addData(
  endPoint: 'user/create',
  data: {'name': 'John Doe', 'email': 'johndoe@example.com'},
);

// Get Data
restApiService.getData(endPoint: 'user/1');
```

#### File Upload
```dart
final imageService = sl<IImageServiceRestApiDataSource>();
final file = File('path/to/image.png');

imageService.uploadFile(
  file: file,
  endPoint: 'upload/image',
);
```

## Configuration
Modify `RestApiConfigConst` for base URL and API key settings.
```dart
class RestApiConfigConst {
  static const BASE_URL = "https://example.com/api";
  static const API_KEY = "your_api_key_here";
}
```

## Contributing
Contributions are welcome! Please submit issues or pull requests on GitHub.

## License
This project is licensed under the MIT License.
