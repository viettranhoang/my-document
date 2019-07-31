# BASIC
## 1. Val - var
- `var` (variable): biến
- `val` (value): hằng

## 2. Kiểu dữ liệu
    Everything trong Kotlin đều là đối tượng. Mọi lớp trong Kotlin đều extends từ đối tượng Any

### Numbers
    Type	Bit     Explicity conversion
    Double	64      toByte()
    Float	32      toFloat()
    Long	54      toLong()
    Int     32      toInt()
    Short	16      toShort()
    Byte	8       toByte()

### Characters
`Char` : Char không được coi là số trong Kotlin
```kotlin
val c: Char = 'a'
val d: Char = 4 //compiler sẽ báo lỗi
```

### Boolean
    || (hoặc)
    && (và)
    ! (phủ định)

### String
    String là kiểu immutable. Thành phần của string là các character

```kotlin
var s: String = "hello"
s[0] // 'h'
```
- String Literals
    - Double quote: 
        ```kotlin
        val s1 = "hello\n"
        ```
    - Triple quote:
        ```kotlin
        val text = """
        Line1
        Line2
        """
        ```
- String template: Truyền biến vào `${}`
    ```kotlin
    val s3 = "abc"
    val str = "$s3.length is ${s3.length}" // "abc.length is 3"
    ```

### Arrays
```kotlin
val a: Array<Int> = arrayOf(1,2,3,4) // [1,2,3,4]
var a1: Array<Int> = Array(3, { it ->
       it * 3
 }) //[0,3,6,9]
```

## 3. Null safety
    Mặc định biến trong kotlin là non-null, để khai báo 1 biến  kiểu nullable, ta sử dụng ?
```kotlin
var e: String? = null
var e: String = null //compiler báo lỗi
```
- Safe call: Khi kiểu biến là non null, việc gọi đến các biến, function hoàn toàn safe. Ngược lại, nếu truy cập đến một biến có kiểu nullable, NPE vẫn có thể xảy ra -> unsafe call. Sử dụng dấu ? để safe call
    ```kotlin
    var a: String? = null
    var b = a?.length //trả về null
    var user :User? = User("framgia", 22)
    var length = user?.name?.length //nếu user null hoặc name null, giá trị trả về cho length là null. 
    ```
    Để thực hiện việc gì chỉ với các giá trị khác null, ta có thể sử dụng toán tử ?. và các hàm apply, let...

    ```kotlin
    val listWithNulls: List<String?> = listOf("A", null)
    for (item in listWithNulls) {
        item?.let { println(it) } // chỉ thực hiện với các giá trị khác null
    }
    ```
- Toán tử elvis `?:`
    ```kotlin
    // without elvis
    var b: String? = "hello"
    val l: Int = if (b != null) b.length else -1
    //with elvis
    val l = b?.length ?: -1
    ```
-  Toán tử `!!`
    ```kotlin
    val l = b!!.length
    //nếu b không null, l = b.length. Nếu b null, NPE sẽ được throw
    ```

## 4. Toán tử so sánh

- Referential equality: 2 references trỏ tớ cùng một object <br>
    `===` >< `!==` <br>
    a === b khi và chỉ khi a và b cùng trỏ đến cùng một object

- Structural equality: function equals <br>
    `==` >< `!=` 
    ```kotlin
    //a == b compiler sẽ tự động gen thành 
    a?equals(b) ?: (b===null)
    ```
    Tức là nếu a không null, sẽ gọi function equals để kiểm tra với b, nếu a null, thì sẽ kiểm tra b có trỏ tới null không

## 5. Check kiểu và casting
- Check kiểu: 
    ```kotlin
    if (s is String){
    }
    ```
- Casting: 
    ```kotlin
    val a = b as String
    ```
- Safe cast:

    Trong TH trên nếu b null -> exception do đối tượng có kiểu nullable không thể cast thành đối tượng non-null, để cast được: 
    ```kotlin
    val a = b as String?

    //hoặc 

    val a = b as? String
    //Nếu b không null a = b, b null thì a = null
    ```
- Smart casting
    ```kotlin
    if (s is String) {
        print(s.length) // x được tự động cast thành kiểu String
    }
    ```

## 6. Cấu trúc điều khiển

### **if**

```kotlin
var a: Int = if (result) 1 else 0

var r: Int = if (result) {
    print("ok")
    1
} else {
    print("fail")
    0
}
```
Nếu là khối lệnh, giá trị ở cuối khối lệnh là giá trị trả về. Khi gán giá trị, nhánh else bắt buộc phải có

### **when**

```kotlin
when (x) {
      1 -> print("x == 1")
      2 -> print("x == 2")
      0, 1 -> print("x == 0 or x == 1")
      is String -> print("is string")
      in 1..10 -> print("x is in the range")
      else -> {
          print("x chả bằng 1 cũng méo bằng 2")
      }
  }

var l: Int = when (s) {
    "hello" -> 0
    "hi" -> 1
    else -> 2
}
```
else là bắt buộc , trừ khi compiler có thể chứng minh được tất cả cá trường hợp đã được cover. 

### **for**

```kotlin
var array: Array<Int> = arrayOf(1,2,5,6,7)

for (i in array) {
}

//with chỉ số
for (i in array.indices) {
    print(array[i]) //13268
}
//or
for (pair in array.withIndex()) {
    println("element at ${pair.index} is ${pair.value}")
}

//xuôi
for (i in 1..11) {
}

//Vòng lặp bước 2
for (i in 1..11 step 2) {
}

//lùi
for (i in 11 downTo 1){
}
```
    Vòng lặp for có thể sử dụng để duyệt bất kỳ thứ gì cung cấp một iterator. VD:
    - Có một member hoặc extension function tên là iterator(), kiểu trả về là Iterator
    - Có một member hoặc extension function next()
    - Có một member hoặc extension function hasNext trả về kiểu Boolean Tất cả 3 function này đều cần được đánh dấu là operator
```kotlin
class DateRange(start: Int, val end: Int) {
    var current = start

    operator fun iterator(): Iterator<Int>{
        return object : Iterator<Int>{
            override fun next(): Int {
                val result = current
                current++
                return result
            }

            override fun hasNext(): Boolean {
                return current <= end
            }
        }
    }
}

//for
for (i in DateRange(1, 10)) {
    print(i) //1..10
}
```

### **while**
```kotlin
while (x > 0) {
    x--
}

do {
    val y = retrieveData()
} while (y != null) // y is visible here!
```

### **break, continue và return**
    - return: thoát khỏi function gần nhất
    - break: thoát khỏi vòng lặp gần nhất
    - continue: tiếp tục bước tiếp theo của vòng lặp gần nhất
- Lable với `break` và `continue`<br>
Để chỉ định break và continue đến một expression nào đó, sử dụng label: `@label`
    ```kotlin
    loop@ for (i in 1..100) {
        for (j in 1..100) {
        if (j > 2) break@loop
        }
    }
    ``` 
    Mặc định, nếu không có label `@loop` ,`break` sẽ thoát ra khỏi vòng lặp gần nhất, vòng lặp j. Với label `@loop`, `break@loop` sẽ thoát ra cả 2 vòng lặp. Tương tự như vậy, `continue` cũng có thể dung label để đi đến bước tiếp theo của vòng lặp

- Label với return
    ```kotlin
    fun foo(){
        var ints:Array<Int> = arrayOf(1,3,5,6)

        ints.forEach lit@ {
        if (it == 0) return @lit
        print(it)
        }
    }
    ```
    câu lệnh return sẽ chỉ thoát ra khỏi function forEach, và sẽ làm tiếp các công việc phía sau. Nếu không có label, return sẽ thoát ra khỏi function foo(). 

    ```kotlin
    fun foo() {
        listOf(1, 2, 3, 4, 5).forEach {
            if (it == 3) return@forEach
            print(it)
        }
        print(" done with implicit label")
    }
    ```
    return tại biểu thức lambda forEarch


## 7. lateinit và lazy
### lateinit
- khởi tạo sau, nó sẽ được gán giá trị tại 1 thời điểm nào đó.Nếu biến được gọi trước khi được gán giá trị, nó sẽ ném ra 1 excepiton và crass app
- kiểu none-null 
- thường chỉ dùng thông qua injection hoặc unit test
- chỉ có thể được sử dụng với các thuộc tính var (mutable)
- không hoạt động với kiểu nguyên thủy
- `::field.isInitialized` để check xem field đã được khởi tạo chưa
- khi không bắt buộc phải dùng thì ưu tiên `var foo: Foo? = null`

### lazy
- khởi tạo lười, 1 hàm sử dụng lambda expression để trả về 1 kiểu Lazy<T> nào đó. Khi chạy lần đầu tiên nó sẽ sử dụng Lazy<T> để truyền vào cho biến . Các lần sau nó sẽ trả lại biến đã được truyền vào trước đó.
- giúp chúng ta có thể tiết kiệm được bộ nhớ và bỏ qua việc khởi tạo biến cho đến khi nó được yêu cầu.
- chỉ có thể được sử dụng cho các thuộc tính val (immutable).
- Trong khi sử dụng Singleton Pattern, chúng ta nên sử dụng lazy, vì nó sẽ được khởi tạo khi sử dụng lần đầu tiên.