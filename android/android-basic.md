# ANDROID BASIC

## 1. Activity

### **Lifecycle**

![](./images/activity_lifecycle.png)

- `onCreate()`: khởi tạo layout
- `onStart()`: layout hiện
- `onResume()`: tương tác 
- `onPause()`: 
- `onStop()`: 
- `onDestroy()`: 
- `onRestart()`: 
- `onSaveInstanceState()`: lưu app state
- `onRestoreInstanceState()`: khôi phục app state

### **Scenarios of Lifecycle**
- Scenario 1: App is finished and restarted
    - User ấn back hoặc
    - Activity.finish() được gọi

    ![](./images/activity_lifecycle1.png)

- Scenario 2: User điều hướng
    - User ấn Home
    - User switches sang app khác(từ menu đa nhiệm, thông báo, chấp nhận cuộc gọi,...)

    ![](./images/activity_lifecycle2.png)

    Khi activity stop, system sử dụng `onSaveInstanceState()` để lưu app state trong TH system kill process của app sau này, nếu không kill, activity instance sẽ được lưu vào RAM và khi activity comes back nó được gọi lại mà k cần khởi tạo lại các thành phần đã khởi tạo

- Scenario 3: Configuration changes 
    - Configuration thay đổi, như xoay màn hình
    - User resize màn hình trong chế độ đa màn hình

    ![](./images/activity_lifecycle3.png)

    Activity hoàn toàn bị hủy (destroyed), nhưng trạng thái được lưu và khôi phục cho instance mới<br/>
    Bundle trong onCreate and onRestoreInstanceState giống nhau

- Scenario 4: App bị tạm dừng bởi system
    - Bật Multi-window mode (API 24+) and mất focus
    - 1 phần app khác che (cover) app đang chạy(1 dialog mua hàng, 1 dialog xin quyền, hộp thoại đăng nhập bên thứ 3, 1 cuộc gọi tới...)
    - 1 intent chooser xuất hiện, như share dialog

    ![](./images/activity_lifecycle4.png)
    
    Scenario k áp dụng cho TH:
    - Dialog của app đang chạy, như `AlertDialog `, `DialogFragment`
    - Thông báo mới, hoặc kéo thanh thông báo xuống

- Scenario 5: Điều hướng giữa nhiều activity

    ![](./images/activity_lifecycle5.png)

    - `onSaveInstanceState()` được gọi nhưng ` onRestoreInstanceState()` thì KHÔNG. Nếu configuration thay đổi ở acticity 2 thì activity 1 sẽ bị destroy và chỉ recreated khi nó được focus trở lại.

- Scenario 6: Activities trong back stack với configuration changes

    ![](./images/activity_lifecycle6.png)

    - Tất cả activity trong stack cần khôi phục state sau khi configuration change để khởi tạo lại UI

- Scenario 7: App’s process is killed

    ![](./images/activity_lifecycle7.png)

## 2. Fragment

- ### **Lifecycle**