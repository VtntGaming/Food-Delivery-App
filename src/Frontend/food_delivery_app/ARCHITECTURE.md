# Food Delivery App - Architecture Guide

## Project Structure

```
lib/
├── config/
│   ├── theme.dart          # App theme, colors, spacing, typography
│   ├── constants.dart      # App-wide constants and strings
│   └── exports.dart        # Barrel exports for config
│
├── core/
│   └── (Reserved for business logic, usecases, repositories)
│
└── presentation/
    ├── exports.dart        # Barrel exports for presentation
    └── admin_dashboard/
        ├── pages/
        │   └── admin_dashboard_page.dart  # Main dashboard screen
        │
        └── widgets/
            ├── common/
            │   └── app_widgets.dart       # Reusable UI components
            │       ├── AppButton
            │       ├── AppIconButton
            │       ├── AppCard
            │       ├── AppSectionHeader
            │       ├── AppDivider
            │       └── AppEmptyState
            │
            ├── dashboard/
            │   └── statistics_widgets.dart # Dashboard-specific widgets
            │       ├── StatisticCard
            │       ├── TimelineCard
            │       └── DashboardSection
            │
            ├── users/
            │   └── user_widgets.dart       # User management widgets
            │       ├── UserModel
            │       ├── UserListTile
            │       └── UsersSection
            │
            ├── promotions/
            │   └── promotion_widgets.dart  # Promotion widgets
            │       ├── PromotionModel
            │       ├── PromotionCard
            │       └── PromotionsSection
            │
            └── favorites/
                └── favorite_widgets.dart   # Favorite/recommendation widgets
                    ├── FavoriteModel
                    ├── FavoriteItemCard
                    ├── FavoritesGridView
                    └── FavoritesSection
```

## Key Design Principles

### 1. Clean Architecture
- **Separation of Concerns**: UI logic separated from business logic
- **Layered Structure**: Config → Core → Presentation
- **Dependency Inversion**: Widgets depend on abstractions, not implementations

### 2. Reusable Widgets
- **AppButton**: Primary, secondary, outlined button styles
- **AppCard**: Consistent card component with customization
- **AppSectionHeader**: Reusable header with title and action
- **AppEmptyState**: Consistent empty state view

### 3. Responsive Design
- **GridView**: Auto-adaptive grid columns based on screen width
- **SingleChildScrollView**: Prevents overflow on small screens
- **MediaQuery**: Responsive layout adjustments
- **Flexible/Expanded**: Dynamic width/height allocation

### 4. Theme System
- **Centralized Colors**: `AppTheme.primaryDark`, `AppTheme.accentOrange`, etc.
- **Consistent Spacing**: `AppTheme.xs`, `AppTheme.sm`, `AppTheme.md`, etc.
- **Typography Hierarchy**: Clear text style definitions
- **Border Radius**: Standardized `radiusSm`, `radiusMd`, `radiusLg`

### 5. No Hardcoding
- **Constants**: All strings in `AppConstants`
- **Theme Values**: All colors, sizes, spacing in `AppTheme`
- **Models**: Data models for users, promotions, favorites

### 6. Const Constructors
- All widgets use `const` when possible for better performance
- Immutable data models
- Efficient widget tree rebuilding

## Color Palette

| Color | Value | Usage |
|-------|-------|-------|
| Primary Dark | #1a237e | Headers, primary elements |
| Primary Dark Light | #283593 | Alternative primary |
| Accent Orange | #FF6b35 | Calls-to-action, highlights |
| Accent Red | #E63946 | Destructive actions |
| Success Green | #4CAF50 | Positive actions |
| White | #FFFFFF | Backgrounds, text contrast |
| Text Dark | #212121 | Primary text |
| Text Grey | #757575 | Secondary text |
| Text Light Grey | #BDBDBD | Tertiary text |
| Border Grey | #E0E0E0 | Borders, dividers |

## Spacing Scale

- `xs` = 4px
- `sm` = 8px
- `md` = 16px
- `lg` = 24px
- `xl` = 32px
- `xxl` = 48px

## Usage Examples

### Using Common Widgets
```dart
// Button
AppButton(
  label: 'Tác vụ',
  onPressed: () {},
  backgroundColor: AppTheme.accentOrange,
)

// Card
AppCard(
  padding: const EdgeInsets.all(AppTheme.md),
  child: Text('Nội dung'),
)

// Section Header
AppSectionHeader(
  title: 'Tiêu đề',
  subtitle: 'Phụ đề',
)
```

### Creating New Features
1. Create feature folder in `presentation/`
2. Create `pages/` and `widgets/` subdirectories
3. Define models in widgets file
4. Create reusable widget components
5. Create main page that uses widgets
6. Export in `presentation/exports.dart`

### Data Models
```dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}
```

## Production Checklist

- [x] Theme system with centralized colors and typography
- [x] Reusable widget components
- [x] Responsive design patterns
- [x] No hardcoded values
- [x] Const constructors
- [x] Clean architecture structure
- [x] Sample data implementation
- [x] Error states handling
- [ ] State management (To be added: Riverpod/Provider)
- [ ] API integration (To be added: Core layer with repositories)
- [ ] Error handling (To be added: Try-catch, error dialogs)
- [ ] Localization (To be added: i18n support)
- [ ] Unit tests (To be added)
- [ ] Widget tests (To be added)
