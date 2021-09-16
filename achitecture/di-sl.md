# Dependency Injection vs Service Locator

Ngày xưa khi vẫn còn mài mông trên trường có một người anh chỉ điểm cho tôi một vài bộ bí quyết như: SOLID, IoC, DI, Dagger. Và sau khi StackOverFlow luận kiếm cùng các hảo hữu giang hồ, kinh mạnh của tôi như được đả thông đến mức tẩu hỏa nhập ma và cho đến tận bây giờ tôi vẫn đang lạc lối giữa ma đạo! Sốc tập 1.
    
Đến một ngày của thế kỷ 21, Google chính thức hỗ trợ ngôn ngữ Kotlin để phát triển Android. Lợi dụng những điểm mạnh của ngôn ngữ hiện đại này, cộng đồng Android Developer cho ra đời thêm các thư viện lightweight injection. Như buồn ngủ gặp chiếu manh. Ngủ chưa được bao lâu tôi lại được ông anh bên trên đánh thức bằng bộ chưởng pháp SL, tên khoa học là Service Locator. Lại luận kiếm thêm một chút tôi sốc tập 2. 

*Dependency Inversion* là một nguyên lý để thiết kế và viết code.

*Inversion of Control* là một design pattern được tạo ra để code có thể tuân thủ nguyên lý Dependency Inversion. 

*Dependency Injection* và Service Locator là hai cách để hiện thực Inversion of Control Pattern.

`Vậy DI và SL khác nhau như thế nào?`

## Dependency Injection

Các dependencies được cung cấp cho Target Object, mà object không cần làm bất cứ việc gì, nói cách khác dependency được `injected` vào target object

![](./images/di-sl1.png)

## Service Locator

Target Object truy cập các dependencies cần thiết từ Locator(container, register...). Locator gi tìm kiếm các dependencies được yêu cầu và cung cấp nó cho target object. Nó không được `injected` nhưng được `located` thay thế.

![](./images/di-sl2.png)

## Real world
Ví dụ như bạn bị dương tính với covid

- DI: May mắn được nhập viện bạn sẽ được bác sỹ chủ động tiêm thuốc mà cơ thể bạn cần.
- SL: Không may mắn, bệnh viện quá tải nên bạn phải tự điều trị ở nhà. Bạn phải chủ động tự tìm kiếm thuốc theo đơn bác sỹ kê.

![](./images/di-sl0.png)
## Vậy cái nào hơn?

Martin Fowler từng nói: 

>The choice between Service Locator and Dependency Injection is less important than the principle of separating service configuration from the use of services within an application.

Tôi thấy đúng nhưng quan điểm của tôi thì SL khiến việc mock, test khó khăn hơn.

## Liên hệ 
Project Android ở Gapo đang lựa chọn thư viện [Koin](https://insert-koin.io/) là một SL để tuân theo nguyên lý DI:
- Hiện tại ở một số class không do framework Android quản lý, các dependencies có thể inject qua constructor nhưng lại đang lazy get từ Locator dẫn đến việc khó mock, khó test, khó thay đổi sang 1 framework DI khác như [Dagger](https://dagger.dev/).
- Thêm vào đó module graphs của Koin được xử lý ở runtime ảnh hưởng tới thời gian khởi động app. Toàn bộ dependencies được khởi tạo bằng kỹ thuật reflection khiến việc này tốn thời gian hơn. (https://blog.nimbledroid.com/2016/02/23/slow-Android-reflection.html)

## Kết luận
Chung quy lại về các framework DI nói chung và giữa DI và SL nói riêng, có thể dùng hoặc không dùng và dùng cái nào cũng được nhưng cần hiểu và làm chủ được nó.

>Nguồn 
[1](https://medium.com/mobile-app-development-publication/dependency-injection-and-service-locator-4dbe4559a3ba)
[2](https://www.rivu.dev/service-locator-and-dependency-injection-which-is-what/)


