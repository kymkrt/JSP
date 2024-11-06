package admin.claim;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import admin.AdminInterface;
import common.PageDAO;
import common.PageVO;

public class ClaimListCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int pag = (request.getParameter("pag")==null || request.getParameter("pag")=="") ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = (request.getParameter("pageSize")==null || request.getParameter("pageSize")=="") ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		String tableName = request.getParameter("tableName")==null ? "claim" : request.getParameter("tableName");
		
		AdminDAO dao = new AdminDAO();
		PageDAO pageDao = new PageDAO();
		PageVO pageVo = new PageVO();
		
		int totRecCnt = pageDao.getTotRecCnt(tableName);
		pageVo = pageDao.commonPagenation(pag, pageSize, totRecCnt);
		
		List<ClaimVO> vos = dao.getClaimList(pageVo.getStartIndexNo(), pageSize);
		
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("tableName", tableName);
		request.setAttribute("totRecCnt", pageVo.getTotRecCnt());
		request.setAttribute("totPage", pageVo.getTotPage());
		request.setAttribute("startIndexNo", pageVo.getStartIndexNo());
		request.setAttribute("curScrStartNo", pageVo.getCurScrStartNo());
		request.setAttribute("blockSize", pageVo.getBlockSize());
		request.setAttribute("curBlock", pageVo.getCurBlock());
		request.setAttribute("lastBlock", pageVo.getLastBlock());
		
		request.setAttribute("vos", vos);
	}

}
