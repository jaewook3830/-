<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#submit").on("click",function(){
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			
			var boardType = $j("#menu option:selected").val();
			console.log(boardType);
			$j.ajax({
			    url : "/board/boardWriteAction.do?boardType="+boardType ,
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("작성완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do?pageNo=0";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
		
		$j("#row").on("click", function() {
			var tbody = "";
			  tbody +="<tr><td width='120' align='center'>Type</td>";
			  tbody +="<td><select id='menu' name='bType'><c:forEach items='${typeList}' var='tl'><option value='${tl.codeId }'>${tl.codeName}</option></c:forEach></select><input type='button' id='del_btn2' style='float: right;' value='행삭제' onclick='del_row(this);'></td></tr>";
			  tbody +="<tr><td width='120' align='center'>Title</td>";
			  tbody +="<td width='400'><input name='boardTitle' type='text' size='50' value='${board.boardTitle}'></td></tr>";
			  tbody +="<tr><td height='300' align='center'>Comment</td>";
			  tbody +="<td valign='top'><textarea name='boardComment'  rows='20' cols='55'>${board.boardComment}</textarea></td></tr>";
		  $j("#tbody").append(tbody);
		});
		
		$j("#del_btn").bind("click", function() {
			var trNum = $j(this).closest('tr').prevAll().length;
			$j("#tb tr").eq(trNum).remove();
			$j("#tb tr").eq(trNum).remove();
			$j("#tb tr").eq(trNum).remove();
		});
	});
	function del_row(f) {
		var trNum = $j(f).closest('tr').prevAll().length;
		$j("#tbody tr").eq(trNum).remove();
		$j("#tbody tr").eq(trNum).remove();
		$j("#tbody tr").eq(trNum).remove();
	}

</script>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
			<input id="submit" type="button" value="작성">
			<input id="row" type="button" value="행추가">
			</td>
		</tr>
		<tr>
			<td>
				<table id="tb" border ="1"> 
					<tr>
						<td width="120" align="center">
						Type
						</td>
						<td>
							<select id="menu" name="bType">
								<c:forEach items="${typeList}" var="tl">
									<option value="${tl.codeId }">${tl.codeName}</option>
								</c:forEach>
							</select>
							<input style="float: right;" type="button" id="del_btn" value="행삭제">
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tbody id="tbody">
					</tbody>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						${userVo.name}
						<input type="hidden" name="creator" value="${userVo.name }">
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
	</table>
</form>	
</body>
</html>