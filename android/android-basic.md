# ANDROID BASIC

# 1. Activity

## Lifecycle

![](./images/activity_lifecycle.png)

- `onCreate()`: khởi tạo layout
- `onStart()`: layout hiện
- `onResume()`: tương tác 
- `onPause()`: bị che 1 phần bởi app khác
- `onStop()`: bị che hoàn toàn
- `onDestroy()`: die
- `onRestart()`: tái khởi động sau khi stop
- `onSaveInstanceState()`: lưu app state
- `onRestoreInstanceState()`: khôi phục app state

## Scenarios of Lifecycle
- **Scenario 1: App is finished and restarted**
    - User ấn back hoặc
    - Activity.finish() được gọi

    ![](./images/activity_lifecycle1.png)

- **Scenario 2: User điều hướng**
    - User ấn Home
    - User switches sang app khác(từ menu đa nhiệm, thông báo, chấp nhận cuộc gọi,...)

    ![](./images/activity_lifecycle2.png)

    Khi activity stop, system sử dụng `onSaveInstanceState()` để lưu app state trong TH system kill process của app sau này, nếu không kill, activity instance sẽ được lưu vào RAM và khi activity comes back nó được gọi lại mà k cần khởi tạo lại các thành phần đã khởi tạo

- **Scenario 3: Configuration changes **
    - Configuration thay đổi, như xoay màn hình
    - User resize màn hình trong chế độ đa màn hình

    ![](./images/activity_lifecycle3.png)

    Activity hoàn toàn bị hủy (destroyed), nhưng trạng thái được lưu và khôi phục cho instance mới<br/>
    Bundle trong onCreate and onRestoreInstanceState giống nhau

- **Scenario 4: App bị tạm dừng bởi system**
    - Bật Multi-window mode (API 24+) and mất focus
    - 1 phần app khác che (cover) app đang chạy(1 dialog mua hàng, 1 dialog xin quyền, hộp thoại đăng nhập bên thứ 3, 1 cuộc gọi tới...)
    - 1 intent chooser xuất hiện, như share dialog

    ![](./images/activity_lifecycle4.png)
    
    Scenario k áp dụng cho TH:
    - Dialog của app đang chạy, như `AlertDialog `, `DialogFragment`
    - Thông báo mới, hoặc kéo thanh thông báo xuống

- **Scenario 5: Điều hướng giữa nhiều activity**

    ![](./images/activity_lifecycle5.png)

    - `onSaveInstanceState()` được gọi nhưng ` onRestoreInstanceState()` thì KHÔNG. Nếu configuration thay đổi ở acticity 2 thì activity 1 sẽ bị destroy và chỉ recreated khi nó được focus trở lại.

- **Scenario 6: Activities trong back stack với configuration changes**

    ![](./images/activity_lifecycle6.png)

    - Tất cả activity trong stack cần khôi phục state sau khi configuration change để khởi tạo lại UI

- **Scenario 7: App’s process is killed**

    ![](./images/activity_lifecycle7.png)

## Task và Backstack

### **Task**

![](./images/task.png)
>Task là tập hợp gồm nhiều activity mà người dùng tương tác với ứng dụng khi thực hiện một công việc nhất định. Các activity được sắp xếp trong một stack (được gọi là Back stack), theo thứ tự mở của mỗi activity.

- Click app icon hoặc từ danh sách Task khi ấn Overview: tìm những task đã tồn tại -> task nào của ứng dụng đã tồn tại, ứng dụng sẽ được tiếp tục ->  Ngược lại, nếu ứng dụng chưa đc sử dụng, một task mới sẽ được tạo cùng với "main" activity của ứng dụng như là root (gốc) của Back stack.

### **Backstack**
> 1 cái chồng đĩa, mỗi đĩa là 1 activity :)

![](./images/task_backstack.png)
- activity1 `startActivity()` activity2: push activity2 lên trên cùng của backstack và giữ focus activity2 ở foreground. activity1 vẫn nằm trong stack, ở state stopped và ở background
- ấn back: activity trên cùng bị ném (pop) ra khỏi backstack và ở state destroyed. activity trước đó sẽ được tiếp tục. Nếu activity cuối cùng được pop ra khỏi backstack -> trở về màn hình chính, task của app đó sẽ k còn tồn tại
- Các activity trong Back stack sẽ không bao giờ được sắp xếp lại, mà chỉ được push hay pop từ stack theo đặc trưng của một stack LIFO (LAST IN FIRST OUT).
- Backstack k bị ảnh hưởng khi task nhảy từ background <-> foreground
- Nhiều task có thể được lưu giữ cùng lúc trong background. Tuy nhiên, nếu user chạy quá nhiều background task tại cùng thời điểm, hệ thống có thể hủy các background activity để khôi phục bộ nhớ, lúc này trạng thái của activity bị hủy sẽ mất đi.

### **Launch Mode**
>Launch mode cho phép ta định nghĩa cách mà một instance mới của một activity được liên kết với task hiện tại.

**Sử dụng Manifest**
```xml
<activity
    android:name=".SingleTaskActivity"
    android:launchMode="singleTask">
```
- `standard`: <br/>
là giá trị mặc định, khi activity được khởi tạo, activity mới sẽ được đặt lên đỉnh của stack trong cùng 1 task.  Activity có thể được khởi tạo nhiều lần, mỗi instance của activity có thể thuộc về nhiều task khác nhau, và một task có thể có nhiều instance của một activity. <br/>

        Task: A -> B -> C
        Start C: A -> B -> C -> C
        Start B: A -> B -> C -> C -> B

- `singleTop`:<br/>
tương tự `standard`, tuy nhiên mỗi activity luôn được đảm bảo chỉ có 1 thể hiện nằm trên top của task. Nếu activity đó có 1 thể hiện có sẵn trên top của task thì lần khởi chạy tiếp theo sẽ gọi lại thể hiện này thay thì tạo một thể hiện mới. Khởi chạy mới sẽ gọi callback `onNewIntent()`. <br/>
Task: A -> B -> C<br/>
Start C: A -> B -> C<br/>
Start B: A -> B -> C -> B<br/>
- `singleTask`<br/>
Hệ thống sẽ tạo một task mới, khởi tạo instance của activity và đưa vào vị trí root trong task mới(chỉ đúng khi thêm thuộc tính `taskAffinity` nếu không nó sẽ k tạo task mới mà chỉ tạo activity lên đầu của task hiện tại). <br/>
Tuy nhiên nếu đối tượng activity này đã tồn tại ở bất kỳ task nào khác rồi thì hệ thống sẽ gọi activity đó thông qua phương thức `onNewIntent()` và các activity đặt trên nó sẽ bị kill. Chỉ có một instance của activity được tồn tại tại một thời điểm.<br/>
    - Ví dụ với không có `taskAffinity`: C là singleTask <br/> 
    Task1: A -> B<br/>
    Start C: A -> B -> C<br/>
    Start B, A: A -> B -> C -> B -> A<br/>
    Start C: A -> B -> C
    - Ví dụ với có `taskAffinity`: C là singleTask <br/> 
    Task1: A -> B<br/>
    Start C: Task2: C<br>
    Start B, A: Task2: C -> B -> A<br/>
    Start C: Task2: C <br>
    Task1 không thay đổi


# 2. Fragment

- ## **Lifecycle**