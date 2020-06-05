# Danh mục

## [Android basic](./android-basic.md)
### 1. [Activity](./android-basic.md/#1-activity)
- [Lifecycle](./android-basic.md/#11-lifecycle)
- [Scenarios of Lifecycle](./android-basic.md/#12-Scenarios-of-Lifecycle)
    - Scenario 1: App is finished and restarted
    - Scenario 2: User điều hướng
    - Scenario 3: Configuration changes
    - Scenario 4: App bị tạm dừng bởi system
    - Scenario 5: Điều hướng giữa nhiều activity
    - Scenario 6: Activities trong back stack với configuration changes
    - Scenario 7: App’s process is killed
- [Task và Backstack](./android-basic.md/#13-Task-and-Backstack)
    - Task
    - Backstack
    - [Launch Mode](./android-basic.md/#Launch-Mode)
    - Dọn dẹp Back Stack
    - Task Affinity
    - Tạo một Task

### 2. [Fragment](./android-basic.md/#2-fragment)

- [Lifecycle](./android-basic.md/#21-lifecycle)
- [Scenarios of Lifecycle](./android-basic.md/#22-Scenarios-of-Lifecycle)
    - Scenario 1: Activity with Fragment starts and finishes
    - Scenario 2: Activity với Fragment được xoay
    - Scenario 3: Activity với Fragment được giữ lại trạng thái khi xoay
- [Static Fragment](./android-basic.md/#23-Static-Fragment)
- [Dynamics Fragment](./android-basic.md/#24-Dynamics-Fragment)
    - FragmentManager
    - FragmentTransaction
- [Backstack trong Fragment](./android-basic.md/#25-Backstack-trong-Fragment)
- [Note](./android-basic.md/#26-note)
    - FragmentTransaction: add và replace
    - getSupportFragmentManager vs getChildFragmentManager
    - Callback từ DialogFragment, ChildFragment, BottomSheetFragment đến parent fragment
    - onActivityResult với các nested fragment
    - Tại sao không truyền tham số vào constructor Fragment

### 3. [View](./view.md)

- [Custom View](./view.md/#1-custom-view)
- [Constraint Layout](./view.md/#2-Constraint-Layout)
- [Recycler View + ListAdapter + Databinding](./recycler-view.md)

## [Android advance](./android-advance.md)


## Testing
### 1. [Unit Testing](./testing/unit-testing.md)

### 2. [UI Testing](./testing/ui-testing.md)

## Build Android
### 1. [Tự động release lên playstore](./build/cd-android.md)

## [Template for Android studio](./template-android)
