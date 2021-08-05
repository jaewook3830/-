<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
<script type="text/javascript">
	function delete_ok() {
		location.href="/board/delete.do?boardType=${boardType}&boardNum=${boardNum}";
	}
	function update_ok(f) {
		f.action="/board/update.do";
		f.submit();
	}
</script>
</head>
<body>
<form method="get">
<table align="center">
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400">
					<input type="text" name="title" value="${board.boardTitle}">
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					<textarea rows="20" cols="60" name="comment">${board.boardComment}</textarea>
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
					${board.creator}
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
	<tr>
		<td>
			<input type="button" id="btn1" value="수정" onclick="update_ok(this.form)">
			<input type="button" id="btn2" value="삭제" onclick="delete_ok()">
			<input type="hidden" name="boardType" value="${boardType }">
			<input type="hidden" name="boardNum" value="${boardNum }">
		</td>
	</tr>
</table>
</form>
</body>
</html>