package com.cpn.common;

public class util {
	public static final int CUSTOMER=1;
	public static final int STAFF=2;
	
	public static final String SAVE_DIR="C:\\Users\\82109\\git\\Couppong\\cpn\\WebContent\\thumbnails"; //사진 저장경로
	
	//권한번호 확인
	public static boolean chkRig(int rigNo) {
		boolean bool=false; //회원이면 TRUE, 권한없음
		
		if(rigNo==CUSTOMER) {
			bool=true;
		}
		return bool;
	}
	
	public static String cutContent(String coupContent) {
		//제목이 50자 이상인 경우 일부만 추출하기, 나머지는 ...처리
		if(coupContent.length()>15) {
			coupContent=coupContent.substring(0, 15)+"...";
		}
	return coupContent;
	}
	
	public static String cutTitle(String coupContent) {
		//제목이 50자 이상인 경우 일부만 추출하기, 나머지는 ...처리
		if(coupContent.length()>10) {
			coupContent=coupContent.substring(0, 10)+"...";
		}
		return coupContent;
	}
	
	//수정또는 상세보기에서 파일이 존재하는경우 해당 파일 정보를 출력
	public static String getFileInfo(String originalFileName,long fileSize) {
		String src=""; 
		float fSize=fileSize/1024f;
		fSize=Math.round(fSize*10)/10f;
		if(originalFileName!=null && !originalFileName.isEmpty()) {
			src="<img src=../images/file.gif alt='file이미지'> "
					+originalFileName+" ("+fileSize+"KB) ";
		}
		
		return src;
	}
}
