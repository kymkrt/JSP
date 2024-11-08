package common;

import java.util.Calendar;

public class JavaGroupProcess {
	
	public String getTimeBasedFileName() {
			
		//파일명 중복방지(날짜로 처리)
		//파일명 중복 처리(날짜를 이용)- Date(sdf을 이용)나 Claender(내장 싱글톤 객체=생성할필요없음) 이용 
		//이렇게 하고 싶으면 아래 부분을 전부 메소드로 만들어서 호출만해서 쓸수 있도록 만들어야 한다
		Calendar cal =  Calendar.getInstance();//싱글톤은 거의 getInstance
		int yy = cal.get(Calendar.YEAR);
		int mm = cal.get(Calendar.MONTH) +1; //월은 0부터라 1을 더해야한다
		int dd = cal.get(Calendar.DAY_OF_MONTH);// 한자리수면 한자리로 나온다 그래서 공통메소드로 빼놔서 앞에 0을 붙이는 식으로 처리하면 좋다
		int hh = cal.get(Calendar.HOUR_OF_DAY);
		int mi = cal.get(Calendar.MINUTE);
		int ss = cal.get(Calendar.MILLISECOND);//천분의 1초 개념이라 3개 나옴 거의 중복되지 않는다 
		
		String strMM=mm+"", strDD=dd+"", strHH=hh+"", strMI=mi+"", strSS=ss+"", temp;
		
		if(mm<10) strMM = "0" + mm;
		if(dd<10) strDD = "0" + dd;
		if(hh<10) strHH = "0" + hh;
		if(mi<10) strMI = "0" + mi;
		if(ss<10) strSS = "0" + ss;
		temp = yy+strMM+strDD+strHH+strMI+strSS;
		//System.out.println("날짜 : "+yy+strMM+strDD+strHH+strMI+strSS);
		
		// 중복방지를 위한 파일명 조합하기(파일형식: 중복방지코드_파일명.확장자)
		//fileName = temp+"_"+ fileName;
		//System.out.println("fileName : "+fileName);
		return temp;
	}
}
