-- 居住在“东18舍”的男生视图，包括学号、姓名、出生日期、身高等属性
CREATE VIEW view1 AS
SELECT S#, SNAME, BDATE, HEIGHT
FROM S444
WHERE SEX='男' AND DORM LIKE '东 18 舍%';

-- “张明”老师所开设课程情况的视图，包括课程编号、课程名称、平均成绩等属性
CREATE VIEW view2 AS
SELECT C444.C#, CNAME, AVG(GRADE) AS avg_grade
FROM C444, SC444
WHERE C444.C#=SC444.C# AND TEACHER='张明'
GROUP BY C444.C#;

-- 所有选修了“人工智能”课程的学生视图，包括学号、姓名、成绩等属性
CREATE VIEW view3 AS
SELECT S444.S#, SNAME, GRADE
FROM S444, C444, SC444
WHERE S444.S#=SC444.S# AND C444.C#=SC444.C# AND CNAME='人工智能';
