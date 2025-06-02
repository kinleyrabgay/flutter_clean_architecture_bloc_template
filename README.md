# Flutter Clean Architecture BLoC Template

A production-ready Flutter template implementing Clean Architecture with BLoC pattern and Test-Driven Development (TDD) approach.

## 🏗️ Architecture Overview

This template follows Uncle Bob's Clean Architecture principles with three main layers:

### 📱 Presentation Layer
- **BLoC Pattern**: State management using flutter_bloc
- **Pages**: UI screens and widgets
- **Router**: Navigation using go_router

### 🏢 Domain Layer
- **Entities**: Core business objects
- **Use Cases**: Business logic implementation
- **Repositories**: Abstract contracts for data access

### 💾 Data Layer
- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: Local and remote data access
- **Repository Implementations**: Concrete implementations of domain contracts

## 🚀 Features

- ✅ **Clean Architecture** with clear separation of concerns
- ✅ **BLoC Pattern** for predictable state management
- ✅ **Dependency Injection** using get_it and injectable
- ✅ **Navigation** with go_router
- ✅ **Local Storage** with SharedPreferences and Hive
- ✅ **Network Layer** with Dio and connectivity checking
- ✅ **Error Handling** with Either pattern using dartz
- ✅ **Logging** with logger package
- ✅ **Testing** setup with unit tests and BLoC tests
- ✅ **Code Generation** ready for JSON serialization and DI

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/          # App-wide constants
│   ├── di/                 # Dependency injection setup
│   ├── error/              # Error handling (failures & exceptions)
│   ├── network/            # Network utilities
│   ├── router/             # App navigation
│   └── utils/              # Utility classes (logger, etc.)
├── data/
│   ├── datasources/        # Data sources (local & remote)
│   ├── models/             # Data models with JSON serialization
│   └── repositories/       # Repository implementations
├── domain/
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository contracts
│   └── usecases/           # Business logic use cases
└── presentation/
    ├── bloc/               # BLoC state management
    └── pages/              # UI pages and widgets

test/
├── domain/
│   └── usecases/           # Use case unit tests
└── presentation/
    └── bloc/               # BLoC tests
```

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK (3.8.0 or higher)
- Dart SDK
- IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_clean_architecture_bloc_template
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (for dependency injection and JSON serialization)
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🧪 Testing

### Run all tests
```bash
flutter test
```

### Run tests with coverage
```bash
flutter test --coverage
```

### Run specific test files
```bash
flutter test test/domain/usecases/counter/get_counter_test.dart
flutter test test/presentation/bloc/counter/counter_bloc_test.dart
```

## 📦 Dependencies

### Core Dependencies
- **flutter_bloc**: State management
- **get_it & injectable**: Dependency injection
- **dartz**: Functional programming (Either, Option)
- **equatable**: Value equality
- **go_router**: Declarative routing

### Data & Storage
- **dio**: HTTP client
- **shared_preferences**: Simple key-value storage
- **hive**: NoSQL database
- **connectivity_plus**: Network connectivity

### Development
- **build_runner**: Code generation
- **injectable_generator**: DI code generation
- **json_serializable**: JSON serialization
- **freezed**: Immutable classes

### Testing
- **bloc_test**: BLoC testing utilities
- **mocktail**: Mocking framework

## 🎯 Usage Examples

### Adding a New Feature

1. **Create Entity** (Domain Layer)
   ```dart
   // lib/domain/entities/todo_entity.dart
   class TodoEntity extends Equatable {
     final String id;
     final String title;
     final bool isCompleted;
     
     const TodoEntity({
       required this.id,
       required this.title,
       required this.isCompleted,
     });
     
     @override
     List<Object> get props => [id, title, isCompleted];
   }
   ```

2. **Create Repository Contract** (Domain Layer)
   ```dart
   // lib/domain/repositories/todo_repository.dart
   abstract class TodoRepository {
     Future<Either<Failure, List<TodoEntity>>> getTodos();
     Future<Either<Failure, TodoEntity>> createTodo(String title);
   }
   ```

3. **Create Use Case** (Domain Layer)
   ```dart
   // lib/domain/usecases/todo/get_todos.dart
   @injectable
   class GetTodos implements UseCaseWithoutParams<List<TodoEntity>> {
     final TodoRepository repository;
     
     GetTodos(this.repository);
     
     @override
     Future<Either<Failure, List<TodoEntity>>> call() async {
       return await repository.getTodos();
     }
   }
   ```

4. **Implement Repository** (Data Layer)
   ```dart
   // lib/data/repositories/todo_repository_impl.dart
   @Injectable(as: TodoRepository)
   class TodoRepositoryImpl implements TodoRepository {
     // Implementation details...
   }
   ```

5. **Create BLoC** (Presentation Layer)
   ```dart
   // lib/presentation/bloc/todo/todo_bloc.dart
   @injectable
   class TodoBloc extends Bloc<TodoEvent, TodoState> {
     // BLoC implementation...
   }
   ```

## 🔧 Configuration

### Environment Setup
Create environment-specific configurations in `lib/core/constants/app_constants.dart`

### Dependency Injection
Register new dependencies in `lib/core/di/injection_container.dart`

### Routing
Add new routes in `lib/core/router/app_router.dart`

## 📝 Best Practices

1. **Follow SOLID Principles**
2. **Write tests first (TDD)**
3. **Keep business logic in use cases**
4. **Use meaningful names for classes and methods**
5. **Handle errors gracefully with Either pattern**
6. **Log important events and errors**
7. **Keep widgets small and focused**

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Write tests for your changes
4. Implement the feature
5. Ensure all tests pass
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Clean Architecture by Robert C. Martin
- BLoC Pattern by Felix Angelov
- Flutter Community for amazing packages

---

**Happy Coding! 🚀**