package actions;
import java.nio.charset.Charset;
import java.sql.*;
import com.csvreader.CsvReader;

public class Insert implements Runnable {

    private Thread t;
    private String threadName;
    private String filePath;
    private String JDBC_URL;
    private String JDBC_USER;
    private String JDBC_PASSWORD;
    private String tableName;
    private int INS_NUM;

    public Insert(String name, String path, String url, String user, String pw, String table, int num) {
        threadName = name;
        filePath = path;
        JDBC_URL = url;
        JDBC_USER = user;
        JDBC_PASSWORD = pw;
        tableName = table;
        INS_NUM = num;
        System.out.println("Creating " + threadName);
    }

    public void start() {
        System.out.println("Starting " + threadName);
        if(t == null) {
            t = new Thread(this, threadName);
            t.start();
        }
    }

    public void run() {
        CsvReader csvReader;
        int headerNum;
        String[] headerList;
        String sql;
        try {
            csvReader = new CsvReader(filePath, ',', Charset.defaultCharset());
            csvReader.readHeaders();
            headerNum = csvReader.getHeaderCount();
            headerList = csvReader.getHeaders();
            sql = structureSQL(headerNum, headerList);
            connect(sql, headerNum, csvReader);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("录入" + tableName + "完成");
    }

    // 构造sql语句
    String structureSQL(int headerNum, String[] headerList) {
        String headLine = headerList[0];
        String ques = "?";
        for (int i = 1; i < headerNum; i++) {
            headLine = headLine + "," + headerList[i];
            ques = ques + ",?";
        }
        String sql = "INSERT INTO " + tableName + " (" + headLine + ") VALUES (" + ques + ")";
        return sql;
    }

    // 连接数据库
    void connect(String sql, int headerNum, CsvReader csvReader) throws Exception {
        int count = 0;
        // 获取连接
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                while (csvReader.readRecord() && count < INS_NUM) {
                    count++;
                    String[] vs = csvReader.getValues();
                    for (int i = 0; i < headerNum; i++) {
                        String v = (i < vs.length) ? vs[i] : "";
                        // 检查输入数据类型，完成转换
                        if (v == null || v.trim().isEmpty()) {
                            ps.setNull(i + 1, Types.FLOAT);
                        } else if (v.matches("\\d+(\\.\\d+)?")) {
                            if (v.contains(".")) {
                                ps.setDouble(i + 1, Double.parseDouble(v));
                            } else {
                                ps.setInt(i + 1, Integer.parseInt(v));
                            }
                        } else {
                            ps.setString(i + 1, v);
                        }
                    }
                    ps.executeUpdate();
                }
            }
            // 关闭连接:
            conn.close();
        }
    }
}
