<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
a.post {
	text-decoration: none;
	color: black;
}
</style>
<table class="table table-hover">
	<thead>
		<tr>
			<th>글번호</th>
			<th>진행상황</th>
			<th>글제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
	</thead>
	<!-- 나의 게시물 리스트 -->
	<tbody>
	<c:forEach var="info" items="${requestScope.listvo.list }">
	<c:choose><%--아직 답글을 읽지 않은 게시물은 노란색으로 표시 --%>
		<c:when test="${info.answerVO.readRe==0}"><tr class="warning"></c:when>
		<c:otherwise><tr></c:otherwise>
	</c:choose>
			<td>${info.pNo}</td>
			<c:choose><%-- 답변여부 --%>  
				<c:when test="${info.reply==0 }">				
					<td><span class="label label-danger">진행중</span></td>
				</c:when>
				<c:otherwise>
					<td><span class="label label-success">답변완료</span></td>
				</c:otherwise>
			</c:choose><%-- // 답변여부 --%>					
			<c:choose>	<%-- 공개 비공개 구분 --%>		
					<c:when test="${info.lock=='y' }"><%--비공개(y) 글보기 --%>								
								<td><a class="post" href="${pageContext.request.contextPath}/dispatcher?command=ReadMyPostInfo&pNo=${info.pNo}">
								<i class="fas fa-lock"></i>&nbsp;${info.pTitle }</a></td>
					</c:when><%--// 비공개(y) 글보기 --%>					
					<c:otherwise><%--공개글 보기 --%>
						<td><a class="post" href="${pageContext.request.contextPath}/dispatcher?command=ReadMyPostInfo&pNo=${info.pNo}">
								${info.pTitle }</a></td>
					</c:otherwise><%-- // 공개글 보기--%>
			</c:choose><%-- // 공개 비공개 구분 --%>
					
			<td>${info.userVO.nickName }</td>
			<td>${info.pDate}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
<div class="col-xs-10 text-center">
	
	<div class="input-group col-xs-offset-4 col-xs-4">
		
		<!-- 검색메뉴 드랍다운 -->
		<div class="input-group-btn">
			<button id="menuBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				제목 <span class="caret"></span>
			</button>
			<ul id="findMenu" class="dropdown-menu">
				<li><a href="#">제목</a></li>
				<li><a href="#">작성자</a></li>
				<li><a href="#">내용</a></li>
				<!-- <li class="divider"></li>
				<li><a href="#">Separated link</a></li> -->
			</ul>
		</div>
		
			<!-- 검색폼 -->
			<%-- <form name="searchForm" action="${pageContext.request.contextPath}/dispatcher"> 
			폼 설정하면 검색폼 모양 흐트러짐 주의!!!
			 --%>
		<input type="text" class="form-control" id="keyword" name="keyword">
		<span class="input-group-btn">
			<button class="btn btn-primary" type="button" id="findBtn">
				<i class="fas fa-search"></i>
			</button>
		</span>
		<input type="hidden" name="command" value="Search">
		<input type="hidden" name="category" value="제목">
	</div>

	<!-- 페이징버튼 -->
	<ul class="pagination pagination">
		<%-- 페이징빈 코드 줄여서 변수에 담음 : pb--%>
		<c:set var="pb" value="${requestScope.listvo.pagingBean}"></c:set>
		<%--이전 페이지로 돌아가기 --%>
		<c:if test="${pb.previousPageGroup}">		
			<li><a href="dispatcher?command=ReadMyPostList&pageNo=${pb.startPageOfPageGroup-1}">«</a></li>
		</c:if>
		<%--페이지그룹 시작번호부터 끝번호 및 현재 페이지 --%>
		<c:forEach var="page" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
		<c:choose>
			<c:when test="${pb.nowPage!=page}">
				<li><a href="dispatcher?command=ReadMyPostList&pageNo=${page}">${page}</a></li>
			</c:when>
			<c:otherwise>
				<li class="active"><a href="#">${page}</a></li>
			</c:otherwise>
		</c:choose>
		</c:forEach>
		<%-- 다음페이지로 넘어가기  --%>
		<c:if test="${pb.nextPageGroup}">		
			<li><a href="dispatcher?command=ReadMyPostList&pageNo=${pb.endPageOfPageGroup+1}">»</a></li>
		</c:if>
	</ul>
</div>
