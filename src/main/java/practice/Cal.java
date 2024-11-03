package practice;

public class Cal {
	public static void main(String[] args) {
		System.out.println("시작");
		int j = 2000000;
		int k = 0;
		for(int i=0 ; i<=240; i++) {
			if(i % 12 == 0) {
				j += 150000;
			}
			k += j;
			System.out.println(i+"월 "+j+"원");
		}
		System.out.println("총금액 "+k);
	}
}
