# JXProjectFramework
小项目框架设计(MVVM + AFN封装 + FMDB)

![image](http://www.saitjr.com/wp-content/uploads/2015/10/ios-framework-reactivecocoa-mvvmafnetworking-fmdb-2-1024x589.png)


#### *自定义 cell*
<p>
因为想到实际项目中，可能会有比较复杂的`cell`，所以`Demo`中写的是一个比较完整的设计方式（如果单单看这个`Demo`的话，这个自定义`cell`太简单，没必要有一个单独的`VM`，有点过度设计）。

`cell` 中的构思是，`cell` 有一个 `CellVM` 来管理 `cell` 中要显示的数据，`CellVM` 来自于 *VC* 中，`dataSource` 数组。处理方式具体是：在网络请求完成以后，将字典->模型，然后通过模型，初始化 `CellVM`，然后将 `CellVM` 放入 `dataSource` 数组。


</p>

#### 网络请求
<p>
在页面销毁、重新请求等情况下，需要将还在队列中的请求取消，以免占用资源。
考虑到这一点，结合我的网络请求在`VM`发送，权衡再三，在`BaseViewModel`的基础上，再进行了一次封装 —— `RequestViewModel`。这个`VM`有`AFHTTPSessionManager`类的属性，一个该属性的懒加载和一个在`dealloc`中取消请求方法。<br></br>
在以前使用`MVC`的时候，我会对`AFNetworking`进行再次的封装，这样更像是一个`MVCS`的设计，目的是防止`VC`过重，现在把这部分代码扔在了`VM` 中，看起来还好，所以并没有对 AFNetworking 再次封装。
</p>

