1. 基本的tableview 删除cell，添加cell，cell排序
data 必须和numberofrows,numberofsections 等保持一致。
delete，先delete data中的数据，再调用tableView.deleteRowsAtIndexPaths:withRowAnimation，否则数据不一致会crash
add，同理 先update data数据，再调用 insertRowsAtIndexPaths:withRowAnimation:
move 操作，也要注意处理data中的数据顺序，使两者保持一致

2. mvc和tableview结合
3. 看zone中的setting页面如何与plist结合
