







### innoDB简介：

>* innoDB 是持久化到磁盘中的，但是磁盘中读取的速度是非常慢的，所以呢，我们将读取的单位放大，划分为page为单元
>
>  一次性读取16KB。
>
>* 