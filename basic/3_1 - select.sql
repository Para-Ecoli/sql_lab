-- 查询电子工程系（EE）所开课程的课程编号、课程名称及学分数
SELECT C#, CNAME, CREDIT
FROM C444
WHERE C# LIKE 'EE%';

-- 查询未选修课程“CS-02”的女生学号及其已选各课程编号、成绩
SELECT S444.S#, C#, GRADE
FROM S444 LEFT JOIN SC444
ON S444.S#=SC444.S#
WHERE SEX='女' AND S444.S# NOT IN (
    SELECT S#
    FROM SC444
    WHERE C#='CS-02'
);

-- 查询 2004 年～2005 年出生学生的基本信息
SELECT *
FROM S444
WHERE EXTRACT(YEAR FROM BDATE) BETWEEN 2004 AND 2005;

-- 查询每位学生的学号、学生姓名及其已选修课程的学分总数
SELECT S444.S#, SNAME, SUM(CREDIT) AS TOTAL_CREDIT
FROM S444
LEFT JOIN SC444 ON S444.S#=SC444.S#
LEFT JOIN C444 ON C444.C#=SC444.C#
GROUP BY S444.S#;

-- 查询选修课程“CS-01”的学生中成绩第二高的学生学号
-- 通过 DENSE_RANK() 对成绩降序排列（ORDER BY GRADE DESC），并为每行分配排名
SELECT S#
FROM (
    SELECT S#, GRADE, DENSE_RANK() OVER (ORDER BY GRADE DESC) AS grade_rank
    FROM SC444
    WHERE C# = 'CS-01'
) AS ranked
WHERE grade_rank = 2;

-- 查询平均成绩超过“王涛”同学的学生学号、姓名和平均成绩，并按学号进行降序排列
SELECT S444.S#, SNAME, AVG(GRADE) AS AVG_GRADE
FROM S444 JOIN SC444 ON S444.S#=SC444.S#
GROUP BY S444.S#
HAVING AVG_GRADE>(
    SELECT AVG(GRADE)
    FROM S444 JOIN SC444 ON S444.S#=SC444.S#
    WHERE SNAME='王涛'
)
ORDER BY S444.S# DESC;

-- 查询选修了计算机专业全部课程（课程编号为“CS-××”） 的学生姓名及已获得的学分总数
SELECT SNAME, SUM(CREDIT) AS TOTAL_CREDIT
FROM S444
JOIN SC444 ON S444.S#=SC444.S#
JOIN C444 ON C444.C#=SC444.C#
WHERE GRADE>=60 AND S444.S# IN (
    SELECT S444.S#
    FROM S444
    WHERE NOT EXISTS (
        -- 外层查询筛选出所有计算机课程
        SELECT C444.C#
        FROM C444
        WHERE C444.C# LIKE 'CS-%'
        AND NOT EXISTS (
            -- 内层 NOT EXISTS 确保学生没有未选修的计算机课程
            SELECT *
            FROM SC444
            WHERE SC444.S# = S444.S#
            AND SC444.C# = C444.C#
        )
    )
)
GROUP BY S444.S#;

-- 查询选修了3门以上课程（包括3门）的学生中平均成绩最高的同学学号及姓名
SELECT S#, SNAME
FROM S444
WHERE S# IN (
    SELECT S#
    FROM (
        SELECT S#, AVG(GRADE) AS AVG_GRADE,
            DENSE_RANK() OVER (ORDER BY AVG_GRADE DESC) AS grade_rank
        FROM SC444
        GROUP BY S#
        HAVING COUNT(*)>=3
    ) AS ranked
    WHERE grade_rank = 1
);
