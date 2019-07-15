# FUNCTION

## 1. Function

```kotlin
fun doSomething(matter: String): String {
    return "Sun*"
}
```
### Single-Expression Function
```kotlin
fun getInfo() : String = "Hello world..."
```

### Function Scope
- **Member function:** các function được khai báo ở trong class, object hoặc interface
- **Local function:** các function được khai báo bên trong một function khác (nested)
- **Top-level function:** Có thể hiểu rằng đây là những function được khai báo ngoài tất cả như class, object, interface và được định nghĩa trong file Kotlin (.kt)
```kotlin
//file name is DataManager.kt
fun isTokenExpired() : Boolean{
    var isExpired = false
    //......
    return isExpired
}
```
```java
public class JavaMain {
    public static void main(String[] args) {
        //call top-level function in java
        DataManagerKt.isTokenExpired();
    }
}
```

## 2. Parameter
```kotlin
fun read(b: Array<Byte>, off: Int = 0, len: Int = b.size()) {
}
```
Mỗi param trong function có thể được gán giá trị mặc định hoặc không gán. Giá trị mặc định cho phép lúc truyền param cho function có thể bỏ qua các giá trị mặc định

## 3. Unit-returning functions
```kotlin
fun printHello(name: String?): Unit {
    if (name != null)
        println("Hello ${name}")
    else
        println("Hi there!")
    // `return Unit` or `return` is optional
}
```
Unit ở đây có thể hiểu như là Void ở trong Java hoặc các ngôn ngữ khác. Việc khai báo return type là Unit là không bắt buộc. 

## 4. Variable number of arguments (Varargs)
1 tham số của hàm(thường ở cuối) có thể thêm `vararg` modifier cho phép 1 số lượng đối số truyền vào
```kotlin
fun <T> asList(vararg ts: T): List<T> {
    val result = ArrayList<T>()
    for (t in ts) // ts is an Array
        result.add(t)
    return result
}

val list = asList(1, 2, 3)
```
TH truyền vào 1 mảng
```kotlin
val a = arrayOf(1, 2, 3)
val list = asList(-1, 0, *a, 4)
```

 Chỉ có một param được đánh dấu là vararg. Nếu param không phải là param cuối cùng, khi gọi hàm, ta phải chỉ định rõ các param sau đó

 ```kotlin
fun multiPrint(prefix: String, vararg strings: String, suffix: String) {
}

multiPrint("Start", "a", "b", "c", suffix = "End")
 ```



## 5. Infix notation
```kotlin
class Fly(var currentPlace: String) {

    infix fun flyTo(nextPlace: String) {
        println("The plane fly from $currentPlace to $nextPlace")
    }

}

val plane1 = Fly("Ha Noi")

plane1 flyTo "Ho Chi Minh" //print: The plane fly from Ha Noi to Ho Chi Minh

plane1.flyTo("Ho Chi Minh") //print: The plane fly from Ha Noi to Ho Chi Minh
```
Nhờ sử dụng ký hiệu infix cho function flyTo(), ta có thể sự dụng tên function như trung tố liên kết giữa instance class và param truyền vào. Function có thể sử dụng infix notation (trung tố) khi

- Function là member của một class hoặc là extension của class
- Function chỉ có một param duy nhất
- Function được mark bằng infix ở đầu function

## 6. Mutiple return values
```kotlin
data class Result(val result: Int, val status: Status)
fun function(...): Result {
    // computations

    return Result(result, status)
}

val (result, status) = function(...)
```
function có thể trả về đồng thời 2 giá trị result và status

**Destructuring Declarations**
```kotlin
data class Person(var name: String, var age: Int)

val (name, age) = Person("Hado", 22)

println("Name: $name") //print: Name: Hado
println("Age: $age") //print: Age: 22
```

## 7. Generic functions
```kotlin
fun <T> singletonList(item: T): List<T> {
}

//use
val l = singletonList<Int>(1)
```
Generic function với kiểu được extends từ một kiểu khác:

```kotlin
fun <T : Comparable<T>> sort(list: List<T>) {
}
```

## 8. Extension functions
Cho phép mở rộng class mà không phải kế thừa từ class đó
```kotlin
class C {
    fun foo() { println("member") }
}

fun C.foo() { println("extension") }
fun C.foo(i: Int) { println("extension $i") }

//use
val c = C()
c.foo() //member
c.foo(1) //extension 1
```

Extension Properties
```kotlin
val <T> List<T>.lastIndex: Int
    get() = size - 1
```

## 9. Higher-Order Functions and Lambdas
    Higher-Order function là function có thể nhận một function như một param hoặc có thể trả về một function:
```kotlin
fun doSomethingWithNumber(number: Int, receiver: (String?) -> Unit) {
    var result: String? = null
    //...do complex work with number

    receiver(result)
}
```

## 10. Inline function




