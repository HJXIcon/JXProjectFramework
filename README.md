# JXProjectFramework
小项目框架设计(MVVM + AFN封装 + FMDB)

![image](http://www.saitjr.com/wp-content/uploads/2015/10/ios-framework-reactivecocoa-mvvmafnetworking-fmdb-2-1024x589.png)


#### *自定义 cell*
<p>
因为想到实际项目中，可能会有比较复杂的 `cell`，所以`Demo`中写的是一个比较完整的设计方式（如果单单看这个 `Demo` 的话，这个自定义 `cell` 太简单，没必要有一个单独的 `VM`，有点过度设计）。

`cell` 中的构思是，`cell` 有一个 `CellVM` 来管理 `cell` 中要显示的数据，`CellVM` 来自于 *VC* 中，`dataSource` 数组。处理方式具体是：在网络请求完成以后，将字典->模型，然后通过模型，初始化 `CellVM`，然后将 `CellVM` 放入 `dataSource` 数组。


</p>

