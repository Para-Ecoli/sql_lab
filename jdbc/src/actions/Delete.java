package actions;

import java.sql.*;
import java.util.Random;

public class Delete implements Runnable {

    private Thread t;
    private String threadName;
    private String JDBC_URL;
    private String JDBC_USER;
    private String JDBC_PASSWORD;
    private String tableName;
    private int DEL_NUM;
    private boolean NO_TRI;
    private Random r = new Random();

    public Delete(String name, String url, String user, String pw, String table, int num, boolean no_tri) {
        threadName = name;
        JDBC_URL = url;
        JDBC_USER = user;
        JDBC_PASSWORD = pw;
        tableName = table;
        DEL_NUM = num;
        NO_TRI = no_tri;
        System.out.println("Creating " + threadName);
    }

    public void start() {
        System.out.println("Starting " + threadName);
        if (t == null) {
            t = new Thread(this, threadName);
            t.start();
        }
    }

    public void run() {
        String sql = structureSQL();
        try {
            connect(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("删除" + tableName + "完成");
    }

    // 构造sql语句
    String structureSQL() {
        String sql = "DELETE FROM " + tableName;
        if (NO_TRI) sql += " WHERE grade<60 OR grade IS NULL ORDER BY random() limit 1";
        else sql += " WHERE grade IS NULL ORDER BY random() limit 1";
        return sql;
    }

    // 连接数据库
    void connect(String sql) throws Exception {
        // 获取连接
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                Thread.sleep(1000);
                for (int i = 0; i < DEL_NUM; i++) {
                    ps.executeUpdate();
                    if (NO_TRI) Thread.sleep(150);
                    else Thread.sleep(r.nextInt(1000) + 1000);
                }
            }
            // 关闭连接:
            conn.close();
        }
    }
}
