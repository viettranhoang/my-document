# CLASSES AND OBJECTS

## 1. Property và field

### Khai báo

```
var <propertyName>[: <PropertyType>] [= <property_initializer>]
    [<getter>]
    [<setter>]
```
`var`: biến<br>
`val`: hằng<br>
`PropertyType`, `property_initializer`, `getter/setter` là optional

### Các hàm getter/setter

```kotlin
var isEmpty: Boolean
    get() {         //
    return field  // hàm 'getter' mặc định
    }               //
    set(value) {
    field = value
    }

var isEmpty: Boolean
    get() = this.size == 0    // hàm 'getter' tự định nghĩa
    set (value){              //
    print("Setter: $value") //hàm 'setter' tự định nghĩa
    field = value           //
    }
```
Có thể xác định visibility modifier của hàm setter. Lưu ý: modifier của setter phải có phạm vi không được lớn hơn phạm vi modifier của property. 

```kotlin
var setterVisibility: String = "abc"
    private set // hàm 'setter' có modifier là 'private' và việc implement là mặc định
```

### Backing field
    Khi access đến một property, thực chất, hàm setter và getter của property name sẽ được gọi.
    field chỉ có thể sử dụng bên trong các hàm getter/setter và field sẽ được tự động gen cho property nếu một trong các hàm getter/setter tham chiếu đến nó. Nếu không, property sẽ không có field

### Compile-time constant
    Các thuộc tính mà giá trị của chúng được biến đến lúc compile có thể được đánh dấu là compile time constant, sử dụng từ khóa const. Những property để đạt được cần thỏa mãn nhưng yêu cầu sau:

    - Là top-level property hoặc là member của một object(object trong Kotlin là một singleton, không phải là đối tượng)
    - Được khởi tạo với kiểu String hoặc kiểu nguyên thủy(Int, Float, Char, Boolean...), không thể là một đối tượng được định nghĩa
    - Không được có hàm getter tự định nghĩa

### Late-initialized property
`lateinit` biến khởi tạo sau
```kotlin
class Teacher(var name: String, var age: Int) {
  lateinit var className: String
}
```
Yêu cầu để sử dụng được từ khóa lateinit là:

- Phải sử dụng với var property được khai báo bên trong một class nhưng không phải là trong primary constructor. - property này không được có các hàm getter/setter tự định nghĩa mà phải dùng các hàm mặc định
- Kiểu của các property này phải là non-null và không thể là kiểu dữ liệu nguyên thủy(Int, Float,Char, Boolean...)
- Nếu truy cập các property này khi chúng chưa được khởi tạo, xin chúc mừng: kotlin.UninitializedPropertyAccessException sẽ xuất hiện.

### Overriding property
```kotlin
open class Foo {
    open val x: Int get { ... }
    }

class Bar1 : Foo() {
    override val x: Int = ...
}
```

## 2. Class và kế thừa

### Class
```kotlin
class Invoice {
}
class Invoice
```
`visibility modifier` (access modifier) mặc định là public

### Constructor

- **Primary Constructor**<br>
    Kotlin có một primary constructor và có thể có một hoặc nhiều secondary constructors.

    ```kotlin
    class Person(firstName: String) {
    }

    class Customer public @Inject constructor(name: String) { ... }
    ```
    nếu có `visibility modifier` hoặc `annotation` thì từ khóa `constructor` sẽ cần phải có:

    `Primary constructor` không chứa bất cứ dòng code nào, nếu muốn thực hiện các logic code ngay sau `primary constructor` có thể thực hiện bằng cách khởi tạo ra một block `{}` với từ khóa tiền tố `init` ở trước:

    ```kotlin
    class Customer(name: String, var age: Int) {
        val customerKey = name.toUpperCase()

        init {
            print("Customer's name is $name")
        }

        fun a() {
            print(name) //k sử dụng được
            print(age) //ngon
        }
    }
    ```
    Các param của primary constructor nếu khai báo `name: String`, nó chỉ được sử dụng trong các block init{...} và để khởi tạo các property trong body class , không thể sử dụng trong các function của class hoặc các instance của class đó. Để coi các param của primary constructor như một property trong class, ta thêm var hoặc val

- **Secondary Constructors**
    ```kotlin
    class Person {
        constructor(parent: Person) {
            parent.children.add(this)
        }
    }
    ```
    Nếu như class có primary constructor thì mỗi secondary constructor phải khởi tạo giá trị cho primary constructor bằng cách gọi primary constructor một cách gián tiếp hoặc trực tiếp:
    ```kotlin
    class Invoice(id: Int ) {

        constructor(id: Int, name: String) : this(id) {
            //this ở đây gọi trực tiếp đến primary constructor
            // và truyền giá trị id cho primary constructor
        }

        constructor(id: Int, name: String, version: Int) : this(id, name) {
            //this ở đây gọi trực tiếp secondary constructor 2 tham số
            // và được coi là gọi gián tiếp primary constructor qua secondary constructor 2 tham số đó
        }

    }
    ```
- **Tạo instance cho class**
    ```kotlin
    val invoice = Invoice()

    val customer = Customer("Joe Smith")
    ```
    Trong kotlin không có `new`

### Kế thừa (Inheritance)
Mọi class kế thừ từ lớp cha `Any`. `Any` không phải là Object, vì `Any` không có bất cứ một function nào khác ngoài các function là `equals()`, `hashCode()` và `toString()`
```kotlin
open class Base(p: Int)

class Derived(p: Int) : Base(p)
```
- **Overriding method**
    
    Yêu cầu khai báo `open` để override method, nếu không muốn bất cứ class nào override lại method đã override khai báo với `final`
    ```kotlin
    open class Base {
        open fun v() {}
        fun nv() {}
    }
    class Derived() : Base() {
        override fun v() {}
    }
    class Derived() : Base() {
        final override fun v() {}
    }

- [**Overriding property**](#overriding-property)
- **Overriding rule**

    Đa thừa kế trong Kotlin, để gọi đích thị đến function f() của class A hay interface B ta sử dụng super<Base>

    ```kotlin
    open class A {
        open fun f() { print("A") }
        fun a() { print("a") }
    }

    interface B {
        fun f() { print("B") } // interface members are 'open' by default
        fun b() { print("b") }
    }

    class C() : A(), B {
        // The compiler requires f() to be overridden:
        override fun f() {
            super<A>.f() // call to A.f()
            super<B>.f() // call to B.f()
        }
    }
    ```
- **Abstract Classes**

    Tương tự với abstract class trong java,  các thành phần được khai báo abstract trong một class abstract không cần phải khai báo body
    ```kotlin
    abstract class Base {
        abstract fun calculate()
    }


    class Invoice(id: Int) : Base() {
        override fun calculate() {

        }
    }
    ```
