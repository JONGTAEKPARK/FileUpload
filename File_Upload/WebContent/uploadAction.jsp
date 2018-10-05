<%@ page import="file.FileDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP파일 업로드</title>
</head>
<body>
	<%
		String directory = "C:/upload";
		int maxSize = 1024 * 1024 * 100;
		String encoding="utf-8";
	
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, encoding,
				new DefaultFileRenamePolicy()); 
		
		String fileName = multipartRequest.getOriginalFileName("file");
		String fileRealName = multipartRequest.getFilesystemName("file");
		
		if(!fileName.endsWith(".jpg") && !fileName.endsWith(".hwp") &&
				!fileName.endsWith(".pdf") && !fileName.endsWith(".xls")){
			File file = new File(directory + fileRealName);
			file.delete();
			out.write("업로드 할 수 없는 확장자입니다.");
		}
		
		new FileDAO().upload(fileName, fileRealName);
		out.write("파일명: " + fileName + "<br>" );
		out.write("실제 파일명: " + fileRealName + "<br>" );
	%>
</body>
</html>