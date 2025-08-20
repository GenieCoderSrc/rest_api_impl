# Changelog

All notable changes to this project will be documented in this file.

## 0.0.7

### Aug 22, 2025

### Updated
- Updated `local_data_impl` to 0.0.4
- Updated `get_it_di_global_variable` to 0.0.6
- Updated Dart sdk to 3.9.0
- Remove un-used dependency
- Removed `flutter_lints` Dependency

## 0.0.6
### Jul 29, 2025

### Added
- Support for selecting API client type using `RestApiClientType` enum (`dio`, `http`).
- Introduced `IRestApiConfig` interface and `DefaultRestApiConfig` implementation with configurable base URL and API key.
- Updated repository and service DI registration to respect selected client type (Dio or Http).
- Ensured `Method` enum is exhaustively handled using the `switch` statement.

## 0.0.5
- Update example file.

## 0.0.4
- Update export file.

## 0.0.3
- Created Register Local Data Source Service GetIt DI.
- Created Register RestApi Data Source Service GetIt DI.

## 0.0.2
### Added
- Dependency injection-based service registration
- Support for HTTP methods: GET, POST, PUT, PATCH, DELETE
- Response handling with error management
- File upload and deletion support
- Configurable base URL and API key
- Example usage for API calls and file uploads

---

Future updates will include additional features, optimizations, and bug fixes.

## 0.0.1
- Initial Release
