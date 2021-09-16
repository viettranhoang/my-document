# Dependency Injection vs Service Locator

Ngày xưa khi vẫn còn mài mông trên trường có một người anh chỉ điểm cho tôi một vài bộ bí quyết như: SOLID, IoC, DI, Dagger. Và sau khi stackOververFlow luận kiếm cùng các hảo hữu gian hồ, kinh mạnh của tôi như được đả thông đén mức tẩu hỏa nhập ma và cho đến tận bây giờ tôi vẫn đang lạc lối giữa ma đạo! Sốc tập 1.
    
Đến một ngày của thế kỷ 21, google chính thức hỗ trợ ngôn ngữ Kotlin để phát triển Android. Lợi dụng những điểm mạnh của ngôn ngữ hiện đại này, cộng đồng Android Developer cho ra đời thư viện lightweight injection. Như buồn ngủ gật chiếu manh, và rồi tôi lại được ông anh bên trên đánh thức tôi bằng bộ trưởng pháp SL, tên khoa học là Service Locator. Lại luận kiếm thêm một chút tôi ngỡ ra rằng:
    
    Koin là một Service Locator, không phải là Dependency Injector.

Sốc tập 2. 

Dependency Inversion là một nguyên lý để thiết kế và viết code.

Inversion of Control là một design pattern được tạo ra để code có thể tuân thủ nguyên lý Dependency Inversion. 

Dependency Injection và Service Locator là hai cách để hiện thực Inversion of Control Pattern.

`Vậy DI và SL khác nhau như thế nào?`

![](./images/di-sl0.png)

## Dependency Injection

Các dependencies được cung cấp cho Target Object, mà object không cần làm bất cứ việc gì, nói cách khác dependency được `injected` vào target object

![](./images/di-sl1.png)

## Service Locator

Target Object truy cập các dependencies cần thiết từ Locator(container, register...). Locator giúp tìm kiếm các dependencies được yêu cầu và cung cấp nó cho target object. Nó không được `injected` nhưng được `located` thay thế.

![](./images/di-sl2.png)

## Real world
- DI: ví dụ như bạn bị dương tính với covid, sau khi nhập viện bạn sẽ được chủ động tiêm thuốc mà cơ thể bạn cần.
- SL: ví dụ như bạn bị dương tính với covid, nhưng bệnh viện quá tải nên bạn phải tự điều trị ở nhà, bạn phải chủ động tự đi lấy thuốc theo đơn bác sỹ kê.

## Vậy cái nào hơn?

So sánh 2 cái ảnh về DI và SL bên trên, ta có thể thấy bên SL:
- Target object không chỉ bị phụ thuộc vào dependencies mà còn bị phụ thuộc vào class Locator -> giải quyết vấn đề phụ thuộc mà lại còn làm tăng lên phụ thuộc 
- Target object không thể biết được mình cần dependencies nào đẫn đến việc mock test khó khăn hơn

`Vậy nên chọn cái nào cho project bây giờ?`

Martin Fowler có 1 câu rằng: 

>The choice between Service Locator and Dependency Injection is less important than the principle of separating service configuration from the use of services within an application.

Tôi thấy nó đúng. 

## Liên hệ 
Project Android ở Gapo đang sử dụng Koin là SL:
- Hiện tại ở các class có không do framework quản lý, có thể inject qua constructor nhưng không inject lại đang dùng SL để lazy get dẫn đến việc khó mock, khó test, khó thay đổi sang 1 framework DI khác như dagger. 
- Thêm vào đó module graphs của Koin được xử lý ở runtime ảnh hưởng tới thời gian khởi động app. Toàn bộ dependencies được khởi tạo bằng kỹ thuật reflection khiến việc này tốn thời gian hơn. (https://blog.nimbledroid.com/2016/02/23/slow-Android-reflection.html)

## Kết luận
Chung quy lại, giữa DI và SL, dùng cái nào cũng được nhưng chúng ta phải hiểu và làm chủ được nó. Với các framework về DI, có thể dùng hoặc không dùng nhưng nếu dùng hãy dùng 1 cách có hiểu biết!

>Nguồn 
[1](https://medium.com/mobile-app-development-publication/dependency-injection-and-service-locator-4dbe4559a3ba)
[2](https://www.rivu.dev/service-locator-and-dependency-injection-which-is-what/)


