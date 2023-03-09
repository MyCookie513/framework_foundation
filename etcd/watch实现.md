## watch 机制：

> watchGroup包含两种Watcher:
>
> 一种是key Watchers，数据结构是每个key对应一组Watcher
>
> 另外一种是range Watchers，数据结构是一个线段树，可以方便地通过区间查找到对应的Watcher



#### 线段树（前缀匹配）+红黑染色（确保平衡）：

> 监听写操作，快速映射到监听的watchers

pkg/adt/interval_tree.go







### 抽象可比较边界：

1. 边界直接是直接比较大小
2. 区间之间是比较是否有交集 ，完全没有交集，在右边则为1 ，在左边则为-1

```golang
// Comparable is an interface for trichotomic comparisons.
type Comparable interface {
	// Compare gives the result of a 3-way comparison
	// a.Compare(b) = 1 => a > b
	// a.Compare(b) = 0 => a == b
	// a.Compare(b) = -1 => a < b
	Compare(c Comparable) int
}


type Interval struct {
	Begin Comparable
	End   Comparable
}

// Compare on an interval gives == if the interval overlaps.
func (ivl *Interval) Compare(c Comparable) int {
	ivl2 := c.(*Interval)
	ivbCmpBegin := ivl.Begin.Compare(ivl2.Begin)
	ivbCmpEnd := ivl.Begin.Compare(ivl2.End)
	iveCmpBegin := ivl.End.Compare(ivl2.Begin)

	// ivl is left of ivl2
	if ivbCmpBegin < 0 && iveCmpBegin <= 0 {
		return -1
	}

	// iv is right of iv2
	if ivbCmpEnd >= 0 {
		return 1
	}

	return 0
}
```







## 插入区间：

> 完全就是一个根据左边界生成的一个二叉树+红黑特性



```golang
// Insert adds a node with the given interval into the tree.
func (ivt *intervalTree) Insert(ivl Interval, val interface{}) {
   y := ivt.sentinel
   z := ivt.createIntervalNode(ivl, val)
   x := ivt.root
   for x != ivt.sentinel {
      y = x
      //todo 如果新创建的区间的起点 小于 此节点的起点
      if z.iv.Ivl.Begin.Compare(x.iv.Ivl.Begin) < 0 {
         x = x.left
      } else {
         x = x.right
      }
   }

   z.parent = y
   if y == ivt.sentinel {
      ivt.root = z
   } else {
      if z.iv.Ivl.Begin.Compare(y.iv.Ivl.Begin) < 0 {
         y.left = z
      } else {
         y.right = z
      }
      //todo 插入父节点进行更新max
      y.updateMax(ivt.sentinel)
   }
   z.c = red

   ivt.insertFixup(z)
   ivt.count++
}
```



## 查询：查看一个区间是否与区间树中的节点是否有重叠 

  

​                                    [区间0] L.......



​                [区间1]L.......                         [区间2]L........



1. 如果查询区间完全在左边，则只查询区间1既可
2. 如果查询区间完全在右边，则需要查询区间2和区间1两部分，因为区间1的end未可知
3. 如果有交集，<mark>则必定命中区间0，同时也需要判定区间1和区间2</mark>



```golang

// visit will call a node visitor on each node that overlaps the given interval
func (x *intervalNode) visit(iv *Interval, sentinel *intervalNode, nv nodeVisitor) bool {
	if x == sentinel {
		return true
	}
	//todo 此节点的区间是否和目标值有交集
	v := iv.Compare(&x.iv.Ivl)
	switch {
	case v < 0:
		if !x.left.visit(iv, sentinel, nv) {
			return false
		}
	case v > 0:
    // 判断最长边界是否包含，如果最长边界也包含的话，均到左右节点去寻找
		maxiv := Interval{x.iv.Ivl.Begin, x.max}
		if maxiv.Compare(iv) == 0 {
			if !x.left.visit(iv, sentinel, nv) || !x.right.visit(iv, sentinel, nv) {
				return false
			}
		}
	default:
    
		if !x.left.visit(iv, sentinel, nv) || !nv(x) || !x.right.visit(iv, sentinel, nv) {
			return false
		}
	}
	return true
}
```

















