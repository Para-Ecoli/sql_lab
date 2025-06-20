import random as rd
import csv

# 有上下界的随机正态分布随机函数
def truncated_gauss(mu = 80, sigma = 12, low = 0, high = 100):
    while True:
        num = rd.gauss(mu, sigma)
        if low <= num <= high:
            return num

# 读取学号信息
with open('stu.csv', 'r') as stu_csv:
    reader = csv.DictReader(stu_csv)
    stu_list = [row['s#'] for row in reader]

# 读取课程号信息
with open('course.csv', 'r') as course_csv:
    reader = csv.DictReader(course_csv)
    course_list = [row['c#'] for row in reader]

# 定义待输入列表
rows = [['s#', 'c#', 'grade']]

# 通过字典的键唯一性，快速生成唯一组合
unique_combinations = {}
while len(unique_combinations) < 200000:
    s = rd.choice(stu_list)
    c = rd.choice(course_list)
    unique_combinations[(s, c)] = True  # 键自动去重

for (s, c) in unique_combinations.keys():
    grade = round(truncated_gauss(), 1)
    if grade > 50:
        rows.append([s, c, grade])
    else:
        rows.append([s, c])

# 打开文件并写入
with open('sc.csv', 'w', newline='') as file:
    sc = csv.writer(file)
    sc.writerows(rows)
