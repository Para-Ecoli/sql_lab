-- 将S444表中已修学分数大于60的学生记录删除
DELETE FROM S444
WHERE S# IN (
    SELECT S#
    FROM C444, SC444
    WHERE C444.C#=SC444.C#
    GROUP BY S#
    HAVING SUM(CREDIT)>60
);
