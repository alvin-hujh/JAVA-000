CREATE TABLE `address_info`  (
  `id` bigint(0) NOT NULL COMMENT '主键',
  `bid` char(64) NOT NULL COMMENT '业务主键',
  `create_time` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否被删除：0-未删除，1-已删除',
  `customer_bid` char(64) NOT NULL COMMENT '用户 bid',
  `is_default` tinyint(1) ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否默认地址：0-不，1-默认',
  `province` varchar(8) NOT NULL COMMENT '省',
  `city` varchar(16) NOT NULL COMMENT '市',
  `county` varchar(16) NOT NULL COMMENT '区县',
  `address_detail` varchar(128) NOT NULL COMMENT '详细地址信息',
  `recipients_name` varchar(8) NULL COMMENT '收件人名字',
  `recipients_phone` varchar(16) NULL COMMENT '收件人电话',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_bid`(`bid`) COMMENT '业务主键',
  INDEX `udx_customer_bi`(`customer_bid`) COMMENT '用户 bid'
) COMMENT = '用户收货地址';

CREATE TABLE `customer_core`  (
  `id` bigint(0) NOT NULL COMMENT '自增主键',
  `bid` char(64) NOT NULL COMMENT '业务 id',
  `create_time` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否逻辑删除\n0-未删除\n1-已删除',
  `customer_name` varchar(64) NOT NULL COMMENT '用户名',
  `head_img_url` varchar(255) NULL COMMENT '头像地址',
  `gender` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别：0-其它，1-女 ，2-男',
  `birthday` date NULL COMMENT '生日',
  `mobile_phone` varchar(16) NULL COMMENT '电话',
  `customer_type` tinyint(1) NULL COMMENT '用户类型',
  `customer_identity_type` tinyint(1) NULL COMMENT '用户认证类型：0-身份证，1-军官证，2-护照，3-其它',
  `identity_no` varchar(32) NULL COMMENT '证件认证号码',
  `real_name` varchar(8) NULL COMMENT '真实姓名',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_bid`(`bid`) COMMENT '业务主键唯一索引'
) COMMENT = '用户核心信息';

CREATE TABLE `logistics_info`  (
  `id` bigint(0) NOT NULL COMMENT '主键',
  `bid` char(64) NOT NULL COMMENT '业务主键',
  `create_time` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否被删除：0-未删除，1-已删除',
  `order_bid` char(64) NOT NULL COMMENT '订单bid',
  `customer_bid` char(64) NOT NULL COMMENT '用户 bid',
  `product_bid` char(64) NOT NULL COMMENT '商品信息 bid',
  `address_bid` char(64) NULL COMMENT '地址 bid',
  `logistics_no` char(64) NULL COMMENT '订单编号',
  `logistics_company` varchar(16) NULL COMMENT '快递公司',
  `province` varchar(8) NOT NULL COMMENT '省',
  `city` varchar(16) NOT NULL COMMENT '市',
  `county` varchar(16) NOT NULL COMMENT '区县',
  `address_detail` varchar(64) NOT NULL COMMENT '详细地址信息',
  `recipients_name` varchar(8) NULL COMMENT '收件人名字',
  `recipients_phone` varchar(16) NULL COMMENT '收件人电话',
  `zip_code` integer(6) NULL COMMENT '邮编',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_bid`(`bid`) COMMENT '业务主键',
  INDEX `udx_customer_bid`(`customer_bid`) COMMENT '用户索引',
  INDEX `udx_product_bid`(`product_bid`) COMMENT '商品索引'
) COMMENT = '物流信息';

CREATE TABLE `order_info`  (
  `id` bigint(0) NOT NULL COMMENT '主键',
  `bid` char(64) NOT NULL COMMENT '业务主键',
  `create_time` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否被删除：0-未删除，1-已删除',
  `order_no` varchar(64) NOT NULL COMMENT '订单编号',
  `customer_bid` char(64) NOT NULL COMMENT '下单人bid',
  `address_bid` char(64) NULL COMMENT '收货地址bid',
  `preferential_bid` char(64) NULL COMMENT '优惠信息bid（存在组合优惠）',
  `product_unit_price` decimal(8, 2) NOT NULL COMMENT '下单时的商品单价',
  `product_num` tinyint(4) UNSIGNED NOT NULL DEFAULT 1 COMMENT '商品数量',
  `post_prize` decimal(8, 2) ZEROFILL NOT NULL COMMENT '邮费',
  `pay_price` decimal(8, 2) NOT NULL COMMENT '实际支付价格=单价*数量+邮费-优惠',
  `pay_method` tinyint(1) NULL COMMENT '支付方式：0-现金，1-网银，2-支付宝，3-微信',
  `pay_status` tinyint(1) NOT NULL COMMENT '支付状态：0-未支付，1-已支付',
  `order_status` tinyint(1) NOT NULL COMMENT '订单状态：0-付款，1-发货，2-运输，3-已完成',
  `post_need` tinyint(1) ZEROFILL NULL DEFAULT 0 COMMENT '是否需要邮寄：0-不需要，1-需要',
  `logistics_id` char(64) NULL COMMENT '物流信息 bid',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_bid`(`bid`) COMMENT '业务主键'
) COMMENT = '订单信息';

CREATE TABLE `product_img_url`  (
  `id` bigint(0) NOT NULL COMMENT '主键',
  `bid` char(64) NOT NULL COMMENT '业务主键',
  `create_time` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否被删除：0-未删除，1-已删除',
  `product_bid` char(64) NOT NULL COMMENT '商品 bid',
  `is_default` tinyint(1) ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否默认图片：0-不，1-默认',
  `index_no` tinyint(2) NOT NULL DEFAULT 0 COMMENT '图片顺序',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_bid`(`bid`) COMMENT '业务主键',
  INDEX `udx_product_id`(`product_bid`) COMMENT '商品 bid '
) COMMENT = '商品图片信息';

CREATE TABLE `product_info`  (
  `id` bigint(0) NOT NULL COMMENT '主键',
  `bid` char(64) NOT NULL COMMENT '业务主键',
  `create_time` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否被删除：0-未删除，1-已删除',
  `product_code` char(32) NOT NULL COMMENT '商品编码',
  `product_name` varchar(32) NOT NULL COMMENT '商品名称',
  `brand_bid` char(64) NULL COMMENT '品牌业务主键',
  `category_bid` char(64) NULL COMMENT '类型业务主键',
  `original_price` decimal(8, 2) NOT NULL COMMENT '商品价格',
  `preferential_price` decimal(8, 2) NULL COMMENT '优惠价格',
  `post_prize` decimal(8, 0) NULL COMMENT '邮费',
  `publish_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '发布状态：0-下架，1-上架',
  `product_type` tinyint(1) NULL COMMENT '商品种类：0-虚拟商品，1-实体商品',
  `effective_time` datetime(0) NULL COMMENT '有效时间',
  `inventory_num` int(0) ZEROFILL NULL DEFAULT 0 COMMENT '库存数量：为 0 时不可购买',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_bid`(`bid`) COMMENT '业务主键',
  INDEX `udx_brand_bid`(`brand_bid`) COMMENT '品牌索引',
  INDEX `udx_category_bid`(`category_bid`) COMMENT '类型索引'
) COMMENT = '商品基础信息表';

