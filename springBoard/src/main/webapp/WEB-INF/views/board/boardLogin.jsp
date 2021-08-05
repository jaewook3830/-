<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>login</title>
<script type="text/javascript">
	function login_ok(f) {
	if($j("#id").val() == ""){
		alert("아이디를 입력해주세요.");
		$j("#id").focus();
		return;
	}
	if($j("#pw").val() == ""){
		alert("비밀번호를 입력해주세요.");
		$j("#pw").focus();
		return;
	}
	
	$j.ajax({
		url : "/board/boardLoginAction.do",
		method : "post",
		data : "pw="+$j("#pw").val()+"&id="+$j("#id").val(),
		dataType : "json",
		async : false,
		success : function(data) {
			if(data["result"]=='0'){
				if(data["result2"]=='1'){
					alert("비밀번호가 틀렸습니다.");
					$j("#pw").focus();
				}else if(data["result2"]=='0'){
					alert("존재하는 아이디가 없습니다. 회원가입하세요.")
				}
			}else if(data["result"]=='1'){
				location.href="/board/boardList.do?pageNo=0";
			}	
		},
		error : function() {
			alert("읽기실패");
		}
	});
}
</script>
</head>
<body>
	<form>
		<table align="center">
			<tr>
				<td>
					<table id="boardTable" border = "1">
						<tr>
							<td align="center">id</td>
							<td><input type="text" id="id" name="id"></td>
						</tr>
						<tr>
							<td align="center">pw</td>
							<td><input type="password" id="pw" name="pw"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<input type="button" value="login" onclick="login_ok(this.form)">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>