import random as rd
import mingzi as mz
from faker import Faker
import csv

# 定义待输入列表
rows = [['s#', 'sname', 'sex', 'height', 'bdate', 'dorm']]

# 初始化Faker
fk = Faker("zh_CN")

# 通过字典的键唯一性，快速生成唯一学号
unique_combinations = {}
while len(unique_combinations) < 5000:
    s = rd.randint(10000000,50000000)
    unique_combinations[s] = True  # 键自动去重

for s in unique_combinations.keys():
    row = []
    rd.seed(s)
    row.append(str(s))
    # 生成名字和性别
    temp = mz.mingzi(female_rate=0.49, show_gender=True, single_rate=0.3)
    row += temp[0]
    # 依据性别生成身高
    if (temp[0][1] == "女"):
        row.append(round(rd.gauss(162, 6) / 100, 2))
    else:
        row.append(round(rd.gauss(175, 7) / 100, 2))
    # 生成生日
    row.append(str(fk.date_of_birth(minimum_age=18, maximum_age=22)))
    # 生成宿舍
    dorm = rd.choice(["东 ", "西 "]) + str(rd.randint(1, 24)) + " 舍 "
    dorm += str(rd.randint(1, 8) * 100 + rd.randint(1, 30))
    row.append(dorm)
    # 加入一行
    rows.append(row)

# 打开文件并写入
with open('stu.csv', 'w', newline='') as file:
    stu = csv.writer(file)
    stu.writerows(rows)