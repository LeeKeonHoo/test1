<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "./resources/js/jquery-3.3.1.min.js"></script>
<script>
   var tNumChk = /[^a-z|^0-9]/gi;
   var emailChk = /[a-z0-9]{2,}@[a-z0-9-]{2,}.[a-z0-9]{2,}/i;

   $(function(){
      $("#btn").click(function(){
         /* .val()
         .text()
         .html() */
//          alert($("#dv").text() + "//" + $("#dv").html());
            $().attr();         
      })

      $("input[name=idChk]").click(function(){
         var id = $("#id").val();
         if(id == ""){
            alert("아이디를 입력하세요");
            return;

         }else{
            var chkNum = textCheck(tNumChk, id);
            if(chkNum == 1){
               alert("ID는 영숫자 조합만 사용하세요");
               $("#id").val("");
               $("#id").focus();
               return;

            }else{
               var idTxt = "test";
               if($("#id").val() == idTxt){
                  alert("중복된 아이디입니다.");
               }
            }
         }
      })

      $("#ph2").keyup(function(){
         if($("#ph2").val().length == 4){
            $("#ph3").focus();
         }
      })

      $("#jumin2").on("keyup", function(){
         var jumin2Data = $("#jumin2").val();
         var lastChar = jumin2Data.charAt(jumin2Data.length-1);
         var jumin3Data = $("#jumin3").val();
         $("#jumin3").val(jumin3Data + lastChar);

         if(jumin2Data.length > 1){
            var sliceStr = jumin2Data.slice(0,-1);
            $("#jumin2").val(sliceStr + "*");
         }
      })
   })

   function textCheck(regExp, id){
      if ((new RegExp(regExp)).test(id)) {
          return 1;
      }
      return 0;
   }

   function fncGoReg(){
      var pass1 = document.frm.pass.value;
      var pass2 = document.frm.pass2.value;
      if(pass1 != pass2){
         alert("비밀번호를 오류");
         return;
      }

      var emailTxt = $("#email1").val() + "@" + $("#email2").val();
      var check = textCheck(emailChk, emailTxt);
      alert(check);
      if(check == 0){
         alert("이메일 형식이 틀립니다.");
         return;
      }else{

      }
   }

   function fncNameKeyUp(){
      var txt = $("#name").val();
      if(txt.length > 5){
         $("#name").val(txt.substr(0,5));
         alert("최대 5글자만 입력");
         return;
      }
   }
</script>
</head>
<body>
<form name = "frm" id = "frm">
   <table width="1400" height="650">
     <tr>
      <td width="100%" height="10%">회원가입
      </td>
     </tr>

     <tr>
      <td height="60%" align="center" valign="top">
      <hr><br>

      <p align="left" style="padding-left:160px">
      <br><br>

      ID : <input type="text" size="10" maxlength="15" name="id" id = "id">
            <input type = "button" name = "idChk" value = "중복체크">
      <br><br>
      비밀번호 : <input type="password" size="15" maxlength="20" name="pass" id = "pass"><br><br>
      비밀번호 확인 : <input type="password" size="15" maxlength="20" name="pass2" id = "pass2"><br><br>
      이름 : <input type="text" size="13" name="name" id = "name" onkeyup="fncNameKeyUp()"><br><br>
      이메일 : <input type="text" size="15" name="email1" id = "email1">@<input type="text" size="15" name="email2" id = "email2"><br><br>
      휴대폰 : <select name="ph1">
          <option value="010">010</option>
          <option value="011">011</option>
          <option value="016">016</option>
          <option value="017">017</option>
          <option value="019">019</option>
        </select>
        - <input type="text" name="ph2" size="5" maxlength="4" id = "ph2"> - <input type="text" name="ph3" size="5" maxlength="4" id = "ph3"><br><br>
      성별 : <input type="radio" name="gender" value="남자"> 남자&nbsp;&nbsp;
      <input type="radio" name="gender" value="여자"> 여자<br><br>
      주민번호 : <input type = "text" name = "jumin1" id = "jumin1"> -  <input type = "text" name = "jumin2" id = "jumin2">
              <input type = "hidden" name = "jumin3" id = "jumin3">   
      <br><br>
      주소 : <input type="text" name="address" size="15" maxlength="15"><br>
      *주소는 (시/도)만 입력해주세요 (예: 경기도, 서울특별시, 경상남도 등)
      </p>
     </td>
     </tr>

     <tr>
      <td align="center">
      <hr><br>
       <input type="button"  id = "regi_btn" value="가입신청" onclick="fncGoReg()">&nbsp;
       <input type="reset" value="다시입력">&nbsp;
       <input type="button" value="취소">
      </td>
     </tr>

    </table>
    <input type = "button" name = "btn" id = "btn" value = "버튼">
    <div id = "dv">
    </div>
    <div id = "dv1">
    </div>
 </form>
</body>
</html>