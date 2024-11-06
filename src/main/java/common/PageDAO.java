package common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import admin.claim.ClaimVO;

public class PageDAO {
	
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	String sql = "";
	
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {}
		}
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
			} catch (Exception e) {}
			finally {	pstmtClose();	}
		}
	}
	
	public PageVO commonPagenation(int pag, int pageSize, int totRecCnt_) {
		
		PageVO vo = new PageVO();
		
		int totRecCnt = totRecCnt_;
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		//total값
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		vo.setPag(totPage);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		
		return vo;
	}
	
	public int getTotRecCnt(String tableName) {
		int totRecCnt = 0;
		try {
			sql = "select count(*) as totRecCnt from "+tableName;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
		  if(rs.next()) {
        totRecCnt = rs.getInt("totRecCnt");
		  }
			
		} catch (SQLException e) {
			System.out.println("sql 오류(pageDAO getTotRecCnt) "+e.getMessage());
		}finally {
			rsClose();
		}
		return totRecCnt;
	}

}
