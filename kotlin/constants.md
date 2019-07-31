# Constants trong Kotlin

## Companion objects
KHÔNG có từ khoá static trong Kotlin. 1 cách đơn giản để truy cập static tới field hay method của class là đặt chúng trong một `companion object`
```kotlin
class Constants {  
  companion object {
    val FOO = "foo"
  }
}
```
decompiling...
```java
public final class Constants {  
   @NotNull
   private static final String FOO = "foo";
   public static final Constants.Companion Companion = new Constants.Companion((DefaultConstructorMarker)null);

   public static final class Companion {
      @NotNull
      public final String getFOO() {
         return Constants.FOO;
      }

      private Companion() {
      }

      // $FF: synthetic method
      public Companion(DefaultConstructorMarker $constructor_marker) {
         this();
      }
   }
}
```
`companion object` là 1 object thực sự.<br>
`Constants.FOO` -> `Constants.Companion.getFOO()`<br>
-> sinh thừa 1 object và một method

## const vals
const chỉ áp dụng với kiểu nguyên thủy và String
```kotlin
class Constants {  
  companion object {
    const val FOO = "foo"
  }
}
```
```java
public final class Constants {  
   @NotNull
   public static final String FOO = "foo";
   public static final Constants.Companion Companion = new Constants.Companion((DefaultConstructorMarker)null);

   public static final class Companion {
      private Companion() {
      }

      // $FF: synthetic method
      public Companion(DefaultConstructorMarker $constructor_marker) {
         this();
      }
   }
}
```
Hàm get đã biến mất và chúng ta thực sự đã truy cập trực tiếp tới static field. Nhưng compiler vẫn sinh ra một `companion object` thừa. khắc phục với @JvmField sẽ giúp cho FOO trở thành public static final

```kotlin
class Constants {  
  companion object {
    @JvmField val FOO = Foo()
  }
}
```
Sự khác biệt giữa của `const` và `@JvmField` đó là: việc truy cập với một const val được inline bởi compiler, trong khi đó @JvmField thì không.

## object
nhét tất vô `object` -> KQ giống Java
```kotlin
object Constants {
    const val Foo = "foo"
}
```

## Bỏ qua class và object
Nếu chúng ta chỉ cần lưu một tập các constants thì chúng ta có thể bỏ qua class và object rồi sử dụng val
```kotlin
//file Constants.kt
const val FOO = "foo"
```
Kết quả deompiler chính xác như viết bằng Java
```java
public final class ConstantsKt {  
   @NotNull
   public static final String FOO = "foo";
}
```

Để gọi các field này từ java code thì gọi `ConstantsKt.FOO`. Để tránh hậu tố `Kt` ở tên class, hãy dùng annotation `file:@JvmName` trên đầu file 
```kotlin
@file:JvmName("Constants")
```
Compier sẽ sinh ra giá trị cho tên class đó
```java
public final class Constants {  
   @NotNull
   public static final String FOO = "foo";
}
```
