<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:forEach items="${ requestScope.list }" var="r" varStatus="vs">
	<!-- <div class="container" id="container"> -->
		<a type="button" class="btn btn-info btn-lg" data-toggle="modal"
			data-target="#myModal"></a>
		<!-- Modal -->
		<div class="modal fade" id="myModal${vs.index}" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header1">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h5 id="modal-title" class="modal-title"><b>${ r.recipe_title }</b></h5>
					</div>
					<div class="modal-body">
						<table align="center" width="550" border="0" cellspacing="0"
							cellpadding="5" class="table">
							<tr>
								<td align="center" colspan="2"><img class="imgBox"
									id="imgBox"
									src="resources/recipe_upfiles/${ r.recipe_rename_imgname }"
									class="image"
									style="border-radius: 2%; width: 450px; height: 450px"></td>
							</tr>
							<th id="recipe_readcount" class="recipe_readcount">조회수
								: ${ r.recipe_readcount }</th>
							<th id="recipe_date" class="recipe_date" style="text-align: end;">작성날짜
								: <fmt:formatDate value="${ r.recipe_date }" type="date"
									pattern="yyyy-MM-dd" />
							</th>
							<tr>
								<td colspan="2" id="recipe_content" class="recipe_content">${r.recipe_content}</td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<c:if test="${ sessionScope.loginMember.admin eq 'Y' }">
							<c:url var="rup" value="/rmoveup.do">
								<c:param name="recipe_num" value="${ r.recipe_num }" />
							</c:url>
							<button onclick="javascript:location.href='${ rup }';">수정</button>
							<c:url var="rdel" value="/rdel.do">
								<c:param name="recipe_num" value="${ r.recipe_num }" />
								<c:param name="rfile" value="${ r.recipe_rename_imgname }" />
							</c:url>
							<button onclick="javascript:location.href='${ rdel }';">삭제</button>
						</c:if>
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>

			</div>
		</div>
	<!-- </div> -->
</c:forEach>

