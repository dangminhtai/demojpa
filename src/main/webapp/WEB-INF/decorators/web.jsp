<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div>
        <%-- Gọi trang chung header.jsp --%>
        <%@ include file="/commons/web/header.jsp"%>
    </div>
    <div>
        <%-- Gọi trang content riêng --%>
        <sitemesh:write property="body"/>
    </div>
    <div>
        <%-- Gọi trang chung footer.jsp --%>
        <%@ include file="/commons/web/footer.jsp"%>
    </div>
</body>
</html>