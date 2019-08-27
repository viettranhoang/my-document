# BEST PRACTICE: RECYCLER VIEW WITH DATABIDING AND LISTADAPTER 

Mình là 1 con người thích sự đơn giản và không thích viết đi viết lại 1 đoạn code quá nhiều lần. Cứ dễ hiểu, đơn giản, viết code ít là mình quất. Chém cho bon mồm thế thôi chung quy lại vẫn là do tính lười :v Vì vậy trong bài này mình sẽ đi sâu 1 chút về thực hành, làm sao để tạo BaseAdapter có thể covert được hầu hết các trường hợp sử dụng cơ bản của recycler view mà hiệu năng cũng được tối ưu hết cỡ. Để khi tạo hàng chục adapter, ta chỉ việc kế thừa BaseAdapter và viết 1 2 dòng là done, giảm thiểu viết code lặp, dễ nhìn trong trắng à nhầm trong sáng.

Đại khái thì hàng nó ntn: 

![](./images/rcv00.PNG)

Kết quả: 

![](./images/rcv_result.gif)

# ListAdapter

Từ thuở sơ khai cho đến tận ngày này, `RecyclerView.Adapter` vẫn đang thống trị thế giới dev android, nhưng nó vẫn có 1 số điều hạn chế. Khi có sự thay đổi database (thêm sửa xóa), chúng ta set lại list ntn? Cao thủ thì dùng `notifyItemChanged(int pos)`, `notifyItemInserted(int pos)`, `notifyItemRemoved(int pos)` cơ mà phức tạp vãi chưỡng. Gà mờ như mình thì làm phát `notifyDataSetChanged()` cho ăn chắc cái đã, cơ mà cách này thì hiệu năng rất thấp, đặc biệt là với list nhiều item, View bị nháy, và animation k có, trải nhiệm người dùng ứ sướng.

Để khắc phục nhược điểm đó thì DiffUtils (sử dụng thuật toán của Eugene W. Myers để tính số cập nhật tối thiểu) ra đời nhưng vẫn phức tạp, r mới năm 2018 thì phải, ListAdapter ra đời sp cho DiffUtils, khiến cho mọi việc ngon ngọt hơn. All hàm trên thay bằng `summitList()`, so izi, tính toán, thuật toán thế nào thì kệ mé nó hôi =))) Đây là 1 xíu animation sau khi dùng ListAdapter:

![](./images/rcv_animation.gif)

## DiftUtils

Trước khi tìm hiểu ListAdapter là gì, chúng ta cùng đả lại 1 thứ mà có thể bạn chưa biết đó là `DiffUtils`.

`DiffUtil` là 1 Class cung cấp các hàm tính toán sự khác biệt giữa 2 danh sách và đưa ra 1 danh sách sự thay đổi (thêm phần tử, xóa và chỉnh sửa phần tử) giữa 2 danh sách đó. Dựa vào đó thì DiffUtil được sử dụng để tính toán sự khác biệt về dữ liệu của RecyclerView trong 2 lần cập nhật. Hơn nữa DiffUtil còn cung cấp thêm lựa chọn có thể chạy ở background thread. Để implement nó thì cũng có vài hàm khá mệt, nhưng giờ có listAdapter rồi nên chúng ta chỉ cần mỗi cái `DiffUtil.ItemCallback` hôi, trông nó ntn: 

```kotlin
data class MainModel(val id: String, val title: String) {

    class MainDiffCallback : DiffUtil.ItemCallback<MainModel>() {

        override fun areItemsTheSame(oldItem: MainModel, newItem: MainModel) = oldItem.id == newItem.id

        override fun areContentsTheSame(oldItem: MainModel, newItem: MainModel) = oldItem == newItem
    }
}
```

`DiffUtil.ItemCallback` yêu cấu chúng ta override 2 hàm để thực hiện việc so sánh.

- Hàm `areItemsTheSame` để kiểm tra xem 2 Object có khác nhau hay không, thường ở đây mọi người lên so sánh 2 khóa chính (những gì mà chỉ Object đấy có hoặc điểm khác nhau đặc trưng giữa 2 đối tượng) của 2 object
- Hàm `areContentsTheSame` là để kiểm tra sự khác biệt về giữa liệu giữa 2 Object có cùng khóa chính. Các bạn lưu ý ở đây mình viết return oldItem == newItem là do object MainModel mình sử dụng kiểu data class của Kotlin nên khi so sánh oldItem == newItem thực chất là so sánh các trường nằm trong class. Còn nếu bạn dùng class thường thì ở đây là nơi bạn định nghĩa những trường nào thay đổi trong Object

## ListAdapter

`ListAdapter` thực chất là 1 Wraper của `RecyclerView.Adapter` và cung cấp thêm cho chúng ta các sự kiện, các hàm để hỗ trợ DiffUtil

Khi implement ListAdapter với cái DiffUtils ở trên thì cũng sâu i zi, k khác gì adapter thường ngoài việc extend adapter từ ListAdapter: 

```kotlin
class MainAdapter: ListAdapter<MainModel, MainAdapter.ViewHolder>(
    AsyncDifferConfig.Builder<MainModel>(MainModel.MainDiffCallback())
        .setBackgroundThreadExecutor(Executors.newSingleThreadExecutor())
        .build()
)
```

và k cần override lại `getItemCount()` hay tạo list chứa model trong adapter nữa. list trong đây là `currentList` được tạo sẵn trong ListAdapter rồi, ae chỉ việc lôi ra sài hôi. 1 điều nữa cũng chả cần tạo hàm set lại list khi có thay đổi, sài luôn `summitList(list)`. Mọi tính toán hay notify cứ để thằng cha ListAdapter lo. Sao mà nó dễ thế k biết :v 

```kotlin
.setBackgroundThreadExecutor(Executors.newSingleThreadExecutor())
```

Thằng cu này để chỉ định là MainDiffCallback được chạy dưới BackgroundThread để tránh gây giật lag View

# Databinding

Bạn nào biết rồi thì lượn khỏi đọc nữa nha, nhảy sang phần sau đê :D
Bài viết tập trung vào recycler view lên mình sẽ chỉ nói ngắn gọn ntn, nó là cái thứ mà cho dev nhồi 1 thằng object vô file layout, rồi lấy các thuộc tính của object đó set trực tiếp vô View trong layout. Trông nó ntn:

```xml
<?xml version="1.0" encoding="utf-8"?>
<layout xmlns:android="http://schemas.android.com/apk/res/android">
    <data>
        <variable
                name="item"
                type="com.vit.demoloadmorerecyclerview.ui.MainModel"/>

        <variable
                name="listener"
                type="com.vit.demoloadmorerecyclerview.ui.MainModel.OnClickMainItemListener"/>

    </data>
    <TextView
            android:padding="20dp"
            android:onClick="@{() -> listener.onClickMainItem(item)}"
            android:text="@{item.title}"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"/>
</layout>
```

xong rồi trong java code set cho cái object đã gắn vào layout đó. thế hôi, để biết thêm chi tiết xem [Doc](https://developer.android.com/topic/libraries/data-binding)

# BaseAdapter

Mọi lí thuyết đã xong, cái quan trọng mình muốn nói ở bài này là kết hợp 2 thằng ListAdapter và Databinding để đẻ ra thằng BaseAdapter để cuộc đời trở lên tươi đẹp hơn, giống như đưa cho nông dân chiếc máy cầy thay vì cái cày và con trâu và sức người :D

Bây giờ chúng ta sẽ đi từng bước để thực hiện nha: 

## 1. Model
Object Model Chứa DiffUtil và listener khi click vô item
```kotlin
//MainModel.kt

data class MainModel(val id: String, val title: String) {

    class MainDiffCallback : DiffUtil.ItemCallback<MainModel>() {

        override fun areItemsTheSame(oldItem: MainModel, newItem: MainModel) = oldItem.id == newItem.id

        override fun areContentsTheSame(oldItem: MainModel, newItem: MainModel) = oldItem == newItem
    }

    interface OnClickMainItemListener{
        fun onClickMainItem(item: MainModel)
    }
}
```

## 2. Item layout
Flow theo databinding, chứa `item` và `listener` là model và sự kiện click item vừa tạo ở trên
```xml
<!--main_item.xml-->

<?xml version="1.0" encoding="utf-8"?>
<layout xmlns:android="http://schemas.android.com/apk/res/android">
    <data>
        <variable
                name="item"
                type="com.vit.demoloadmorerecyclerview.ui.MainModel"/>

        <variable
                name="listener"
                type="com.vit.demoloadmorerecyclerview.ui.MainModel.OnClickMainItemListener"/>

    </data>
    <TextView
            android:padding="20dp"
            android:onClick="@{() -> listener.onClickMainItem(item)}"
            android:text="@{item.title}"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"/>
</layout>
```

Tiện thể thêm cái layout item cho loadmore: 

```xml
<!-- item_load_more.xml -->
<?xml version="1.0" encoding="utf-8"?>
<layout xmlns:android="http://schemas.android.com/apk/res/android">
    <RelativeLayout
            android:layout_width="match_parent"
            android:layout_height="30dp">
        <ProgressBar
                android:layout_centerHorizontal="true"
                android:layout_width="20dp"
                android:layout_height="20dp"/>
    </RelativeLayout>
</layout>
```

## 3. BaseViewHolder

```kotlin
//BaseViewHolder.kt

open class BaseViewHolder<T>(
    private val binding: ViewDataBinding,
    private val listener: Any?
) :
    RecyclerView.ViewHolder(binding.root) {

    open fun bindData(t: T? = null, childAdapter: Any? = null) {
        if (t != null) binding.setVariable(BR.item, t)
        if (listener != null) {
            binding.setVariable(BR.listener, listener)
        }
        if (childAdapter != null) {
            binding.setVariable(BR.adapter, childAdapter)
        }
        binding.executePendingBindings()
    }
}
```

T là 1 generic, ở đây là kiểu của object model.

Hàm `bindData()` phục vụ cho `onBindViewHolder()` trong adapter.

`BR` là 1 class được auto gen để chứa các id của resource trong layout có sử dụng data binding. Thằng `BR.item` là 1 biến int final được auto gen ra trong class BR khi chúng ta khai báo ntn và cũng là id của nó luôn

```xml
<variable
        name="item"
        type="com.vit.demoloadmorerecyclerview.ui.MainModel"/>
```

`childAdapter` được sử dụng trong TH adpater lồng adapter

Để tránh crash với 1 số adapter k có các `item` hay `listener` ta lên check null r hãng set binding.

## 4. BaseAdapter

```kotlin
abstract class BaseAdapter<T>(diffCallback: DiffUtil.ItemCallback<T>) : ListAdapter<T, BaseViewHolder<T>>(
    AsyncDifferConfig.Builder<T>(diffCallback)
        .setBackgroundThreadExecutor(Executors.newSingleThreadExecutor())
        .build()
) {

    @LayoutRes
    @NonNull
    abstract fun getLayoutResource(position: Int): Int

    open fun getListener(): Any? = null

    open fun getChildAdapter(item: T): Any? = null

    open var isLoadMore = false

    val state = ObservableInt().apply {
        set(INIT_STATE)
    }

    private val childAdapters = ArrayList<Any>()

    override fun onCreateViewHolder(viewGroup: ViewGroup, viewType: Int): BaseViewHolder<T> {
        val binding =
            DataBindingUtil.inflate<ViewDataBinding>(LayoutInflater.from(viewGroup.context), viewType, viewGroup, false)
        return BaseViewHolder(binding, getListener())
    }

    override fun onBindViewHolder(holder: BaseViewHolder<T>, position: Int) {
        if (position >= currentList.size) {
            holder.bindData()
            return
        }
        val childAdapter = getChildAdapter(getItem(position))
        childAdapter?.let { childAdapters.add(it) }
        holder.bindData(getItem(position), childAdapter = childAdapter)
    }

    override fun getItemCount(): Int {
        return if(isLoadMore && currentList.isNotEmpty()) currentList.size + 1 else currentList.size
    }

    override fun getItemViewType(position: Int): Int {
        return if (position == currentList.size) R.layout.item_load_more
        else getLayoutResource(position)
    }

    fun setList(list: List<T>) {
        if (list.isEmpty()) {
            submitList(null)
            notifyDataSetChanged()
        } else submitList(list)
        state.apply {
            set(list.size)
            notifyChange()
        }
    }

    fun addList(list: List<T>) {
        if (list.isEmpty()) {
            isLoadMore = false
            notifyItemChanged(currentList.size)
            return
        }
        val l = currentList.toMutableList()
        l.addAll(list)
        setList(l)
    }

    fun loading() {
        state.apply {
            set(LOADING_STATE)
            notifyChange()
        }
    }

    fun error() {
        state.apply {
            set(ERROR_STATE)
            notifyChange()
        }
    }

    @Nullable
    fun getItemByPosition(position: Int): T? = if (position >= itemCount) null else currentList[position]

    @Nullable
    fun getChildAdapterByPosition(position: Int): Any? = if (position >= itemCount) null else childAdapters[position]

    companion object {
        const val EMPTY_STATE = 0
        const val INIT_STATE = -1
        const val LOADING_STATE = -2
        const val ERROR_STATE = -3
    }
}
```

Các TH hợp use: 
- loadmore
- nodata view
- loading view
- lồng adapter

Giải thích chút:
- `state` là 1 `ObservableInt` để thông báo cho view rằng quá trình load data như đang loading, error, hoặc success (là size của list). Cái này bạn có thể dùng hoặc không. Nếu dùng ViewModel thì mình nghĩ là không cần.
-  `childAdapters` dùng cho TH 1 adapterphức tạp chứa 1 adapter khác, vẫn dùng đc cái Base này ngon lành
- `getListener` sự kiện click item nếu cần sẽ được override lại ở adapter thật
- `isLoadMore` chế độ loadmore, mặc định là false
- `getLayoutResource` là thằng item layout đóa 
- `addList` dùng khi loadmore

có thể các bạn sẽ khó hiểu 1 chút cơ mờ cứ thử copy vô project và dùng thử là hiểu :v

## 5. Adapter
và đây là thành quả khi extend từ BaseAdapter, khá ngắn gọn, giảm bớt code mẫu, với các TH nhiều item cũng dễ handle trong getLayoutResource với position hoặc adapter lồng thì gọi `getChildAdapter` hôi

```kotlin
//MainAdapter.kt

class MainAdapter : BaseAdapter<MainModel>(MainModel.MainDiffCallback()) {

    override fun getLayoutResource(position: Int): Int = R.layout.main_item

    override var isLoadMore: Boolean = true

    override fun getListener(): Any? = object : MainModel.OnClickMainItemListener {
        override fun onClickMainItem(item: MainModel) {
            Log.i("onClickMainItem ", item.title)
        }
    }
}
```

## 6. Activity

```kotlin
//MainActivity.kt

class MainActivity : BaseActivity<MainActivityBinding>() {

    override fun getLayoutResource(): Int = R.layout.main_activity

    private val mainAdapter = MainAdapter()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        with(binding) {
            adapter = mainAdapter

            rcv.setLoadMoreListener<LinearLayoutManager> {
                postDelay(500) { mainAdapter.addList(fetchData(it)) }
            }

            layoutRefresh.setOnRefreshListener {
                getListFromServer()
            }
        }

        getListFromServer()
    }

    fun getListFromServer() {
        mainAdapter.loading()
        when(Random.nextInt(1, 4)) {
            1 -> postDelay(1000) { mainAdapter.setList(fetchData()) }
            2 -> postDelay(1000) { mainAdapter.setList(emptyList()) }
            3 -> postDelay(1000) { mainAdapter.error() }
        }
    }

    fun fetchData(offset: Int = 0) = ArrayList<MainModel>().apply {
        if(offset < 101) for (i in offset+1..offset+20) add(MainModel("id$i", "title $i"))
    }
}
```

`getListFromServer()` giả lập cuộc gọi từ server như list rỗng thì hiện no data view, error thì hiện error view, và TH success có data với hàm `fetchData`

`layoutRefresh.setOnRefreshListener` TH sử dụng SwipRefershLayout để load lại list

`rcv.setLoadMoreListener<LinearLayoutManager>` TH load more

## 7. Activity Layout

```xml
<!-- main_activity.xml -->

<?xml version="1.0" encoding="utf-8"?>
<layout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:tools="http://schemas.android.com/tools"
        xmlns:app="http://schemas.android.com/apk/res-auto">
    <data>
        <variable
                name="adapter"
                type="com.vit.demoloadmorerecyclerview.ui.MainAdapter"/>

        <import type="android.view.View"/>
    </data>
    <RelativeLayout
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            tools:context=".ui.MainActivity">

        <androidx.swiperefreshlayout.widget.SwipeRefreshLayout
                android:id="@+id/layout_refresh"
                app:refreshing="@{adapter.state.get() == -2 &amp;&amp; viewLoading.getVisibility() == View.GONE}"
                android:layout_width="match_parent"
                android:layout_height="match_parent">

            <androidx.recyclerview.widget.RecyclerView
                    android:id="@+id/rcv"
                    android:adapter="@{adapter}"
                    android:orientation="vertical"
                    app:layoutManager="androidx.recyclerview.widget.LinearLayoutManager"
                    android:layout_width="match_parent"
                    android:layout_height="match_parent"/>

        </androidx.swiperefreshlayout.widget.SwipeRefreshLayout>

        <ProgressBar
                android:id="@+id/viewLoading"
                app:gone="@{adapter.state.get() != -2}"
                android:visibility="visible"
                android:layout_centerInParent="true"
                android:layout_width="50dp"
                android:layout_height="50dp"/>

        <LinearLayout
                app:visibility="@{adapter.state.get() == 0 || adapter.state.get() == -3}"
                android:gravity="center"
                android:layout_centerInParent="true"
                android:orientation="vertical"
                android:layout_width="match_parent"
                android:layout_height="match_parent">
            <ImageView
                    android:src="@mipmap/ic_launcher"
                    android:layout_width="100dp"
                    android:layout_height="100dp"/>

            <TextView
                    android:layout_marginTop="20dp"
                    android:id="@+id/text_nodata"
                    android:text="@{adapter.state.get() == 0 ? @string/no_data : @string/error}"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"/>
        </LinearLayout>

    </RelativeLayout>
</layout>
```

Truyền adapter vào và xử lý mấy TH nodata view hay loading error theo `adapter.state.get()`

**Done!**

TH sử dụng trên mình đã áp dụng vào khá nhiều adapter trong project công ty, khá ok :D 

Để custom hơn, bạn có thể tạo 1 binding adapter để set list cho recycler view. Trong bài sau mình sẽ viết thêm về việc dùng đám trên với ViewModel và LiveData =))))

>Nguồn [1](https://viblo.asia/p/cach-bind-list-du-lieu-toi-recyclerview-voi-android-data-binding-m68Z00M6ZkG) [2](https://developer.android.com/topic/libraries/data-binding/generated-binding) [3](https://guides.codepath.com/android/using-the-recyclerview) [4](https://proandroiddev.com/android-data-binding-listadapter-9e72ce50e8c7)
