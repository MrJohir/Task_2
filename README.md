# Product Store - Flutter Task 2

A comprehensive Flutter application that demonstrates REST API handling, async operations, list building, and GetX state management by creating a product listing app with search and filter functionality.

## 🎯 Objective

This project evaluates:
- REST API handling with proper error management
- Async operations and state management
- List building with responsive design
- GetX state management implementation
- Search and filter functionality
- UI responsiveness and user experience

## ✨ Features

### Core Features
- **Product Listing**: Display products in a responsive grid layout
- **Search Functionality**: Real-time search by product title with debouncing
- **Category Filter**: Dropdown filter to browse products by category
- **Pull-to-Refresh**: Refresh product data with pull gesture
- **Skeleton Loading**: Shimmer effect while loading data

### Technical Features
- **REST API Integration**: Fetches data from [Fake Store API](https://fakestoreapi.com/products)
- **GetX State Management**: Reactive state management with proper separation of concerns
- **MVC Architecture**: Clean code structure following MVC pattern
- **Responsive Design**: Uses flutter_screenutil for consistent sizing across devices
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Local Storage**: Caching with GetStorage for improved performance
- **Loading States**: Professional loading indicators and feedback

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Dart SDK (latest version)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd task_2
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 📱 Screenshots

The app includes:
- Clean product grid layout
- Intuitive search functionality
- Category filtering dropdown
- Professional loading states
- Error handling screens
- Pull-to-refresh interaction

## 🏗️ Architecture

### MVC Pattern Implementation

```
lib/
├── core/                          # Core utilities and services
│   ├── bindings/                  # Dependency injection
│   ├── common/                    # Shared components
│   │   ├── styles/               # Global text styles
│   │   └── widgets/              # Reusable widgets
│   ├── services/                 # Network and storage services
│   └── utils/                    # Constants, helpers, and utilities
├── features/                     # Feature modules
│   └── products/                 # Product feature
│       ├── controllers/          # Business logic (GetX controllers)
│       ├── models/              # Data models
│       ├── services/            # Feature-specific services
│       └── views/               # UI components
│           ├── screens/         # Screen widgets
│           └── widgets/         # Feature-specific widgets
├── routes/                       # Application routing
└── main.dart                     # App entry point
```

## 📦 Dependencies

### Core Dependencies
- **flutter**: Framework
- **get**: State management and navigation
- **http**: HTTP requests
- **flutter_screenutil**: Responsive design
- **flutter_easyloading**: Loading indicators
- **shimmer**: Skeleton loading animations
- **get_storage**: Local data persistence
- **logger**: Logging utility

## 🌐 API Integration

### Fake Store API Endpoints
- **Products**: `https://fakestoreapi.com/products`
- **Categories**: `https://fakestoreapi.com/products/categories`
- **Category Products**: `https://fakestoreapi.com/products/category/{category}`

### API Features
- Fetches all products with comprehensive error handling
- Retrieves available categories for filtering
- Implements proper network error management
- Uses debouncing for search to prevent excessive API calls

## 🎨 UI/UX Features

### Design Elements
- **Responsive Grid**: 2-column product grid that adapts to screen sizes
- **Material Design**: Following Material Design guidelines
- **Consistent Theming**: Professional color scheme and typography
- **Loading States**: Shimmer effects and progress indicators
- **Error States**: User-friendly error messages with retry options
- **Empty States**: Informative messages when no products are found

### User Interactions
- **Search**: Real-time search with 500ms debouncing
- **Filter**: Category dropdown with icons
- **Refresh**: Pull-to-refresh gesture
- **Navigation**: Smooth transitions and animations

## 🧪 Testing

The app includes comprehensive error handling and edge cases:
- Network connectivity issues
- API timeouts and errors
- Empty search results
- Loading states
- Data validation

## 📊 Performance Optimizations

- **Debounced Search**: Prevents excessive API calls during typing
- **Local Caching**: Stores data locally for faster subsequent loads
- **Efficient State Management**: GetX reactive programming for optimal performance
- **Image Optimization**: Proper image loading with error handling
- **Memory Management**: Proper disposal of controllers and resources

## 🔧 Configuration

### Environment Setup
The app is configured to work out of the box with:
- Development and production environments
- Responsive design for various screen sizes
- Proper error boundaries and fallbacks

### Customization
Easy to customize:
- Color scheme in `app_colors.dart`
- Text styles in `global_text_style.dart`
- API endpoints in `api_constants.dart`
- App configuration in `main.dart`

## 📝 Code Quality

### Best Practices Implemented
- **Clean Architecture**: Separation of concerns with MVC pattern
- **SOLID Principles**: Following software design principles
- **Error Handling**: Comprehensive error management
- **Code Documentation**: Well-documented code with comments
- **Null Safety**: Full null safety implementation
- **Responsive Design**: Consistent sizing across devices

## 🚦 Features Checklist

- ✅ **REST API Integration**: Fetches products from Fake Store API
- ✅ **Product Display**: Grid layout with product information
- ✅ **Search Functionality**: Real-time search by product title
- ✅ **Category Filter**: Dropdown filter for product categories
- ✅ **GetX State Management**: Reactive state management
- ✅ **Pull-to-Refresh**: Refresh data with pull gesture
- ✅ **Skeleton Loader**: Shimmer loading animations
- ✅ **Error Handling**: Comprehensive error management
- ✅ **Responsive Design**: Adapts to different screen sizes
- ✅ **Professional UI**: Clean and intuitive user interface

## 🎯 Evaluation Criteria Met

- ✅ **Async API Handling**: Proper async/await implementation with error handling
- ✅ **Search/Filter Implementation**: Real-time search with category filtering
- ✅ **State Management**: GetX reactive programming with proper separation
- ✅ **UI Responsiveness**: Smooth animations and responsive design

## 📄 License

This project is created for evaluation purposes and demonstrates Flutter development best practices.

## 🤝 Contributing

This is a demonstration project. For suggestions or improvements, please create an issue or submit a pull request.

---

**Built with ❤️ using Flutter and GetX**
# Task_2
