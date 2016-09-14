一、 基本的tableview 删除cell，添加cell，cell排序
data 必须和numberofrows,numberofsections 等保持一致。
delete，先delete data中的数据，再调用tableView.deleteRowsAtIndexPaths:withRowAnimation，否则数据不一致会crash
add，同理 先update data数据，再调用 insertRowsAtIndexPaths:withRowAnimation:
move 操作，也要注意处理data中的数据顺序，使两者保持一致

时序图：
1. 用户操作：setEditing:animated:
2. tableView:canEditRowAtIndexPath:  这个可以不实现，默认所有tableviewcell都是可以编辑的
3. tableView:editingStyleForRowAtIndexPath: 可以设置tableView的编辑模式（选择是+ or -）
4. 用户选择（加 or 删）
5. tableView:commitEditingStyle:forRowAtIndexPath:  响应用户操作，根据style调用不用的方法，如果是（-），先处理data数据，再调用deleteRowsAtIndexPath:withRowAnimation:;如果是+操作，先处理数据，再调用tableView的方法 insertRowAtIndexPath:withRowAnimation:

二、 mvc和tableview结合(tableViewController就是典型的mvc模式)
三、 看zone中的setting页面如何与plist结合
四、 做一个headView，下拉展开的例子（headView上面有个小箭头，展开有动画，效果参考一下test04）
五、 做一个可以下拉的tableView例子（数据从plist中加载），结合四来做，先做四
	四五都做好了，见FoldableTable.动画明天补一下(动画可以用transform来做，rotation，有单位矩阵变化和叠加效果两种，分别使用CGAffineTransformMakeRotation和CGAffineTransformRotate)
六、看star的弹幕怎么做的

七、refresh table那个下拉动画效果
如MyRefreshTable的Demo

