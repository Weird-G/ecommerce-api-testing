mysqldump : mysqldump: [Warning] Using a password on the command line interface can be insecure.
At line:15 char:3524
+ ... pgrep\bin'; mysqldump -u root -proot --no-data xm_shopping_manager >  ...
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (mysqldump: [War...an be insecure.:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-19 17:09:52
mysqldump : mysqldump: [Warning] Using a password on the command line interface can be insecure.
At line:15 char:3648
+ ... exported" ; mysqldump -u root -proot --no-create-info --skip-triggers ...
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (mysqldump: [War...an be insecure.:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
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
