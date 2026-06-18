# API Integration Workflow

This document serves as an instruction manual for AI agents and developers on how to properly integrate new backend APIs into the Flutter frontend architecture. 

Whenever a backend API is created or modified, follow these **5 exact steps**:

## 1. Update the Frontend Models
Run the `generate_api.bat` script located in the project root. 
This script automatically parses the backend OpenAPI schema and updates the `friends_battery_api` package (located at `frontend/lib/api/`) with the newest endpoints, request/response models, and classes.

## 2. Create or Update a Repository Method
Navigate to the appropriate feature module within the frontend (e.g., `lib/features/admin/products/repository/`).
Write a function in the Repository class that calls the newly generated API method. The Repository serves as a buffer between the raw generated API client and the UI, handling custom error mapping or caching if needed.

```dart
// Example: lib/features/admin/products/repository/product_repository.dart
Future<Product> addProduct(Product newProduct) async {
  // api is injected into the repository, allowing access to the generated methods
  final response = await api.createProduct(newProduct);
  return response; 
}
```

## 3. Create a Riverpod Provider
Create a Provider that links to the repository method so the UI can easily access and react to it.
Use `FutureProvider` for reading/fetching data, and `StateNotifierProvider` or `NotifierProvider` for mutations (creating/updating/deleting data).

```dart
// Example: lib/features/admin/products/providers/product_provider.dart
final productProvider = FutureProvider<List<Product>>((ref) {
  return ref.watch(productRepositoryProvider).getProducts();
});
```

## 4. Connect to the UI
In the Flutter screen, use `ConsumerWidget` or `ConsumerStatefulWidget` and call `ref.watch()` on the provider. The UI will automatically handle loading, error, and data states, and will rebuild whenever the data changes!

```dart
// Example: lib/features/admin/products/screens/product_screen.dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final productsState = ref.watch(productProvider);
  
  return productsState.when(
    data: (products) => ListView.builder(...),
    loading: () => const CircularProgressIndicator(),
    error: (err, stack) => Text('Error: $err'),
  );
}
```

## 5. Architectural Rule Reminders
- **DO NOT** modify the `frontend/lib/api/` package manually. It is strictly auto-generated.
- **DO NOT** make raw HTTP or Dio requests in the UI or Providers. All network requests must go through the generated API package wrapped by a feature Repository.
- **DO NOT** use `flutter_hooks`. We strictly use `flutter_riverpod` for all state management, dependency injection, and data fetching.
