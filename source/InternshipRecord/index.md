# June

## 6.1 入职

- [x] Java基础学习
- [x] spring 学习
- [x] 填写入职表
- [x] 安装钉钉, 微信

## 6.2 无事

- [x] spring学习完成
- [x] 复习sql
- [x] 开始myBatis
- [x] 数学建模题目阅读

## 6.3 无事

- [x] mybatis demo编写完成
- [x] Java刷题
- [x] Redis学习
- [x] 下载Redis
- [x] Redis跳表

## 6.4 阅读AI-check源码

- [x] 阅读源码
- [ ] 跑神经网络
- [x] Redis整数集合
- [x] 高性能MySQL
- [x] Java算法两题
- [x] React

| Common   |      |
| -------- | ---- |
| constant |      |
| enums    |      |
| response |      |
| shiro    |      |
| utils    |      |

`@Component`就是跟`<bean>`一样，可以托管到Spring容器进行管理
`@Controller`注解类进行前端请求的处理，转发，重定向。包括调用Service层的方法
`@Service`注解类处理业务逻辑
`@Repository`注解类作为DAO对象（数据访问对象，Data Access Objects），这些类可以直接对数据库进行操作

| Component             |                     |
| --------------------- | ------------------- |
| ScheduledTasks        | 定时任务            |
| SerialNumberComponent | 序列号生成          |
| ServiceLogAspect      | AOP sercie 日志     |
| SystemLogAspect       | AOP controller 日志 |



| table                  | description                  |
| ---------------------- | ---------------------------- |
| analy_log              | 随录数据解析日志             |
| auth_org               | 组织表(运营部, 营销部)       |
| auth_power             | 权限表                       |
| auth_role              | 角色表(管理员, 质检员, 座席) |
| auth_role_org          | 角色与组织关系表             |
| auth_role_power        | 角色与权限关联表             |
| auth_user              | 用户表(小蓝, 小红)           |
| auth_user_org          | 用户与组织关系表             |
| auth_user_role         | 用户与角色关系表             |
| deduct_count           |                              |
| extract_sound_log      | 抽音记录表                   |
| extract_sound_rule     | 抽音规则表                   |
| pdman_db_version       |                              |
| qc_analysis            |                              |
| qc_approval_history    | 流程管理 - 审批历史          |
| qc_machine_score_error | 机器打分错误日志表           |
| qc_process             | 流程管理 - 审批流维护        |
| qc_process_flow        | 流程管理 - 作业项            |
| qc_retask              | 复检                         |
| qc_retask_allot        | 复检任务分配表               |
| qc_retask_assign       | 复检任务指派表               |
| qc_retask_log          | 复检任务日志                 |
| qc_review              | 复议记录表                   |
| qc_score_edit_history  | 质检打分修改历史表           |
| qc_score_history       | 质检打分历史表               |
| qc_template            | 质检模板表                   |
| qc_template_item       | 质检模板 - 质检项            |
|                        |                              |
| sys_log                | 系统日志                     |
| xiron_log              |                              |

问题:

1. 为什么没有外键 - 懒了
2. 字段应该大写吗 - 应该
3. 为什么会出现unicode问题
4. deduct_count
5. 字典表
6. 字段重复

## 6.5 阅读AI-check源码

- [x] 编写jedis与session demo
- [x] 阅读源码
- [x] Java刷题
- [ ] reac
- [ ] Redis学习
- [ ] 高性能mysql

问题：

1. controller写什么
   1. /init
2. git工作流
3. postman 使用
4. 有没有和业务无关的简单任务