import xlrd
import re
import csv

NO = 1 # 课程小编号
SH = 2 # 开课单位（代码）
CNAME = 3 # 课程名称
PERIOD = 4 # 学时
CREIDT = 5 # 学分
TEACHER = 6 # 上课教师

# 定义 学院-代码 替换表和替换函数
translate_dict = {
    "材料学院": "MT",
    "法学院": "LW",
    "管理与经济学院": "EM",
    "光电学院": "OE",
    "国际教育学院": "IE",
    "化学与化工学院": "CE",
    "机电学院": "ME",
    "机械与车辆学院": "MV",
    "计算机学院": "CS",
    "马克思主义学院": "MX",
    "人文与社会科学学院": "HS",
    "设计与艺术学院": "DA",
    "生命学院": "LF",
    "数学学院": "MA",
    "外国语学院": "FL",
    "物理学院": "PH",
    "信息与电子学院": "EE",
    "徐特立学院": "TL",
    "宇航学院": "AS",
    "自动化学院": "AT"
}
def translate_func(match):
    return translate_dict[match.group(0)]

rows = [['c#', 'cname', 'period', 'credit', 'teacher']]

# 打开数据源表
data = xlrd.open_workbook("course.xls")
table = data.sheets()[0]

for i in range(950):
    row = []
    # 行数偏移
    r = i + 1
    # 读取
    code = table.cell_value(r, SH)
    # 确定小编号
    if (code == '计算机学院'):
        no = "%02d" % (table.cell_value(r, NO) + 5)
    elif (code == '信息与电子学院'):
        no = "%02d" % (table.cell_value(r, NO) + 3)
    else:
        no = "%02d" % (table.cell_value(r, NO))
    # 组合产生课程编号
    cno = re.sub("|".join(translate_dict.keys()), translate_func, code) + '-' + no
    row.append(cno)
    # 读取课程名
    row.append(table.cell_value(r, CNAME))
    # 读取学时
    row.append(table.cell_value(r, PERIOD))
    # 读取学分
    row.append(table.cell_value(r, CREIDT))
    # 读取上课教师
    row.append(table.cell_value(r, TEACHER))
    # 加入一行
    rows.append(row)

# 打开文件并写入
with open('course.csv', 'w', newline='') as file:
    course = csv.writer(file)
    course.writerows(rows)