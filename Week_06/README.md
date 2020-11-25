
## 作业

### 1. 基于电商交易场景（用户、商品、订单），设计一套简单的表结构

地址：Week_06/sql/e-mall.sql

### 2. 尝试对各个数据库测试 100 万订单数据的增删改查性能。

### MySQL5.7
 
存量数据为 0 开始，通过存储过程新增 100 万耗时为 153s

插入语句中使用了几个内置函数，对性能有一定影响，具体影响了多少不知道怎么评估

#### 通过主键查询其它字段
``` sql
SELECT
	`bid`,
	`customer_bid`,
	`address_bid`,
	`preferential_bid`,
	`product_unit_price`,
	`product_num`,
	`post_prize`,
	`pay_price`,
	`pay_method`,
	`pay_status`,
	`order_status`,
	`post_need`,
	`logistics_id` 
FROM
	order_info 
WHERE
	id = 500000;
``` 

极快，耗时忽略不计，耗时0ms，扫描行数：1

#### 通过唯一索引查询其它字段

```sql
	SELECT
	`bid`,
	`customer_bid`,
	`address_bid`,
	`preferential_bid`,
	`product_unit_price`,
	`product_num`,
	`post_prize`,
	`pay_price`,
	`pay_method`,
	`pay_status`,
	`order_status`,
	`post_need`,
	`logistics_id` 
FROM
	order_info 
WHERE
	bid = 'db5ff7d22f2e11ebaefb25a5cb0ee03b';
```
极快，耗时忽略不计，耗时0ms，扫描行数：1

#### 通过普通索引查询其它字段

```sql
	SELECT
	`bid`,
	`customer_bid`,
	`address_bid`,
	`preferential_bid`,
	`product_unit_price`,
	`product_num`,
	`post_prize`,
	`pay_price`,
	`pay_method`,
	`pay_status`,
	`order_status`,
	`post_need`,
	`logistics_id` 
FROM
	order_info 
WHERE
	bid = 'db5ff7d22f2e11ebaefb25a5cb0ee03b';
```
极快，耗时9ms，扫描行数：633
#### 通过非索引字段查询其它字段

```sql
	SELECT
	`bid`,
	`customer_bid`,
	`address_bid`,
	`preferential_bid`,
	`product_unit_price`,
	`product_num`,
	`post_prize`,
	`pay_price`,
	`pay_method`,
	`pay_status`,
	`order_status`,
	`post_need`,
	`logistics_id` 
FROM
	order_info 
WHERE
	address_bid = 'b7baa1742f2e11ebaefb25a5cb0ee03b902';
```

耗时833ms，扫描行数：95270


#### 通过非索引字段查询主键

```sql
	SELECT
	`id`
FROM
	order_info 
WHERE
	address_bid = 'b7baa1742f2e11ebaefb25a5cb0ee03b902';
```

耗时500ms，扫描行数：95270

#### 查询性能小结
|场景|耗时|扫描行数|原因分析|
|---|----|----|---|
|主键查字段|0ms|1|通过主键直接获取|
|唯一索引查字段|0ms|1|通过主键直接获取|
|普通索引查字段|9ms|633|索引参与查询|
|普通字段查其它字段|833ms|95270|全表扫描|
|普通字段查主键|500ms|95270|全表扫描，但比查询其它字段快，少了一次回表的过程|

#### 删除性能小结
|场景|耗时|
|---|----|
|主键删除|1ms|
|唯一索引删除|1ms|
|普通索引删除|18ms|
|普通字段删除|1312ms|

#### 修改性能小结
|场景|耗时|
|主键修改|1ms|
|唯一索引修改|1ms|
|普通索引修改|12ms|
|普通字段修改|1288ms|



### 3. 尝试对 MySQL 不同引擎下测试 100 万订单数据的增删改查性能。

#### INNODB

上一题已总结

#### MyISAM