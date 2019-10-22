#
# BlueWhale v0.0.1-SNAPSHOT
# Copyright (c) 2019-present, liuketing.

CREATE database if NOT EXISTS `bluewhale` default character set utf8 collate utf8_general_ci;
use `bluewhale`;

CREATE TABLE `staff_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emp_no` int(20) NOT NULL COMMENT '编号',
  `emp_name` varchar(20) NOT NULL COMMENT '姓名',
  `sex_code` varchar(1) DEFAULT NULL COMMENT '性别(0-男;1-女)',
  `birth_date` date DEFAULT NULL COMMENT '生日',
  `phone` varchar(30) DEFAULT NULL COMMENT '固定电话',
  `mobile` varchar(30) DEFAULT NULL COMMENT '移动电话',
  `home_address` varchar(300) DEFAULT NULL COMMENT '家庭地址',
  `postcode` varchar(30) DEFAULT NULL COMMENT '邮编',
  `hire_date` date DEFAULT NULL COMMENT '入司时间',
  `reg_date` date DEFAULT NULL COMMENT '转正时间',
  `leave_date` date DEFAULT NULL COMMENT '离职时间',
  `postition` varchar(50) DEFAULT NULL COMMENT '职务',
  `is_valid` varchar(1) DEFAULT 'Y' COMMENT '是否有效(Y-有效;N-失效)',
  `created_user` varchar(100) NOT	NULL DEFAULT 'system' COMMENT '创建人',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_user` varchar(100) NOT NULL DEFAULT 'system' COMMENT '更新人',
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='职工信息表';

DROP TRIGGER if EXISTS tr_bi_staff_info;
CREATE TRIGGER `tr_bi_staff_info` BEFORE INSERT ON `staff_info` FOR EACH ROW
BEGIN
 if (new.hire_date is null) then
    SET new.hire_date = now();
 end if;
 if (new.created_user is null OR new.created_user='') then
    SET new.created_user = 'system';
 end if;
 SET new.created_date = now();
 if (new.updated_user is null OR new.updated_user='') then
    SET new.updated_user = 'system';
 end if;
 SET new.updated_date = now();
END;

DROP TRIGGER IF EXISTS tr_bu_staff_info;
CREATE TRIGGER `tr_bu_staff_info` BEFORE UPDATE ON `staff_info` FOR EACH ROW
BEGIN
	IF (new.updated_user IS NULL OR new.updated_user='') THEN
		SET new.updated_user='system';
	END IF;
	SET new.updated_date= now();
END;

CREATE TABLE `daily_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emp_no` int(20) NOT NULL COMMENT '员工编号',
  `emp_name` varchar(20) NOT NULL COMMENT '员工姓名',
  `daily_num` int(2) NOT NULL COMMENT '日报编号',
  `daily_date` date NOT NULL COMMENT '日期',
  `task_source` varchar(30) DEFAULT NULL COMMENT '任务来源',
  `task_name` varchar(20) DEFAULT NULL COMMENT '任务名称',
  `task_description` varchar(512) DEFAULT NULL COMMENT '任务描述',
  `task_status` varchar(2) DEFAULT NULL COMMENT '任务状态(1-正常进行;2-延迟;3-完成)',
  `task_hour` int(11) NOT NULL DEFAULT '0' COMMENT '工时(人/天)',
  `task_no` varchar(20) DEFAULT NULL COMMENT '对应需求或BUG号',
  `is_valid` varchar(1) DEFAULT 'Y' COMMENT '是否有效(Y-有效;N-失效)',
  `created_user` varchar(100) NOT	NULL DEFAULT 'system' COMMENT '创建人',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_user` varchar(100) NOT NULL DEFAULT 'system' COMMENT '更新人',
  `updated_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `i_daily_date` (`daily_date`),
  KEY `i_emp_name` (`emp_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日报信息表';

DROP TRIGGER if EXISTS tr_bi_daily_info;
CREATE TRIGGER `tr_bi_daily_info` BEFORE INSERT ON `daily_info` FOR EACH ROW
BEGIN
 if (new.created_user is null OR new.created_user='') then
    SET new.created_user = 'system';
 end if;
 SET new.created_date = now();
 if (new.updated_user is null OR new.updated_user='') then
    SET new.updated_user = 'system';
 end if;
 SET new.updated_date = now();
END;

DROP TRIGGER IF EXISTS tr_bu_daily_info;
CREATE TRIGGER `tr_bu_daily_info` BEFORE UPDATE ON `daily_info` FOR EACH ROW
BEGIN
	IF (new.updated_user IS NULL OR new.updated_user='') THEN
		SET new.updated_user='system';
	END IF;
	SET new.updated_date= now();
END;


INSERT INTO `bluewhale`.`staff_info`(`id`, `emp_no`, `emp_name`, `sex_code`, `birth_date`, `phone`, `mobile`, `home_address`, `postcode`, `hire_date`, `reg_date`, `leave_date`, `postition`, `is_valid`, `created_user`, `created_date`, `updated_user`, `updated_date`) VALUES (1, 1, '刘柯廷', '0', '2019-10-07', NULL, '17611226015', '和泓四季', '123123', '2019-10-07', NULL, NULL, NULL, 'N', 'system', '2019-10-07 17:13:34', 'liuketing', '2019-10-07 17:39:43');
INSERT INTO `bluewhale`.`daily_info`(`id`, `emp_no`, `emp_name`, `daily_num`, `daily_date`, `task_source`, `task_name`, `task_description`, `task_status`, `task_hour`, `task_no`, `is_valid`, `created_user`, `created_date`, `updated_user`, `updated_date`) VALUES (1, 1, '刘柯廷', 1, '2019-10-07', '项目计划', '8-其它', '检查约定年金领取年龄变更上线版本（应用和DB）', '3', 3, 'XQ-4787', 'Y', 'liuketing', '2019-10-07 18:16:14', 'liuketing', '2019-10-07 18:19:14');

commit;
