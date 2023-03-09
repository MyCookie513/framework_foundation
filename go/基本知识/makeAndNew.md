## New

> func new(Type) *Type

* 它只接受一个参数，这个参数是一个类型，分配好内存后，返回一个指向该类型内存地址的指针。
* 同时请注意它同时把分配的内存置为零，也就是类型的零值



## make

> func make(t Type, size ...Integer) Type

* make也是用于内存分配的，但和new不同，它只用于通道chan、映射map以及切片slice的内存创建
* 创建内存并且进行结构的初始化。 
* 返回的也是引用类型本身。