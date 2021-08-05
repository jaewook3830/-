<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>join</title>
<script src="/resources/js/jquery-1.10.2.js"></script>
<script type="text/javascript">
	var $j = jQuery.noConflict();
</script>
<script type="text/javascript">
	// 설정된 바이트의 크기를 넘어서지 못하게 체크하는 함수
	function inputLimitByteChecked(obj) {
	    var calByte = {
	        getByteLength : function( string ) {
	            if( string == null || string.length == 0 ) {
	                return 0;
	            }
	            let size = 0;
	            for( let num = 0; num < string.length; num++ ) {
	                size += this.charByteSize( string.charAt( num ) );
	            }
	            return size;
	        }
	        , cutByteLength : function( string, length ) {
	            if( string == null || string.length == 0 ) {
	                return 0;
	            }
	            let size = 0;
	            let rIndex = string.length;
	            for( let num = 0; num < string.length; num++ ) {
	                size += this.charByteSize( string.charAt( num ) );
	                if( size == length ) {
	                    rIndex = num + 1;
	                    break;
	                } else if( size > length ) {
	                    rIndex = num;
	                    break;
	                }
	            }
	            return string.substring( 0, rIndex );
	        }
	        , charByteSize : function( ch ) {
	            if( ch == null || ch.length == 0 ) {
	                return 0;
	            }
	            let charCode = ch.charCodeAt( 0 );
	            if( charCode <= 0x00007F ) {
	                return 1;
	            } else if( charCode <= 0x0007FF ) {
	                return 2;
	            } else if( charCode <= 0x00FFFF ) {
	                return 3;
	            } else {
	                return 4;
	            }
	        }
	    };
  		if( calByte.getByteLength( obj.value ) > obj.dataset.byte ) {
        	obj.value = calByte.cutByteLength( obj.value, obj.dataset.byte );
    	}
	}
	// id(영문,숫자만 가능)
	$j(document).ready(function() {
		$j("#id").keyup(function(event) {
			if(!(event.keyCode >= 37 && event.keyCode <= 40)) {
				var inputVal = $j(this).val();
				$j(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
			}
		});
	});
	// id 중복확인
	function id_chk() {
		$j.ajax({
			url : "/board/id_chk.do",
			method : "post",
			data : "id="+$j("#id").val(),
			dataType : "json",
			async : false,
			success : function(data) {
				if($j("#id").val() == ""){
					alert("아이디를 입력하세요.");
					$j("#id").focus();
				}
				else{
					if(data=='0'){
						alert("사용가능한 아이디입니다.");
						$j("#id_button").attr("disabled", true);
					}else if(data=='1'){
						alert("이미 존재하는 아이디가 있습니다.");
						$j("#id_button").attr("disabled", false);
						$j("#id").val("");
						$j("#id").focus();
					}
				}
			},
			error : function() {
				alert("실패");
			}
		});
	}
	// pw 체크
	function pw_chk(){
		if($j("#pw").val().length < 6 || $j("#pw").val().length > 13){
			alert("비밀번호는 6자리이상 12자리이하로 입력하세요.");
			$j("#pw").focus();
			return;
		}
	}
	$j(function() {
		$j("#pwcheck").keyup(function(){
			if($j("#pw").val() != $j("#pwcheck").val()){
				$j("#in").html("불일치");
			}else{
				$j("#in").html("일치");
			}
		});
		$j("#postNo").keypress(function(event) {
			if($j("#postNo").val().length == 3){
				var value = $j(this).val()+"-";
				$j(this).val(value);
			}
		});
	});

	function send(f) {
		var phonepattern = /(\d{4})$/;
		var addrpattern = /(\d{3})-(\d{3})$/;
		for (var i = 0; i < f.elements.length; i++) {
			if(f.elements[i].value==""){
				if(i==8||i==9||i==10) continue;
				alert(f.elements[i].name+"를 입력해주세요.");
				f.elements[i].focus();
				return;
			}
		}
		
		if($j("#id_button").prop('disabled')){
			if(phonepattern.test($j("#phone2").val()) && phonepattern.test($j("#phone3").val())){
				if($j("#postNo").val() == "" || addrpattern.test($j("#postNo").val())){
					f.action = "/board/boardJoinAction.do";
					f.submit();									
				}
				else{
					alert("postNo의 형식이 맞지 않습니다. xxx-xxx 형식으로 작성하세요.");
					$j("#postNo").focus();
				}
			}
			else{
				alert("phone의 형식이 맞지 않습니다. xxxx-xxxx 형식으로 작성하세요.")
				if(phonepattern.test($j("#phone2").val())){
					$j("#phone3").focus();
				}
				else{
					$j("#phone2").focus();
				}
			}
		} else {
			alert("아이디를 중복확인 하세요.")
		}
	}
	// name(한글)처리
	function hangul() {
		if((event.keyCode < 12592) || (event.keyCode > 12687) ) {		
			$j("#name").focus();
			event.returnValue = false;
		}
	}
</script>
</head>
<body>
<form>
<table  align="center">
	<tr>
		<td align="left">	
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td align="center">id</td>
					<td>
						<input type="text" id="id" name="id" maxlength="15" onkeydown="alphabet(this)"> 
						<input type="button" id="id_button" value="중복확인" onclick="id_chk()">
					</td>
				</tr>
				<tr>
					<td align="center">pw</td>
					<td>
						<input type="password" id="pw" name="pw" onchange="pw_chk()">
					</td>
				</tr>
				<tr>
					<td align="center">pw check</td>
					<td>
						<input type="password" id="pwcheck" name="pwcheck">&nbsp;<span id="in"></span>
					</td>
				</tr>
				<tr>
					<td align="center">name</td>
					<td>
						<input type="text" id="name" name="name" maxlength="5" onkeypress="hangul()">
					</td>
				</tr>
				<tr>
					<td align="center">phone</td>
					<td>
						<select id="phone1" name="phone1">
							<c:forEach items="${phoneList}" var="pl">
								<option value="${pl.codeId }">${pl.codeName}</option>
							</c:forEach>
						</select>
						-
						<input type="tel" id="phone2" name="phone2" size="4" maxlength="4">
						-
						<input type="tel" id="phone3" name="phone3" size="4" maxlength="4">
					</td>
				</tr>
				<tr>
					<td align="center">postNo</td>
					<td>
						<input type="text" id="postNo" name="postNo" maxlength="7">
					</td>
				</tr>
				<tr>
					<td align="center">address</td>
					<td>
						<input type="text" id="addr2" name="addr2" onkeyup="inputLimitByteChecked(this);" data-byte="150">
					</td>
				</tr>
				<tr>
					<td align="center">company</td>
					<td>
						<input type="text" id="company" name="company" onkeyup="inputLimitByteChecked(this);" data-byte="60">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<input type="button" value="join" onclick="send(this.form)">
		</td>
	</tr>
</table>
</form>
</body>
</html>