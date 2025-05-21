/*
 Navicat Premium Data Transfer

 Source Server         : docker_mysql
 Source Server Type    : MySQL
 Source Server Version : 90200
 Source Host           : localhost:3307
 Source Schema         : mcp

 Target Server Type    : MySQL
 Target Server Version : 90200
 File Encoding         : 65001

 Date: 21/05/2025 17:19:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for classes
-- ----------------------------
DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '班级ID，示例：202301',
  `className` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '班级名称，示例：2023级计算机1班',
  `grade` int NOT NULL COMMENT '年级，示例：2023',
  `headTeacherId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '班主任ID，外键(teachers.id)，示例：T003',
  `classroom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '教室位置，示例：1号楼302',
  `studentCount` int NOT NULL COMMENT '学生人数，示例：35',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注信息，示例：市级优秀班集体',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `headTeacherId`(`headTeacherId`) USING BTREE,
  CONSTRAINT `headTeacherId` FOREIGN KEY (`headTeacherId`) REFERENCES `teachers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '班级表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classes
-- ----------------------------
INSERT INTO `classes` VALUES ('202201', '2022级计算机1班', 2022, 'T005', '1号楼402', 36, '市级优秀班集体');
INSERT INTO `classes` VALUES ('202202', '2022级数学1班', 2022, 'T001', '1号楼403', 33, NULL);
INSERT INTO `classes` VALUES ('202203', '2022级英语1班', 2022, 'T002', '1号楼404', 32, '校级优秀班集体');
INSERT INTO `classes` VALUES ('202204', '2022级物理1班', 2022, 'T003', '1号楼405', 30, NULL);
INSERT INTO `classes` VALUES ('202205', '2022级化学1班', 2022, 'T004', '1号楼406', 35, '市级先进班集体');
INSERT INTO `classes` VALUES ('202301', '2023级计算机1班', 2023, 'T005', '1号楼302', 35, '市级优秀班集体');
INSERT INTO `classes` VALUES ('202302', '2023级数学1班', 2023, 'T001', '1号楼303', 32, '校级优秀班集体');
INSERT INTO `classes` VALUES ('202303', '2023级英语1班', 2023, 'T002', '1号楼304', 30, NULL);
INSERT INTO `classes` VALUES ('202304', '2023级物理1班', 2023, 'T003', '1号楼305', 34, '校级先进班集体');
INSERT INTO `classes` VALUES ('202305', '2023级化学1班', 2023, 'T004', '1号楼306', 31, NULL);

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程ID，示例：C001',
  `courseName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程名称，示例：高等数学',
  `credit` int NOT NULL COMMENT '学分，示例：4',
  `teacherId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '授课教师ID，外键(teachers.id)，示例：T001',
  `semester` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学期，格式\"YYYY-N\"，示例：2023-1',
  `type` enum('必修','选修') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '选修' COMMENT '课程类型，\"必修\"或\"选修\"，示例：选修',
  `prerequisite` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '先修课程ID，可选，外键(courses.id)，示例：C003',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teacherId`(`teacherId`) USING BTREE,
  CONSTRAINT `teacherId` FOREIGN KEY (`teacherId`) REFERENCES `teachers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '课程表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of courses
-- ----------------------------
INSERT INTO `courses` VALUES ('C001', '高等数学', 4, 'T001', '2023-1', '必修', NULL);
INSERT INTO `courses` VALUES ('C002', '大学英语', 3, 'T002', '2023-1', '必修', NULL);
INSERT INTO `courses` VALUES ('C003', '大学物理', 4, 'T003', '2023-1', '必修', NULL);
INSERT INTO `courses` VALUES ('C004', '大学化学', 3, 'T004', '2023-1', '必修', NULL);
INSERT INTO `courses` VALUES ('C005', '计算机基础', 3, 'T005', '2023-1', '必修', NULL);
INSERT INTO `courses` VALUES ('C006', '数据结构', 4, 'T005', '2023-2', '选修', 'C005');
INSERT INTO `courses` VALUES ('C007', '线性代数', 3, 'T001', '2023-2', '选修', 'C001');
INSERT INTO `courses` VALUES ('C008', '概率论与数理统计', 4, 'T001', '2023-2', '选修', 'C001');
INSERT INTO `courses` VALUES ('C009', '英语口语', 2, 'T002', '2023-2', '选修', 'C002');
INSERT INTO `courses` VALUES ('C010', '物理实验', 2, 'T003', '2023-2', '选修', 'C003');

-- ----------------------------
-- Table structure for scores
-- ----------------------------
DROP TABLE IF EXISTS `scores`;
CREATE TABLE `scores`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '成绩记录ID，示例：S20230101C001',
  `studentId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学生ID，外键(students.id)，示例：S20230101',
  `courseId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程ID，外键(courses.id)，示例：C001',
  `score` int NOT NULL COMMENT '综合成绩，0-100，示例：85',
  `examDate` date NOT NULL COMMENT '考试日期，示例：2024-5-20',
  `usualScore` int NULL DEFAULT 0 COMMENT '平时成绩，0-100，示例：90',
  `finalScore` int NULL DEFAULT 0 COMMENT '期末成绩，0-100，示例：80',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `studentId`(`studentId`) USING BTREE,
  INDEX `courseId`(`courseId`) USING BTREE,
  CONSTRAINT `courseId` FOREIGN KEY (`courseId`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `studentId` FOREIGN KEY (`studentId`) REFERENCES `students` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '成绩表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of scores
-- ----------------------------
INSERT INTO `scores` VALUES ('S20230101C001', 'S20230101', 'C001', 85, '2024-05-20', 90, 80);
INSERT INTO `scores` VALUES ('S20230101C002', 'S20230101', 'C002', 90, '2024-05-20', 85, 95);
INSERT INTO `scores` VALUES ('S20230101C005', 'S20230101', 'C005', 95, '2024-05-20', 92, 98);
INSERT INTO `scores` VALUES ('S20230201C001', 'S20230201', 'C001', 88, '2024-05-20', 87, 90);
INSERT INTO `scores` VALUES ('S20230201C003', 'S20230201', 'C003', 82, '2024-05-20', 80, 85);
INSERT INTO `scores` VALUES ('S20230301C002', 'S20230301', 'C002', 87, '2024-05-20', 85, 90);
INSERT INTO `scores` VALUES ('S20230301C004', 'S20230301', 'C004', 80, '2024-05-20', 78, 82);
INSERT INTO `scores` VALUES ('S20230401C003', 'S20230401', 'C003', 86, '2024-05-20', 84, 88);
INSERT INTO `scores` VALUES ('S20230401C005', 'S20230401', 'C005', 92, '2024-05-20', 90, 94);
INSERT INTO `scores` VALUES ('S20230501C004', 'S20230501', 'C004', 84, '2024-05-20', 82, 86);

-- ----------------------------
-- Table structure for students
-- ----------------------------
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学号，示例：S20230101',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学生姓名，示例：王强',
  `gender` enum('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '男' COMMENT '性别，\"男\"或\"女\"，示例：男',
  `birthDate` datetime NOT NULL COMMENT '出生日期，示例：2005-01-15',
  `classId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '班级ID，外键(classes.id)，示例：202301',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系电话，示例：13812345678',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '电子邮箱，示例：20230101@school.edu.cn',
  `emergencyContact` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '紧急联系人电话，示例：13876543210',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '家庭住址，示例：北京市海淀区中关村大街1栋101室',
  `height` int NOT NULL COMMENT '身高(cm)，示例：175',
  `weight` int NOT NULL COMMENT '体重(kg)，示例：65',
  `healthStatus` enum('良好‌','一般‌','较差') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '良好‌' COMMENT '健康状况，示例：良好',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `classId`(`classId`) USING BTREE,
  CONSTRAINT `classId` FOREIGN KEY (`classId`) REFERENCES `classes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '学生表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of students
-- ----------------------------
INSERT INTO `students` VALUES ('S20230101', '王强', '男', '2005-01-15 00:00:00', '202301', '13812345678', '20230101@school.edu.cn', '13876543210', '北京市海淀区中关村大街1栋101室', 175, 65, '良好‌');
INSERT INTO `students` VALUES ('S20230102', '李华', '女', '2005-02-20 00:00:00', '202301', '13812345679', '20230102@school.edu.cn', '13876543211', '上海市浦东新区张江高科技园区2栋201室', 165, 55, '良好‌');
INSERT INTO `students` VALUES ('S20230201', '张明', '男', '2005-03-10 00:00:00', '202302', '13812345680', '20230201@school.edu.cn', '13876543212', '广州市天河区珠江新城3栋301室', 180, 70, '良好‌');
INSERT INTO `students` VALUES ('S20230202', '刘芳', '女', '2005-04-05 00:00:00', '202302', '13812345681', '20230202@school.edu.cn', '13876543213', '深圳市南山区科技园4栋401室', 168, 58, '良好‌');
INSERT INTO `students` VALUES ('S20230301', '陈伟', '男', '2005-05-15 00:00:00', '202303', '13812345682', '20230301@school.edu.cn', '13876543214', '南京市玄武区珠江路5栋501室', 178, 68, '良好‌');
INSERT INTO `students` VALUES ('S20230302', '赵丽', '女', '2005-06-20 00:00:00', '202303', '13812345683', '20230302@school.edu.cn', '13876543215', '杭州市西湖区文三路6栋601室', 162, 52, '良好‌');
INSERT INTO `students` VALUES ('S20230401', '黄强', '男', '2005-07-10 00:00:00', '202304', '13812345684', '20230401@school.edu.cn', '13876543216', '成都市高新区天府软件园7栋701室', 176, 66, '良好‌');
INSERT INTO `students` VALUES ('S20230402', '周静', '女', '2005-08-05 00:00:00', '202304', '13812345685', '20230402@school.edu.cn', '13876543217', '武汉市洪山区光谷广场8栋801室', 167, 57, '良好‌');
INSERT INTO `students` VALUES ('S20230501', '吴伟', '男', '2005-09-15 00:00:00', '202305', '13812345686', '20230501@school.edu.cn', '13876543218', '西安市雁塔区科技路9栋901室', 177, 67, '良好‌');
INSERT INTO `students` VALUES ('S20230502', '郑芳', '女', '2005-10-20 00:00:00', '202305', '13812345687', '20230502@school.edu.cn', '13876543219', '长沙市岳麓区麓谷大道10栋1001室', 163, 53, '良好‌');

-- ----------------------------
-- Table structure for teachers
-- ----------------------------
DROP TABLE IF EXISTS `teachers`;
CREATE TABLE `teachers`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '教师ID，示例：T001',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '教师姓名，示例：张建国',
  `gender` enum('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '男' COMMENT '性别，\"男\"或\"女\"，示例：男',
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '教授科目，示例：数学',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '职称，示例：教授',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系电话，示例：13812345678',
  `office` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '办公室位置，示例：博学楼301',
  `wechat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信，示例：lily_teacher',
  `isHeadTeacher` enum('true','false') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'false' COMMENT '是否为班主任，示例：true',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `office_unique`(`office`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '教师表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teachers
-- ----------------------------
INSERT INTO `teachers` VALUES ('T001', '张建国', '男', '数学', '教授', '13812345678', '博学楼301', 'lily_teacher', 'true');
INSERT INTO `teachers` VALUES ('T002', '李明', '男', '英语', '副教授', '13812345679', '博学楼302', 'tom_teacher', 'false');
INSERT INTO `teachers` VALUES ('T003', '王芳', '女', '物理', '讲师', '13812345680', '博学楼303', 'lucy_teacher', 'true');
INSERT INTO `teachers` VALUES ('T004', '赵强', '男', '化学', '副教授', '13812345681', '博学楼304', 'jack_teacher', 'false');
INSERT INTO `teachers` VALUES ('T005', '陈静', '女', '计算机', '教授', '13812345682', '博学楼305', 'rose_teacher', 'true');
INSERT INTO `teachers` VALUES ('T006', '刘伟', '男', '语文', '讲师', '13812345683', '博学楼306', 'mike_teacher', 'false');
INSERT INTO `teachers` VALUES ('T007', '黄丽', '女', '历史', '副教授', '13812345684', '博学楼307', 'jane_teacher', 'true');
INSERT INTO `teachers` VALUES ('T008', '周明', '男', '地理', '讲师', '13812345685', '博学楼308', 'ben_teacher', 'false');
INSERT INTO `teachers` VALUES ('T009', '吴芳', '女', '生物', '教授', '13812345686', '博学楼309', 'susan_teacher', 'true');
INSERT INTO `teachers` VALUES ('T010', '郑强', '男', '政治', '副教授', '13812345687', '博学楼310', 'david_teacher', 'false');

SET FOREIGN_KEY_CHECKS = 1;
