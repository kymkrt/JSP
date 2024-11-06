package common;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.claim.ClaimVO;

public class PagenationCommand implements CommonInterFace {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int pag = (request.getParameter("pag")==null || request.getParameter("pag")=="") ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = (request.getParameter("pageSize")==null || request.getParameter("pageSize")=="") ? 1 : Integer.parseInt(request.getParameter("pageSize"));
		String tableName = request.getParameter("tableName")==null ? "" : request.getParameter("tableName");
		
		PageDAO dao = new PageDAO();
		PageVO pageVo = dao.commonPagenation(pag, pageSize, tableName);
		
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
