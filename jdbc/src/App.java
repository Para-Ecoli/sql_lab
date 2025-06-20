import java.util.Scanner;

import actions.*;

public class App {

    private static String JDBC_URL = "jdbc:postgresql:mydb?useSSL=false&characterEncoding=utf8";
    private static String JDBC_USER = "admin";
    private static String JDBC_PASSWORD = "wuhaozhe@12345";
    private static String S_TABLE = "s444";
    private static String C_TABLE = "c444";
    private static String SC_TABLE = "sc444";
    private static String S_CSV = "csv/stu.csv";
    private static String C_CSV = "csv/course.csv";
    private static String SC_CSV = "csv/sc.csv";
    private static int S_NUM = 5000;
    private static int C_NUM = 1000;
    private static int SC_NUM = 20000;

    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
        boolean ifContinue = true;
        while (ifContinue) {
            System.out.println("你要进行的操作:");
            System.out.println("1. 录入S");
            System.out.println("2. 录入C");
            System.out.println("3. 录入SC(启用多线程删除)");
            System.out.println("4. 录入SC(禁用多线程删除)");
            System.out.println("5. 删除SC");
            System.out.println("0. 退出");
            switch (sc.nextInt()) {
                case 1: insertOnly(S_CSV, S_TABLE, S_NUM); break;
                case 2: insertOnly(C_CSV, C_TABLE, C_NUM); break;
                case 3: insertDelete(SC_CSV, SC_TABLE, SC_NUM); break;
                case 4: insertOnly(SC_CSV, SC_TABLE, SC_NUM); break;
                case 5: deleteOnly(SC_TABLE); break;
                case 0: ifContinue = false; break;
                default: System.out.println("错误");
            }
            Thread.sleep(1000);
        }
        sc.close();
    }

    static void insertOnly(String path, String table, int ins_num) {
        String threadName = "insert_" + table;
        Insert in = new Insert(threadName, path, JDBC_URL, JDBC_USER, JDBC_PASSWORD, table, ins_num);
        in.start();
    }

    static void insertDelete(String path, String table, int ins_num) {
        String threadName1 = "insert_" + table;
        Insert in = new Insert(threadName1, path, JDBC_URL, JDBC_USER, JDBC_PASSWORD, table, ins_num);
        in.start();
        String threadName2 = "delete_from_" + table;
        Delete de = new Delete(threadName2, JDBC_URL, JDBC_USER, JDBC_PASSWORD, table, 200, true);
        de.start();
    }

    static void deleteOnly(String table) {
        String threadName = "delete_from_" + table;
        Delete de = new Delete(threadName, JDBC_URL, JDBC_USER, JDBC_PASSWORD, table, 100, false);
        de.start();
    }
}