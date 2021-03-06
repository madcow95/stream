package com.moviestream.movie.security;


import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class MemberTests {
	
	@Setter(onMethod_ = {@Autowired})
	private PasswordEncoder pwencoder;

	@Setter(onMethod_ = {@Autowired})
	private DataSource dataSource;

//	@Test
//	public void test() {
//		
//		String sql = "INSERT INTO tbl_admin(id, pwd, name) VALUES(?, ?, ?)";
//		
//		for(int i = 0; i < 5; i++) {
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			try {
//				con = dataSource.getConnection();
//				pstmt = con.prepareStatement(sql);
//				pstmt.setString(2, pwencoder.encode("pw"+(i+1)));
//				
//				pstmt.setString(1, "admin"+(i+1));
//				pstmt.setString(3, "관리자"+(i+1));
//				pstmt.executeUpdate();
//			} catch (Exception e) {
//				e.printStackTrace();
//			} finally {
//				if(pstmt != null) {
//					try {
//						pstmt.close();
//					} catch (Exception e2) {
//					}
//				}
//				if(con != null) {
//					try {
//						con.close();
//					} catch (Exception e2) {
//					}
//				}
//			}
//		}
//	}
	
	@Test
	public void testInsertAuth() {
		String sql = "INSERT INTO tbl_admin_auth(id, auth) VALUES(?, ?)";
		
		for(int i = 0; i < 5; i++) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = dataSource.getConnection();
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, "admin"+(i+1));
				pstmt.setString(2, "ROLE_ADMIN");
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e2) {
					}
				}
				if(con != null) {
					try {
						con.close();
					} catch (Exception e2) {
					}
				}
			}
		}
	}

}
