-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: xm_shopping_manager
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人',
  `useraddress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货地址',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='地址信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '店铺名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商家介绍',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '审核状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商家信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `business_id` int(10) DEFAULT NULL COMMENT '店铺ID',
  `num` int(10) DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='购物车表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collect`
--

DROP TABLE IF EXISTS `collect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collect` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `business_id` int(10) DEFAULT NULL COMMENT '店铺ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='收藏信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `business_id` int(10) DEFAULT NULL COMMENT '店铺ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='评论信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品主图',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '商品介绍',
  `price` double(10,2) DEFAULT NULL COMMENT '商品价格',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '计件单位',
  `count` int(10) DEFAULT '0' COMMENT '商品销量',
  `type_id` int(10) DEFAULT NULL COMMENT '分类ID',
  `business_id` int(10) DEFAULT NULL COMMENT '商家ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商品信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `latest`
--

DROP TABLE IF EXISTS `latest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `latest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建人',
  `type` int(11) NOT NULL COMMENT '应用场景（0是商城公告，1以上是店铺id）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='公告信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `business_id` int(10) DEFAULT NULL COMMENT '商家ID',
  `num` int(10) DEFAULT NULL COMMENT '商品数量',
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `price` double(10,2) DEFAULT NULL COMMENT '订单价格',
  `address_id` int(10) DEFAULT NULL COMMENT '地址ID',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='订单信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类描述',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商品分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

-- ============================================================
-- 补充 dump：缺失表的数据（由 dump_missing_tables.py 生成）
-- ============================================================

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` (`id`, `user_id`, `username`, `useraddress`, `phone`) VALUES (1, 5, '张三丰', '上海市浦东新区888号', '18899997777'),(4, 5, '张无忌', '安徽省合肥市888号', '18877776666'),(5, 5, '张大嘴', '北京市海淀区888号', '18866665555'),(6, 9, '李大嘴', '上海市浦东新区222号', '18866661111'),(7, 10, 'weird', '南昌航空大学', '13117805802'),(8, 11, '1', '南昌航空大学', '13117805802'),(9, 12, '2', '南昌航空大学', '13117805802');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` (`id`, `name`, `img`, `description`, `price`, `unit`, `count`, `type_id`, `business_id`) VALUES (5, '设计感修身短款t恤女夏季新款圆领薄款短袖白色高腰紧身露脐上衣', 'http://localhost:9090/files/1699257986682-1.png', '<p><br/></p><p><img src="http://localhost:9090/files/1699261664936-d1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699261669398-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699261673992-d3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699261678840-d4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699261682978-d5.png" style="max-width:100%;" contenteditable="false"/></p>', 59.0, '件', 1, 16, 16),(6, 'MsShe大码女装新款叠穿松紧腰配饰假两件系扣衬衫下摆屁帘', 'http://localhost:9090/files/1699428705672-1.png', '<p><img src="http://localhost:9090/files/1699428736624-d1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699428739895-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699428742752-d3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699428745711-d4.png" style="max-width:100%;" contenteditable="false"/></p>', 159.0, '件', 0, 16, 16),(7, '加绒加厚MsShe大码女装2023新款秋装胖mm多巴胺V领宽松卫衣上衣冬', 'http://localhost:9090/files/1699445257509-1.png', '<p><img src="http://localhost:9090/files/1699445276508-d1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699445283145-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699445286061-d3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699445289121-d4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699445291821-d5.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699445294540-d6.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699445297097-d7.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699445299644-d8.png" style="max-width:100%;" contenteditable="false"/></p>', 129.0, '件', 0, 16, 16),(8, '美式复古短袖T恤女纯棉夏ins潮半袖2023年新款设计感小众v领体桖', 'http://localhost:9090/files/1699952256595-1.png', '<p><img src="http://localhost:9090/files/1699952270468-d1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699952292732-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699952296929-d3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699952300817-d4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699952304309-d5.png" style="max-width:100%;" contenteditable="false"/></p>', 59.0, '件', 0, 16, 16),(9, '【赠送延长扣】MsShe大码外穿无钢圈防震内衣聚拢一体式运动文胸', 'http://localhost:9090/files/1699952462164-1.png', '<p><img src="http://localhost:9090/files/1699952478199-d1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699952482285-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699952488092-d4.png" style="max-width:100%;" contenteditable="false"/></p>', 89.0, '件', 0, 16, 16),(10, 'MsShe大码女装新款冬季老钱风立领调节收腰菱格夹棉长款外套', 'http://localhost:9090/files/1699952515679-z1.png', '<p><img src="http://localhost:9090/files/1699952526794-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1699952530411-2.png" style="max-width:100%;" contenteditable="false"/></p>', 199.0, '件', 6, 16, 16),(11, '白桃果脯', 'http://localhost:9090/files/1711764434052-1.jpg', '<p><img src="http://localhost:9090/files/1711764491724-3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764510063-n3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764529299-n2.jpg" style="max-width:100%;" contenteditable="false"/></p>', 15.0, '一袋', 22, 9, 9),(12, '百草味菠萝干100g休闲零食酸甜菠萝圈凤梨干片蜜饯水果干果脯', 'http://localhost:9090/files/1711764696607-1.jpg', '<p><img src="http://localhost:9090/files/1711764712977-n1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764720130-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764736108-n2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764739666-n3.jpg" style="max-width:100%;" contenteditable="false"/></p>', 20.0, '一袋', 18, 9, 9),(13, '百草味东北松子100g坚果炒货手剥开口松籽干果零食特产', 'http://localhost:9090/files/1711764756656-1.jpg', '<p><img src="http://localhost:9090/files/1711764772378-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764777086-3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764796624-4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764859877-5.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764875334-6.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764880938-7.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '一袋', 1, 9, 9),(14, '百草味山核桃仁小酥210g 营养早餐糕点点心网红零食小吃小包装', 'http://localhost:9090/files/1711764906301-1.jpg', '<p><img src="http://localhost:9090/files/1711764924821-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764935710-n1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764940377-n1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711764945204-n2.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '一袋', 9, 9, 9),(15, '百草味甜辣味鸭脖170g 110g开袋即食卤味休闲零食网红鸭脖', 'http://localhost:9090/files/1711764970491-170gsku.jpg', '<p><img src="http://localhost:9090/files/1711764995290-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711765005352-n2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711765008827-n3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711765025601-n8.jpg" style="max-width:100%;" contenteditable="false"/></p>', 35.0, '一袋', 16, 9, 9),(16, '联想原装电脑主机', 'http://localhost:9090/files/1711765184532-1.jpg', '<p><img src="http://localhost:9090/files/1711765223434-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711765236424-3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1711765242065-5.jpg" style="max-width:100%;" contenteditable="false"/><br/></p>', 258.0, '台', 0, 11, 11),(17, '固态硬盘', 'http://localhost:9090/files/1711765316906-3.jpg', '<p><img src="http://localhost:9090/files/1711765346753-详情图片_08.jpg" style="max-width:100%;" contenteditable="false"/></p>', 50.0, '条', 0, 11, 11),(18, '联想二手电脑', 'http://localhost:9090/files/1713516721966-3.jpg', '<p><img src="http://localhost:9090/files/1711765450907-详情图片_01.jpg" style="max-width:100%;" contenteditable="false"/></p>', 1000.0, '台', 0, 12, 12),(19, 'Jeep夹克', 'http://localhost:9090/files/1712457675504-1.png', '<p><img src="http://localhost:9090/files/1712457708475-d1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712457713801-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712457718818-d4.png" style="max-width:100%;" contenteditable="false"/></p>', 200.0, '件', 0, 15, 15),(20, '纯棉长袖T恤', 'http://localhost:9090/files/1712457736119-1.png', '<p><img src="http://localhost:9090/files/1712457843693-d1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712457854385-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712457858026-d3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712457861039-d4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712457877158-d5.png" style="max-width:100%;" contenteditable="false"/></p>', 99.0, '件', 0, 15, 15),(21, '运动休闲裤', 'http://localhost:9090/files/1712457893739-d1.png', '<p><img src="http://localhost:9090/files/1712457938044-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712457958793-d3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712457967985-d5.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712457974972-d6.png" style="max-width:100%;" contenteditable="false"/></p>', 100.0, '件', 0, 15, 15),(22, '森马开衫外套', 'http://localhost:9090/files/1712457988705-1.png', '<p><img src="http://localhost:9090/files/1712458020373-d1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458024589-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458027747-d3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458030954-d4.png" style="max-width:100%;" contenteditable="false"/></p>', 150.0, '件', 12, 15, 15),(23, '真维斯男士夹克外套春秋季立领新款休闲百搭男装潮流宽松上衣', 'http://localhost:9090/files/1712458090739-1.png', '<p><img src="http://localhost:9090/files/1712458139167-d5.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458142585-d4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458146513-d3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458149812-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458153941-d1.png" style="max-width:100%;" contenteditable="false"/></p>', 200.0, '件', 0, 15, 15),(24, '真维斯秋冬装卫衣男新款纯色圆领百搭休闲潮牌加绒长袖上衣服男士', 'http://localhost:9090/files/1712458181255-1.png', '<p><img src="http://localhost:9090/files/1712458211043-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458216308-d3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458219584-d4.png" style="max-width:100%;" contenteditable="false"/></p>', 100.0, '件', 0, 15, 15),(25, '啄木鸟灯芯绒外套男秋冬季加绒加厚中老年羊羔绒棉衣休闲夹克男装', 'http://localhost:9090/files/1712458249875-1.png', '<p><img src="http://localhost:9090/files/1712458281630-d6.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458289933-d5.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458297974-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458301916-d1.png" style="max-width:100%;" contenteditable="false"/></p>', 300.0, '件', 0, 15, 15),(26, '秋季男鞋新款冬季潮流百搭防滑防臭工作皮鞋男士休闲黑色板鞋', 'http://localhost:9090/files/1712458397034-主图_5.jpg', '<p><img src="http://localhost:9090/files/1712458455854-01.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458459674-02.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458464918-03.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458468044-详情图片_04.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458471247-详情图片_05.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458474629-详情图片_06.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458497949-详情图片_12.jpg" style="max-width:100%;" contenteditable="false"/></p>', 100.0, '双', 0, 14, 14),(27, '特步苜白板鞋丨男鞋年秋季官网新款学生舒适百搭休闲鞋运动鞋', 'http://localhost:9090/files/1712458525814-主图_3.jpg', '<p><img src="http://localhost:9090/files/1712458595775-01.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458600497-02.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458603798-03.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458609007-04.jpg" style="max-width:100%;" contenteditable="false"/></p>', 200.0, '双', 0, 14, 14),(28, '中国乔丹运动鞋男夏季官方旗舰店轻便软底网面透气男鞋跑步鞋', 'http://localhost:9090/files/1712458642761-主图_5.jpg', '<p><img src="http://localhost:9090/files/1712458668258-01.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458671400-02.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458675919-03.jpg" style="max-width:100%;" contenteditable="false"/></p>', 250.0, '双', 0, 14, 14),(29, 'SIKENAI思科耐闪充数据线Type-C安卓苹果数据线5A闪充线2米', 'http://localhost:9090/files/1712458776160-2_20231120_090757.jpg', '<p><img src="http://localhost:9090/files/1712458792921-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458796322-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458801144-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458805406-d4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458809372-d5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 11, 11),(30, 'SK品牌2.1A快充 3C认证 充电器防爆适用苹果 安卓 华为 OPPO vivo', 'http://localhost:9090/files/1712458860674-2.jpg', '<p><img src="http://localhost:9090/files/1712458850297-1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458858199-3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458864927-4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458868121-5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 50.0, '件', 0, 11, 11),(31, '思科耐 XO-16横竖两用重力支架横竖两用 手机横屏也可固定使用', 'http://localhost:9090/files/1712458938059-6.jpg', '<p><img src="http://localhost:9090/files/1712458918936-1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458924396-3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458929368-4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458935314-5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 20.0, '件', 0, 11, 11),(32, '思科耐 精致重力联动自动夹紧兼容6.8屏以内所有手机车载手机支架', 'http://localhost:9090/files/1712458958045-2.jpg', '<p><img src="http://localhost:9090/files/1712458968430-1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458973643-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458977375-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458980969-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712458984317-d4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 11, 11),(33, '羽高 无线蓝牙游戏耳机真无线炫彩发光 TWS游戏电竞蓝牙耳机', 'http://localhost:9090/files/1712459040651-5.jpg', '<p><img src="http://localhost:9090/files/1712459061494-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459066063-3.jpg" style="max-width:100%;" contenteditable="false"/></p>', 80.0, '件', 0, 11, 11),(34, '羽高6A 金属防冻数据线限时特惠安卓苹果Type-C数据线', 'http://localhost:9090/files/1712459094447-1.jpg', '<p><img src="http://localhost:9090/files/1712459113647-1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459118247-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459121805-3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459131758-4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 40.0, '件', 4, 11, 11),(35, '羽高66W快充数据线适用于苹果华为安卓Type-C 1米快充数据线', 'http://localhost:9090/files/1712459158073-1.jpg', '<p><img src="http://localhost:9090/files/1712459172697-4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459176761-6.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459179678-7.jpg" style="max-width:100%;" contenteditable="false"/></p>', 35.0, '件', 0, 11, 11),(36, '羽高工厂立体声商务声控挂耳式蓝牙耳机重低音环绕音质运动耳机颜色随机', 'http://localhost:9090/files/1712459197662-6.jpg', '<p><img src="http://localhost:9090/files/1712459226765-1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459229973-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459233899-3.jpg" style="max-width:100%;" contenteditable="false"/></p>', 50.0, '件', 0, 11, 11),(37, 'M8039儿童滑板车3-15岁', 'http://localhost:9090/files/1712459444009-d8.jpg', '<p><img src="http://localhost:9090/files/1712459379196-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459382746-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459390646-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459406320-d4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459412977-d6.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459418940-d7.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459423482-d8.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459434333-d10.jpg" style="max-width:100%;" contenteditable="false"/></p>', 100.0, '件', 0, 10, 10),(38, '贝恩施趣味英语108词点读机', 'http://localhost:9090/files/1712459506360-8.png', '<p><img src="http://localhost:9090/files/1712459489432-d1.png" style="max-width:100%;" contenteditable="false"/></p>', 300.0, '件', 3, 10, 10),(39, '贝恩施早教拼音机', 'http://localhost:9090/files/1712459535662-4.jpg', '<p><img src="http://localhost:9090/files/1712459565054-5.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459568665-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459571230-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459574280-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459579003-d4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459584847-d5.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459588903-d6.jpg" style="max-width:100%;" contenteditable="false"/></p>', 300.0, '件', 0, 10, 10),(40, '贝恩施智能记忆训练机儿童注意力思维益智类玩具趣味桌游专注力', 'http://localhost:9090/files/1712459615156-5.jpg', '<p><img src="http://localhost:9090/files/1712459626455-d1.jpg" style="max-width:100%;" contenteditable="false"/></p>', 250.0, '件', 0, 10, 10),(41, '贝恩施智能逻辑思维机', 'http://localhost:9090/files/1712459646571-d1.jpg', '<p><img src="http://localhost:9090/files/1712459673778-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459676907-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459682029-d4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459688061-d5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 200.0, '件', 0, 10, 10),(42, '士兵突击软弹八音泡泡枪', 'http://localhost:9090/files/1712459848729-5.jpg', '<p><br/><img src="http://localhost:9090/files/1712459838312-d1.jpg" style="max-width:100%;" contenteditable="false"/></p>', 120.0, '件', 0, 10, 10),(43, '世纪宝贝豪华高脚餐椅', 'http://localhost:9090/files/1712459938037-5.jpg', '<p><img src="http://localhost:9090/files/1712459912366-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459915302-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459918457-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712459922190-d4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 190.0, '件', 0, 10, 10),(44, '2器6液兔力蚊香液无味婴儿孕妇宝宝驱蚊水灭蚊防蚊', 'http://localhost:9090/files/1712460151470-4.jpg', '<p><img src="http://localhost:9090/files/1712460163578-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460166746-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460173972-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460177574-d4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 10, 10),(45, '2提原木纯品3层110抽4包抽纸巾家用餐巾纸', 'http://localhost:9090/files/1712460203909-4.jpg', '<p><img src="http://localhost:9090/files/1712460217258-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460220278-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460223292-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460225893-d4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460228374-d5.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460236561-d6.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 3, 6, 7),(46, 'TIBORANG帝伯朗菲尼斯系列晶钻陶瓷多用煎锅', 'http://localhost:9090/files/1712460275440-5.jpg', '<p><img src="http://localhost:9090/files/1712460286738-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460289659-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460292434-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460295329-d4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460298558-d5.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460303492-d6.jpg" style="max-width:100%;" contenteditable="false"/></p>', 120.0, '件', 0, 6, 7),(47, '康佳KKTV蓝光离子不伤发1000W大功率吹风机', 'http://localhost:9090/files/1712460337888-3.jpg', '<p><img src="http://localhost:9090/files/1712460435954-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460439395-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460443560-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460447096-d4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460452225-d5.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460460544-d6.jpg" style="max-width:100%;" contenteditable="false"/></p>', 90.0, '件', 0, 6, 7),(48, '3支佳洁士草本水晶牙膏清新口气美白去黄去口臭防蛀清爽90g正品', 'http://localhost:9090/files/1712460493578-3.jpg', '<p><img src="http://localhost:9090/files/1712460508820-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460511721-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460514804-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460517679-d4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460520452-d5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 40.0, '件', 0, 6, 7),(49, '丁福厨房油烟清洁剂', 'http://localhost:9090/files/1712460555989-4.jpg', '<p><img src="http://localhost:9090/files/1712460569425-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460572265-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460575109-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460578837-d4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 35.0, '件', 30, 6, 7),(50, 'Monda蒙达空气炸锅家用多功能大容量液晶触屏版无油电炸锅', 'http://localhost:9090/files/1712460617660-3.jpg', '<p><img src="http://localhost:9090/files/1712460638126-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460641826-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460644418-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460647640-d4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 200.0, '件', 1, 6, 7),(51, '罗兰家纺100%全棉磨毛四件套加厚纯棉简约被套床单春秋冬季3件套4', 'http://localhost:9090/files/1712460698301-3.jpg', '<p><img src="http://localhost:9090/files/1712460803120-详情图片_01.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460806025-详情图片_02.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460811013-详情图片_03.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460815010-详情图片_04.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1712460818250-详情图片_05.jpg" style="max-width:100%;" contenteditable="false"/></p>', 220.0, '件', 3, 4, 4),(52, '西红柿', 'http://localhost:9090/files/1713513178282-5.png', '<p><img src="http://localhost:9090/files/1713513142364-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513146360-2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513150758-3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513155818-4.png" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 8, 8),(53, '四川春见耙耙柑特级粑粑柑10斤橘子甜当季整箱新鲜水果丑柑桔包邮', 'http://localhost:9090/files/1713513202329-主图.png', '<p><img src="http://localhost:9090/files/1713513248638-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513252503-2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513255267-3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513258595-4.png" style="max-width:100%;" contenteditable="false"/></p>', 50.0, '件', 0, 8, 8),(54, '东北旱黄瓜 新鲜小黄瓜汗汉黄瓜农家新鲜蔬菜水果特产美食脆皮5斤', 'http://localhost:9090/files/1713513287092-主图.png', '<p><img src="http://localhost:9090/files/1713513292015-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513294910-2.png" style="max-width:100%;" contenteditable="false"/></p>', 20.0, '件', 0, 8, 8),(55, '福建漳州甜杨桃5斤水果当季整箱洋桃鲜果新鲜红龙扬桃五角星阳桃', 'http://localhost:9090/files/1713513366765-主图.png', '<p><img src="http://localhost:9090/files/1713513379297-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513383538-2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513386883-3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513390731-4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513397721-5.png" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 8, 8),(56, '甘肃天水花牛苹果10斤新鲜水果当季整箱包邮孕妇平果红蛇粉面果丑', 'http://localhost:9090/files/1713513500084-主图.png', '<p><img src="http://localhost:9090/files/1713513516335-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513519864-2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513523150-3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513549955-4.png" style="max-width:100%;" contenteditable="false"/></p>', 80.0, '件', 0, 8, 8),(57, '新疆正宗库尔勒小香梨全母梨10斤特产新鲜孕妇水果当季整箱包邮', 'http://localhost:9090/files/1713513577157-主图.png', '<p><img src="http://localhost:9090/files/1713513602223-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513619039-2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513621692-3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513626877-4.png" style="max-width:100%;" contenteditable="false"/></p>', 40.0, '件', 0, 8, 8),(58, '云南蜜桔现摘新鲜橘子无籽薄皮柑橘当季孕妇水果10斤整箱酸甜包邮', 'http://localhost:9090/files/1713513655900-主图.png', '<p><img src="http://localhost:9090/files/1713513675721-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513679047-2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513682083-3.png" style="max-width:100%;" contenteditable="false"/></p>', 35.0, '件', 0, 8, 8),(59, '黄牛腿肉', 'http://localhost:9090/files/1713513804653-主图.png', '<p><img src="http://localhost:9090/files/1713513848728-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513851962-2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713513855755-3.png" style="max-width:100%;" contenteditable="false"/></p>', 35.0, '件', 0, 8, 8),(60, 'Dior迪奥香水花漾甜心小样持久淡香真我女士伴手礼盒', 'http://localhost:9090/files/1713515576269-1.jpg', '<p><img src="http://localhost:9090/files/1713515586791-d1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515589627-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515594452-d3.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 13, 13),(61, 'Estee Lauder雅诗兰黛鲜活亮采红石榴保湿洁面乳', 'http://localhost:9090/files/1713515666274-d1.jpg', '<p><img src="http://localhost:9090/files/1713515634721-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515638159-3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515653220-d7.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515657052-d8.jpg" style="max-width:100%;" contenteditable="false"/></p>', 50.0, '件', 0, 13, 13),(62, 'Jo Malone祖马龙香水五件套联名蓝风铃', 'http://localhost:9090/files/1713515688434-1.jpg', '<p><img src="http://localhost:9090/files/1713515702349-d2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515706603-d3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515710537-d4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515723118-d8.jpg" style="max-width:100%;" contenteditable="false"/></p>', 20.0, '件', 0, 13, 13),(63, 'LA MER海蓝之谜修护精萃液精粹水奇迹修复精华水小样', 'http://localhost:9090/files/1713515762074-1.jpg', '<p><img src="http://localhost:9090/files/1713515774394-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515778879-d1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515789601-d2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515793943-d3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515801577-d5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 13, 13),(64, '阿玛尼红黑管挚爱哑光雾面滋润唇膏口红', 'http://localhost:9090/files/1713515816332-1.jpg', '<p><img src="http://localhost:9090/files/1713515826087-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515830761-3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515841806-4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 80.0, '件', 61, 13, 13),(65, '兰蔻小白管防晒霜50ml轻透水漾防晒乳SPF50 PA++++', 'http://localhost:9090/files/1713515881711-1.jpg', '<p><img src="http://localhost:9090/files/1713515891542-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515894543-3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713515900208-4.png" style="max-width:100%;" contenteditable="false"/></p>', 40.0, '件', 0, 13, 13),(66, '2023款13代酷睿i3_i5 联想台式电脑天逸510S主机 家用办公台式机设计游戏学习小主机全套 官方旗舰正品原装', 'http://localhost:9090/files/1713516333800-1.jpg', '<p><img src="http://localhost:9090/files/1713516354909-3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516359176-4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516362593-5.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516372090-详情图片_16.jpg" style="max-width:100%;" contenteditable="false"/></p>', 3000.0, '台', 0, 12, 12),(67, 'Dell_戴尔灵越15.6英寸轻薄笔记本电脑英特尔学习游戏办公商务手提剪辑PS设计pr高性能本官方旗舰店', 'http://localhost:9090/files/1713516401712-1.jpg', '<p><img src="http://localhost:9090/files/1713516424134-详情图片_05.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516426839-详情图片_06.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516429801-详情图片_07.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516432954-详情图片_08.jpg" style="max-width:100%;" contenteditable="false"/></p>', 1000.0, '台', 0, 12, 12),(68, 'honor_荣耀笔记本电脑商务办公大学生i7吃鸡游戏本剪辑设计i5便携', 'http://localhost:9090/files/1713516452918-1.jpg', '<p><img src="http://localhost:9090/files/1713516513678-详情图片_05.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516521057-详情图片_06.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516524034-详情图片_07.jpg" style="max-width:100%;" contenteditable="false"/></p>', 2000.0, '台', 0, 12, 12),(69, 'i7高配独显一体机电脑台式全套整机主机八核商务办公家用游戏吃鸡', 'http://localhost:9090/files/1713516553634-2.jpg', '<p><img src="http://localhost:9090/files/1713516568635-5.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516571614-6.jpg" style="max-width:100%;" contenteditable="false"/></p>', 1000.0, '台', 0, 12, 12),(70, 'Xiaomi_小米笔记本电脑办公商务大学生网课超轻薄i7游戏本手提i5', 'http://localhost:9090/files/1713516593685-1.jpg', '<p><img src="http://localhost:9090/files/1713516606248-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516610918-3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516614113-4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516618831-5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 3600.0, '台', 88, 12, 12),(71, '雷柏M650无线鼠标三模蓝牙鼠标办公静音小巧台式笔记本电脑可爱女', 'http://localhost:9090/files/1713516662693-详情图片_01.jpg', '<p><img src="http://localhost:9090/files/1713516682737-详情图片_18.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516687342-详情图片_19.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713516692153-详情图片_20.jpg" style="max-width:100%;" contenteditable="false"/></p>', 3800.0, '台', 0, 12, 12),(72, '白色毛巾架免打孔浴室卫生间卫浴五金挂件套装浴巾架置物架五件套', 'http://localhost:9090/files/1713522026580-主图.png', '<p><img src="http://localhost:9090/files/1713522037650-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522042155-2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522045223-3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522048419-4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522051223-5.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522055206-6.png" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 6, 6),(73, '霖朗客厅主灯现代简约大气led吸顶灯新款中山灯具长方形超薄', 'http://localhost:9090/files/1713522069715-主图.png', '<p><img src="http://localhost:9090/files/1713522121418-主图.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522127786-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522138770-3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522142218-4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522147867-5.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522150893-6.png" style="max-width:100%;" contenteditable="false"/></p>', 299.0, '件', 0, 6, 6),(74, '新中式沙发组合客厅别墅大小', 'http://localhost:9090/files/1713522166935-主图.png', '<p><img src="http://localhost:9090/files/1713522186846-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522190323-2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522194844-3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522198400-4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522201867-5.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522210701-6.png" style="max-width:100%;" contenteditable="false"/></p>', 599.0, '件', 0, 6, 6),(75, '铜洗脸盆水龙头冷热水家用卫生间洗手池洗漱台面盆浴室柜单龙头 1件装', 'http://localhost:9090/files/1713522225908-主图.png', '<p><img src="http://localhost:9090/files/1713522238930-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522242072-2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522245579-3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522249315-4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522254218-5.png" style="max-width:100%;" contenteditable="false"/></p>', 399.0, '件', 0, 6, 6),(76, '新款主卧室灯led吸顶灯简约现代大气圆形阳台客厅房间灯具', 'http://localhost:9090/files/1713522267580-主图.png', '<p><img src="http://localhost:9090/files/1713522279282-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522282628-2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522287310-3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522291399-4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522294769-5.png" style="max-width:100%;" contenteditable="false"/></p>', 499.0, '件', 0, 6, 6),(77, '南方寝饰家纺旗舰店100%纯棉全棉四件套ins网红款1.8m床单被套春', 'http://localhost:9090/files/1713522399699-主图.png', '<p><img src="http://localhost:9090/files/1713522411799-1.png" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 40, 4, 4),(78, '南极人简约纯棉四件式全棉100家纺牀上用品牀单被套1.8米被罩宿舍', 'http://localhost:9090/files/1713522426132-主图.png', '<p><img src="http://localhost:9090/files/1713522448681-1.png" style="max-width:100%;" contenteditable="false"/></p>', 120.0, '件', 0, 4, 4),(79, '水星家纺官方旗舰店四件套全棉纯棉100被套床单简约被罩被子宿舍', 'http://localhost:9090/files/1713522464370-主图_3.jpg', '<p><img src="http://localhost:9090/files/1713522476991-1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522483085-2.jpg" style="max-width:100%;" contenteditable="false"/></p>', 90.0, '件', 0, 4, 4),(80, '长相知家纺加厚纯棉磨毛四件套100%全棉床单被套家用床上用品', 'http://localhost:9090/files/1713522497133-2.jpg', '<p><img src="http://localhost:9090/files/1713522529601-1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522533266-3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522536994-4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522540453-5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 40.0, '件', 0, 4, 4),(81, 'vc片 维生素c正品官方旗舰店维生素c片药用东北制药国药片otc医用', 'http://localhost:9090/files/1713522619231-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713522629028-主图_2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522633391-主图_3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522637131-主图_4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 120.0, '件', 0, 3, 3),(82, '恒帝 复方氨酚烷胺片12片 流行性感冒发热头痛四肢酸痛喷嚏鼻塞', 'http://localhost:9090/files/1713522650524-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713522668247-详情图片_5.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522671940-详情图片_3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522675916-详情图片_4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 90.0, '件', 0, 3, 3),(83, '养血安神片北京同仁堂失眠快速入睡药气血不足补气养血安眠睡眠XJ', 'http://localhost:9090/files/1713522691845-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713522701404-主图_2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522705439-主图_3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522710356-主图_4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522713886-主图_5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 40.0, '件', 0, 3, 3),(84, '一次性医用灭菌10cm棉签掏耳脱脂棉婴儿无菌消毒家用化妆医药棉棒', 'http://localhost:9090/files/1713522728484-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713522739692-主图_2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522743887-主图_4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522748225-主图_5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 35.0, '件', 0, 3, 3),(85, '医用双头棉签医疗消毒棉棒医药一次性婴儿化妆掏耳尖头圆头棉花棒', 'http://localhost:9090/files/1713522762000-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713522778020-主图_2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522783018-主图_3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522798988-主图_4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 200.0, '件', 0, 3, 3),(86, '浙江医药维生素e软胶囊100mg_30粒正品官方旗舰店维E', 'http://localhost:9090/files/1713522815519-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713522825833-主图_5.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522834203-主图_4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 3, 3),(87, '紫玲 老年咳喘片 0.31g_24片_盒', 'http://localhost:9090/files/1713522851456-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713522864520-主图_4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522868636-主图_2.jpg" style="max-width:100%;" contenteditable="false"/></p>', 50.0, '件', 0, 3, 3),(88, '不锈钢厨具锅铲炒菜铲子煎铲厨房粥汤勺饭漏勺套装家用炒菜勺锅勺', 'http://localhost:9090/files/1713522937389-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713522949475-1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713522973765-详情图片_01.jpg" style="max-width:100%;" contenteditable="false"/></p>', 50.0, '件', 0, 2, 2),(89, '厨房锅盖架不锈钢菜板案板置物架多功能收纳放砧板架刀插刀架用品', 'http://localhost:9090/files/1713522998947-主图_3.jpg', '<p><img src="http://localhost:9090/files/1713523005691-详情图片_1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523014676-主图_6.jpg" style="max-width:100%;" contenteditable="false"/></p>', 20.0, '件', 0, 2, 2),(90, '厨房沥水碗碟收纳架带盖装碗箱家用餐具碗柜子盘置物放碗筷收纳盒', 'http://localhost:9090/files/1713523035284-1.png', '<p><img src="http://localhost:9090/files/1713523049837-主图_4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523054017-主图_5.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523058716-主图_6.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 2, 2),(91, '多功能锅盖架厨房用品锅铲子勺子收纳架坐式切菜板置物架家用大全', 'http://localhost:9090/files/1713523083312-主图_5.jpg', '<p><img src="http://localhost:9090/files/1713523093820-详情图片_01.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523098952-详情图片_03.jpg" style="max-width:100%;" contenteditable="false"/></p>', 80.0, '件', 0, 2, 2),(92, '硅胶铲不粘锅专用锅铲耐高温硅胶铲套装家用炒菜铲子炒勺汤勺厨具', 'http://localhost:9090/files/1713523114012-主图_2.jpg', '<p><img src="http://localhost:9090/files/1713523122080-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523127282-主图_3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523132425-主图_6.jpg" style="max-width:100%;" contenteditable="false"/></p>', 40.0, '件', 36, 2, 2),(93, '黑钢家用菜刀菜板二合一全套厨房水果刀宿舍案板砧板辅食刀具套装', 'http://localhost:9090/files/1713523162174-主图_4.jpg', '<p><img src="http://localhost:9090/files/1713523170723-主图_2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523174822-主图_3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523180717-主图_5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 35.0, '件', 0, 2, 2),(94, '水槽塑料沥水收纳挂篮厨房小用品厨具置物架收纳架沥水架挂袋家用', 'http://localhost:9090/files/1713523205650-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713523216040-主图_4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523221593-主图_3.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 2, 2),(95, '爱的教育小英雄雨来童年书全套3册高尔基正版六年级课外书阅读书目原著小学生6年级阅读书籍名著上册【凤凰新华书店旗舰店】', 'http://localhost:9090/files/1713523264775-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713523275063-主图_2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523278425-主图_3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523283043-主图_4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 1, 1),(96, '迷宫书全6册智力大迷宫游戏书 儿童3-4-5-6-7-8岁 走迷宫书专注力逻辑思维训练书籍大冒险左右脑开发益智书大脑图形注意力图书绘本', 'http://localhost:9090/files/1713523297675-主图_5.jpg', '<p><img src="http://localhost:9090/files/1713523309521-主图_1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523316619-主图_2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523319911-主图_3.jpg" style="max-width:100%;" contenteditable="false"/></p>', 120.0, '件', 0, 1, 1),(97, '全套10册 1-3-2岁宝宝绘本经典必读故事书睡前故事儿童读物0两到三岁早教启蒙益智书籍 适合一岁半婴儿看的书幼儿图书小蝌蚪找妈妈', 'http://localhost:9090/files/1713523334375-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713523341972-主图_2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523346575-主图_4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 90.0, '件', 0, 1, 1),(98, '鼠疫 加缪著荒诞哲学诺贝尔文学奖得主作品世界名著外国小说 法国现当代文学课外阅读畅销书排行榜图书籍新华正版', 'http://localhost:9090/files/1713523360488-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713523368542-主图_2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523373235-主图_4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523376986-主图_5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 40.0, '件', 0, 1, 1),(99, '撕不烂早教翻翻卡片 0到1一3岁宝宝启蒙认知绘本2岁 一岁半两岁宝宝书籍婴儿水果蔬菜颜色动物看图识物玩具图书幼启蒙益智早教书', 'http://localhost:9090/files/1713523391462-1.png', '<p><img src="http://localhost:9090/files/1713523408159-1.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523412321-主图_1.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523415786-主图_2.jpg" style="max-width:100%;" contenteditable="false"/></p>', 35.0, '件', 0, 1, 1),(100, '文具的家注音版 人民教育出版社 小学生一年级课外书必读人教版下册老师推 荐阅读入选语文教材书目畅销儿童文学书籍带拼音', 'http://localhost:9090/files/1713523429438-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713523439773-主图_2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523442858-主图_3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523446793-主图_4.jpg" style="max-width:100%;" contenteditable="false"/></p>', 200.0, '件', 0, 1, 1),(101, '正版6册 凡尔纳科幻小说全集套装世界名著小学初中版课外书籍 海底两万里 八十天环游地球 神秘岛机器岛 格兰特船长的女儿地心游记', 'http://localhost:9090/files/1713523460240-主图_1.jpg', '<p><img src="http://localhost:9090/files/1713523468005-主图_2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523471465-主图_3.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523474829-主图_4.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713523480748-主图_5.jpg" style="max-width:100%;" contenteditable="false"/></p>', 30.0, '件', 0, 1, 1),(102, '小米SU7', 'http://localhost:9090/files/1713523907202-主图.png', '<p><br/><img src="http://localhost:9090/files/1713523927831-LK6UQT76T9GSAX_PUYUG(R4.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713524611977-3.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713524620766-2.png" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1713524544273-1.png" style="max-width:100%;" contenteditable="false"/></p>', 299900.0, '台', 100, 5, 5),(103, '原装羽高车载充电器2.0a 双口车充5A 破窗金属快速充电玉环', 'http://localhost:9090/files/1713524043835-65V3(67231F)(RE0~PF0S}2.png', '<p><img src="http://localhost:9090/files/1713524056433-65V3(67231F)(RE0~PF0S}2.png" style="max-width:100%;" contenteditable="false"/></p>', 200.0, '件', 0, 5, 5),(104, '香水', 'http://localhost:9090/files/1714031266517-1.jpg', '<p><img src="http://localhost:9090/files/1714031288829-2.jpg" style="max-width:100%;" contenteditable="false"/><img src="http://localhost:9090/files/1714031292713-3.jpg" style="max-width:100%;" contenteditable="false"/></p>', 123.0, '件', 2, 13, 18);
INSERT INTO `goods` (`id`, `name`, `img`, `description`, `price`, `unit`, `count`, `type_id`, `business_id`) VALUES (105, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 1),(106, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 9),(107, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 1),(108, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 1),(109, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 1),(110, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 1),(111, 'API测试商品-NgVZlt', NULL, '测试用商品描述', 148.56, '件', 342, 1, 9),(112, '边界商品-QeAa', NULL, NULL, 0.01, '件', 1, 1, 9),(113, '边界商品-upBl', NULL, NULL, 999999.99, '件', 999999, 1, 9),(114, '边界商品-JwcJ', NULL, NULL, 0.0, '件', 0, 1, 9),(115, '边界商品-WJuO', NULL, NULL, -1.0, '件', 1, 1, 9),(116, '边界商品-Op9e', NULL, NULL, 1.0, '件', -1, 1, 9),(117, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 1),(118, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 9),(119, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 1),(120, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 1),(121, 'API测试商品-eOiEfx', NULL, '测试用商品描述', 995.67, '件', 366, 1, 9),(122, '边界商品-ouPg', NULL, NULL, 0.01, '件', 1, 1, 9),(123, '边界商品-bDE9', NULL, NULL, 999999.99, '件', 999999, 1, 9),(124, '边界商品-xqtI', NULL, NULL, 0.0, '件', 0, 1, 9),(125, '边界商品-9qvE', NULL, NULL, -1.0, '件', 1, 1, 9),(126, '边界商品-rOzr', NULL, NULL, 1.0, '件', -1, 1, 9),(127, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 1),(128, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 9),(129, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 1),(130, '权限测试商品', NULL, NULL, 9.9, '件', 100, 1, 1),(131, 'API测试商品-a9bxkS', NULL, '测试用商品描述', 860.91, '件', 979, 1, 9),(132, '边界商品-TtAZ', NULL, NULL, 0.01, '件', 1, 1, 9),(133, '边界商品-JgOH', NULL, NULL, 999999.99, '件', 999999, 1, 9),(134, '边界商品-dDMZ', NULL, NULL, 0.0, '件', 0, 1, 9),(135, '边界商品-Wu01', NULL, NULL, -1.0, '件', 1, 1, 9),(136, '边界商品-gMT5', NULL, NULL, 1.0, '件', -1, 1, 9);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` (`id`, `user_id`, `goods_id`, `business_id`, `num`) VALUES (64, 11, 51, 4, 1),(68, 10, 72, 6, 1),(69, 11, 54, 8, 1),(70, 11, 56, 8, 1),(71, 11, 64, 13, 1),(72, 11, 23, 15, 1),(74, 10, 12, 9, 1),(78, 10, 64, 13, 1),(79, 1, 1, 1, 11),(176, 5, 11, 9, 99);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `collect`
--

LOCK TABLES `collect` WRITE;
/*!40000 ALTER TABLE `collect` DISABLE KEYS */;
-- collect: no rows
/*!40000 ALTER TABLE `collect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` (`id`, `user_id`, `goods_id`, `business_id`, `content`, `time`) VALUES (5, 10, 102, 5, '无论从前脸到尾部，又或者是侧面所展现出来的流线造型，都非常好看。这样的造型给人的感觉就是非常高端，属于高端品牌才会有的造型。还有就是那个可以升降的尾翼，非常好看。', '2024-05-04 23:02:37');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `latest`
--

LOCK TABLES `latest` WRITE;
/*!40000 ALTER TABLE `latest` DISABLE KEYS */;
-- latest: no rows
/*!40000 ALTER TABLE `latest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` (`id`, `title`, `content`, `time`, `user`, `type`) VALUES (1, '今天系统正式上线，开始内测', '今天系统正式上线，开始内测', '2024-05-03', 'admin', 0),(2, '所有功能都已完成，可以正常使用', '所有功能都已完成，可以正常使用', '2024-05-03', 'admin', 0),(3, 'XXXX女装年中大促销啦', '机不可失时不再来！！！', '2024-05-03', 'admin', 0),(4, '账号审核不通过', '****商户你好，您的店铺营业执照未上传，请及时上传，不然会影响审核进度！', '2024-05-03', 'admin', 18);
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`id`, `order_id`, `goods_id`, `business_id`, `num`, `user_id`, `price`, `address_id`, `status`) VALUES (30, '20240504152502', 64, 13, 1, 10, 80.0, 7, '待发货'),(31, '20240504152502', 50, 7, 1, 10, 200.0, 7, '待收货'),(32, '20240504225950', 102, 5, 1, 10, 299900.0, 7, '已评价'),(33, '20240504230345', 12, 9, 2, 10, 40.0, 7, '待收货'),(34, '20240504235616', 13, 9, 1, 11, 30.0, 8, '待发货'),(35, '20240504235616', 15, 9, 1, 11, 35.0, 8, '待发货'),(36, '20240504235616', 11, 9, 1, 11, 15.0, 8, '待发货'),(37, '20260818173424', 1, 1, 1, 5, 99.0, 1, '待发货'),(38, '20260818173425', 1, 1, 1, 5, 99.0, 1, '待发货'),(39, '20260818173425', 1, 1, 2, 5, 198.0, 1, '待发货'),(40, '20260818173425', 1, 1, 2, 5, 198.0, 1, '待发货'),(41, '20260818173425', 1, 1, 1, 5, 99.0, 1, '待发货'),(42, '20260818173425', 1, 1, 1, 5, 99.0, 1, '待发货'),(43, '20260818173425', 1, 1, 5, 5, 495.0, 1, '待发货'),(44, '20260818173426', 1, 1, 5, 5, 495.0, 1, '待发货'),(45, '20260818173426', 1, 1, 2, 5, 198.0, 1, '待发货'),(46, '20260818173426', 1, 1, 2, 5, 198.0, 1, '待发货'),(47, '20260818173426', 1, 1, 3, 5, 297.0, 1, '待发货'),(48, '20260818173426', 1, 1, 3, 5, 297.0, 1, '待发货'),(49, '20260818173426', 1, 1, 3, 5, 297.0, 1, '待发货'),(50, '20260818173426', 1, 1, 3, 5, 297.0, 1, '待发货'),(51, '20260818173426', 1, 1, 1, 5, 99.0, 1, '待发货'),(52, '20260818173427', 1, 1, 1, 5, 99.0, 1, '待发货'),(53, '20260818173757', 1, 1, 1, 5, 99.0, 1, '待发货'),(54, '20260818173758', 1, 1, 1, 5, 99.0, 1, '待发货'),(55, '20260818173758', 1, 1, 2, 5, 198.0, 1, '待发货'),(56, '20260818173758', 1, 1, 2, 5, 198.0, 1, '待发货'),(57, '20260818173758', 1, 1, 1, 5, 99.0, 1, '待发货'),(58, '20260818173758', 1, 1, 1, 5, 99.0, 1, '待发货'),(59, '20260818173758', 1, 1, 5, 5, 495.0, 1, '待发货'),(60, '20260818173758', 1, 1, 5, 5, 495.0, 1, '待发货'),(61, '20260818173758', 1, 1, 2, 5, 198.0, 1, '待发货'),(62, '20260818173758', 1, 1, 2, 5, 198.0, 1, '待发货'),(63, '20260818173759', 1, 1, 3, 5, 297.0, 1, '待发货'),(64, '20260818173759', 1, 1, 3, 5, 297.0, 1, '待发货'),(65, '20260818173759', 1, 1, 3, 5, 297.0, 1, '待发货'),(66, '20260818173759', 1, 1, 3, 5, 297.0, 1, '待发货'),(67, '20260818173759', 1, 1, 1, 5, 99.0, 1, '待发货'),(68, '20260818173759', 1, 1, 1, 5, 99.0, 1, '待发货'),(69, '20260818174022', 11, 9, 1, 5, 15.0, 1, '待发货'),(70, '20260818174022', 11, 9, 2, 5, 30.0, 1, '待发货'),(71, '20260818174022', 12, 9, 1, 5, 20.0, 1, '待发货'),(72, '20260818174023', 11, 9, 1, 5, 15.0, 1, '待发货'),(73, '20260818174023', 10, 16, 1, 5, 199.0, 1, '待发货'),(74, '20260818174023', 15, 9, 5, 5, 175.0, 1, '待发货'),(75, '20260818174023', 11, 9, 2, 5, 30.0, 1, '待发货'),(76, '20260818174023', 12, 9, 1, 5, 20.0, 1, '待发货'),(77, '20260818174023', 14, 9, 3, 5, 90.0, 1, '待发货'),(78, '20260818174023', 22, 15, 3, 5, 450.0, 1, '待发货'),(79, '20260818174023', 11, 9, 1, 5, 15.0, 1, '待发货'),(80, '20260818174023', 12, 9, 2, 5, 40.0, 1, '待发货'),(81, '20260818174023', 10, 16, 1, 5, 199.0, 1, '待发货'),(82, '20260818174116', 11, 9, 1, 5, 15.0, 1, '待发货'),(83, '20260818174116', 11, 9, 2, 5, 30.0, 1, '待发货'),(84, '20260818174116', 12, 9, 1, 5, 20.0, 1, '待发货'),(85, '20260818174116', 11, 9, 1, 5, 15.0, 1, '待发货'),(86, '20260818174116', 10, 16, 1, 5, 199.0, 1, '待发货'),(87, '20260818174116', 15, 9, 5, 5, 175.0, 1, '待发货'),(88, '20260818174117', 11, 9, 2, 5, 30.0, 1, '待发货'),(89, '20260818174117', 12, 9, 1, 5, 20.0, 1, '待发货'),(90, '20260818174117', 14, 9, 3, 5, 90.0, 1, '待发货'),(91, '20260818174117', 22, 15, 3, 5, 450.0, 1, '待发货'),(92, '20260818174117', 11, 9, 1, 5, 15.0, 1, '待发货'),(93, '20260818174117', 12, 9, 2, 5, 40.0, 1, '待发货'),(94, '20260818174117', 10, 16, 1, 5, 199.0, 1, '待发货'),(95, '20260819163339', 11, 9, 1, 5, 15.0, 1, '待发货'),(96, '20260819163340', 11, 9, 2, 5, 30.0, 1, '待发货'),(97, '20260819163340', 12, 9, 1, 5, 20.0, 1, '待发货'),(98, '20260819163340', 11, 9, 1, 5, 15.0, 1, '待发货'),(99, '20260819163340', 10, 16, 1, 5, 199.0, 1, '待发货'),(100, '20260819163340', 15, 9, 5, 5, 175.0, 1, '待发货'),(101, '20260819163340', 11, 9, 2, 5, 30.0, 1, '待发货'),(102, '20260819163340', 12, 9, 1, 5, 20.0, 1, '待发货'),(103, '20260819163340', 14, 9, 3, 5, 90.0, 1, '待发货'),(104, '20260819163340', 22, 15, 3, 5, 450.0, 1, '待发货'),(105, '20260819163341', 11, 9, 1, 5, 15.0, 1, '待发货'),(106, '20260819163341', 12, 9, 2, 5, 40.0, 1, '待发货'),(107, '20260819163341', 10, 16, 1, 5, 199.0, 1, '待发货');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-19 17:09:52

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: xm_shopping_manager
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','123456','管理员','http://localhost:9090/files/1697438073596-avatar.png','ADMIN','13677889922','admin@xm.com'),(2,'admintest001','123456','临时',NULL,'ADMIN',NULL,NULL);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `business`
--

LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
INSERT INTO `business` VALUES (1,'图书音像','123456','图书','http://localhost:9090/files/1712457480045-主图_5.jpg','BUSINESS','123456','123456@qq.com','图书','审核通过'),(2,'厨具收纳宠物','123456','厨具','http://localhost:9090/files/1712457450152-主图_6.jpg','BUSINESS','123456','123456@qq.com','厨具','审核通过'),(3,'医药保健品','123456','医药保健','http://localhost:9090/files/1712457411573-主图_5.jpg','BUSINESS','123456','123456@qq.com','医药保健','审核通过'),(4,'家纺家饰鲜花','123456','灿灿纺织','http://localhost:9090/files/1713522557421-2.jpg','BUSINESS','123456','123456@qq.com','灿灿纺织','审核通过'),(5,'汽车配件用品','123456','汽车配件用品','http://localhost:9090/files/1713524103762-65V3(67231F)(RE0~PF0S}2.png','BUSINESS','123456','123456@qq.com','汽车配件用品','审核通过'),(6,'家具灯具卫浴','123456','家具灯具卫浴','http://localhost:9090/files/1713522328093-3.png','BUSINESS','123456','123456@qq.com','家具灯具卫浴','审核通过'),(7,'生活电器用品','123456','生活用品','http://localhost:9090/files/1712457277653-2.jpg','BUSINESS','123456','123456@qq.com','生活用品','审核通过'),(8,'水果生鲜铺子','123456','水果生鲜铺子',NULL,'BUSINESS','123456','123456@qq.com','水果生鲜铺子','审核通过'),(9,'零食茶酒进口食品','123456','百草味零食','http://localhost:9090/files/1711765125542-零食.png','BUSINESS','123456','123456@qq.com','百草味，你的最爱！','审核通过'),(10,'母婴玩具','123456','母婴','http://localhost:9090/files/1712456389628-avatar.png','BUSINESS','123456','123456@qq.com','母婴','审核通过'),(11,'手机数码配件','123456','手机和手机配件','http://localhost:9090/files/1712456292789-1.jpg','BUSINESS','123456','123456@qq.com','欢迎购买我家的手机和手机配件，质量杠杠！','审核通过'),(12,'电脑电子办公配件','123456','启航电脑配件','http://localhost:9090/files/1699025860605-3.jpg','BUSINESS','18800007777','computer@xm.com','成立于2010年，鹿鹿集团旗下大型批发户。倡导「便捷 廉价」的生活方式，提升消费者的生活品质。截至2024年3月，已遍布全国31个省级行政区，220+个城市，近 2000家门店。','审核通过'),(13,'珠宝护肤饰品','123456','香水之家','http://localhost:9090/files/1699025808382-1.jpg','BUSINESS','18877776666','perfume@xm.com','成立于2010年，陌陌集团旗下大型香水批发户。倡导「便捷 廉价」的生活方式，提升消费者的生活品质。截至2023年7月，已遍布全国31个省级行政区，220+个城市，近 2000家门店。','审核通过'),(14,'女鞋男鞋箱包','123456','鞋包','http://localhost:9090/files/1712456164560-优雅.png','BUSINESS','123456','123456@qq.com','鞋包，欢迎您的光临','审核通过'),(15,'精品男装运动户外','123456','男装运动','http://localhost:9090/files/1712456173299-悠闲.png','BUSINESS','123456','123456@qq.com','男装，绅士之店','审核通过'),(16,'meshe','123456','ifashion','http://localhost:9090/files/1699023227734-avatar.png','BUSINESS','18899990000','meshe@xm.com','MsShe(慕姗.诗怡)--始创于2010年，定义“欧美简约、奢华风格 致力传播丰盈女性自信优雅之美 诠释现代丰盈女性独立自主，淡然优雅的淑女气 享受生活，拒绝平庸，于时尚与生活中挥洒自如，淡淡演绎完美生活','审核通过'),(18,'1','1','1','http://localhost:9090/files/1713063097987-头像.jpg','BUSINESS','123456','123456@qq.com','无','审核通过'),(152,'bustest001','123456','临时商家',NULL,'BUSINESS',NULL,NULL,NULL,'审核中');
/*!40000 ALTER TABLE `business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (5,'zhangsan','123456','张三','http://localhost:9090/files/1699252742825-柴犬.jpeg','USER','18811112222','zhangsan@xm.com'),(9,'lisi','123456','李四','http://localhost:9090/files/1699254328253-柯基.jpeg','USER','18866660000','lisi@xm.com'),(10,'weird','2002','weird','http://localhost:9090/files/1711506527948-头像.jpg','USER','13117805802','1780182873@qq.com'),(11,'1','1','1','http://localhost:9090/files/1712464606117-1698155465247-柴犬.jpeg','USER','123456','123456@qq.com'),(12,'2','2','2','http://localhost:9090/files/1712464788082-悠闲.png','USER','123456','123456@qq.com'),(13,'3','3','3',NULL,'USER',NULL,NULL),(14,'permtest_temp','123456','permtest_temp',NULL,'USER',NULL,NULL),(15,'usertest001','123456','临时用户',NULL,'USER',NULL,NULL),(16,'autotest_g6156apr','123456','自动测试用户',NULL,'USER',NULL,NULL),(17,'autotest_8vHXQ5K5','123456','自动测试用户',NULL,'USER',NULL,NULL),(18,'autotest_PCq3smJh','abcdef123','自动测试用户',NULL,'USER',NULL,NULL),(19,'autotest_o3pMJdej','abcdef123','自动测试用户',NULL,'USER',NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES (1,'图书音像','这是图书音像','http://localhost:9090/files/1699015316548-图书音像.png'),(2,'厨具 / 收纳','这是厨具 / 收纳 / 宠物','http://localhost:9090/files/1699015562438-居家.png'),(3,'医药 / 保健品','这是医药 / 保健品','http://localhost:9090/files/1699015585629-医药保健.png'),(4,'家纺 / 家饰','这是家纺 / 家饰 / 鲜花','http://localhost:9090/files/1699015602362-家纺家饰.png'),(5,'汽车 / 配件','这是汽车 / 配件 / 用品','http://localhost:9090/files/1699015621841-汽车配件.png'),(6,'家具 / 卫浴','这是家具 / 灯具 / 卫浴','http://localhost:9090/files/1699015637219-家具建材.png'),(7,'生活电器 / 生活用品','这是生活电器 / 生活用品','http://localhost:9090/files/1699015658084-家用电器.png'),(8,'水果 / 生鲜','这是水果 / 生鲜','http://localhost:9090/files/1699015679164-喵鲜生.png'),(9,'零食 / 茶酒','这是零食 / 茶酒 / 进口食品','http://localhost:9090/files/1699015694567-食品.png'),(10,'母婴 / 玩具','这是母婴 / 玩具','http://localhost:9090/files/1699015709389-母婴玩具.png'),(11,'手机 / 数码 ','这是手机 / 数码 / 配件','http://localhost:9090/files/1699015723293-数码手机.png'),(12,'电脑 / 配件','这是电脑 / 电子办公 / 配件','http://localhost:9090/files/1699015735715-电脑.png'),(13,'护肤品','这是珠宝 / 护肤 / 饰品','http://localhost:9090/files/1699015765623-珠宝饰品.png'),(14,'鞋包','这是女鞋 / 男鞋 / 箱包','http://localhost:9090/files/1699015794478-鞋_箱包.png'),(15,'男装','这是精品男装 / 运动户外','http://localhost:9090/files/1699015810103-男装.png'),(16,'女装','这是靓丽女装 / 内衣','http://localhost:9090/files/1699015824719-女装内衣.png');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-19 17:09:52
