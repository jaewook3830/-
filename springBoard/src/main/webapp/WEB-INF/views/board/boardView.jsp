<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
<script type="text/javascript">
	function update_go() {
		location.href = "/board/update_go.do?boardType=${boardType}&boardNum=${boardNum}";
	}
</script>
</head>
<body>
<script>
	if('${msg}' == '업데이트성공') {
		alert('${msg}');
	}else if('${msg}' == '업데이트실패'){
		alert('${msg}');
	}
</script>
<table align="center">
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
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
			<button onclick="update_go()">수정하기</button>
		</td>
	</tr>
</table>	
</body>
</html>