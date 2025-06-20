-- 将“张明”老师负责的“数字电子技术”课程的学时数调整为36，同时增加一个学分
UPDATE C444
SET PERIOD=36, CREDIT=CREDIT+1
WHERE TEACHER='张明' AND CNAME='数字电子技术';
