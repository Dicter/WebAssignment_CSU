package com.tom.test;

import com.tom.utils.JDBCUtils;
import org.junit.Test;

import java.sql.Connection;

public class JDBCUtilsTest {
    @Test
    public void testJDBCUtils(){
        Connection connection= JDBCUtils.getConnection();
        System.out.println(connection);
        JDBCUtils.close(connection);
    }
}
