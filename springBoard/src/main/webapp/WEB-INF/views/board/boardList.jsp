<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">
	$j(document).ready(function(){
		/*
		var checkArr = [];
		$j("#btn").on("click",function(){
			checkArr = [];
			$j("input[name='chb']:checked").each(function(e) {
				checkArr.push($j(this).val());
			});
			
			$j.ajax({
			    url : "/board/boardList.do" ,
			    dataType: "json",
			    type: "POST",
			    data : {'checkArr' : checkArr},
			    success: function(data)
			    {
			    	console.log(data);
			    },
			    error: function(e)
			    {
			    	console.log('실패');
			    }
			});
		});
		*/
		$j("#checkall").click(function(){
			if($j("#checkall").prop("checked")){
				$j("input[name=chb]").prop("checked",true);
			}else{
				$j("input[name=chb]").prop("checked",false);
			}
		});
		
		$j(".checknotall").click(function(){
			$j("#checkall").prop("checked",false);
		});
		
		$j(".checknotall").change(function(){
			var a = $j("input[type='checkbox'].checknotall");
			if(a.length == a.filter(":checked").length){
				$j("#checkall").prop("checked",true);
			}
		});
	});
</script>
<body>
<script>
	if('${msg_insert}' == '삽입성공'){
		alert('회원가입완료');
	}
	
	if('${msg}' == '삭제성공') {
		alert('${msg}');
	}else if('${msg}' == '삭제실패'){
		alert('${msg}');
	}
</script>
<table  align="center">
	<tr>
		<td align="right">
			<c:choose>
				<c:when test="${login=='ok'}">
					<a href = "/board/boardLogout.do">로그아웃</a>
				</c:when>
				<c:otherwise>
					<a href = "/board/boardLogin.do">login</a>
					<a href = "/board/boardJoin.do">join</a>
				</c:otherwise>
			</c:choose>
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
							<c:forEach items="${typeList}" var="tl">
								<c:if test="${list.boardType == tl.codeId}">
									${tl.codeName}
								</c:if>
							</c:forEach>
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
		</td>
	</tr>
</table>	
<form style="text-align: center" action="/board/boardList.do" method="get">
	<input type="checkbox" id="checkall" name="chb" value="a00">전체
	
	<c:forEach items="${typeList}" var="tl">
		<input type="checkbox" class="checknotall" name="chb" value="${tl.codeId}"><label id="${tl.codeId}">${tl.codeName}</label>
	</c:forEach>
	<input type="submit" value="전송">
</form>
<!--  
<script>
	var arr = [];
	<c:forEach items="${typeList}" var="item">
	arr.push("${item.codeId}");
	arr.push("${item.codeName}");
	</c:forEach>
	
	$j("input[name='chb']").each(function(e){
		var k = $j(this).val();
		$j.each(arr, function(index, item) {
			if(k == item){
				$j("#"+item).text(arr[index+1]);
			}
		});
	});
</script>
-->
</body>
</html>