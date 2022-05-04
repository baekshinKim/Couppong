/**
 * member.js
 */
$(function(){
   $('#email2').change(function(){ //select에서 선택값을 변경할때 발생
         if($(this).val()=='etc'){ //직접입력을 선택한경우
            $('#email3').val(''); //기존에 입력된 email3의 value를 초기화
            $('#email3').css('visibility','visible'); //css에서 접근하여 visibility를 visible로 변경
            $('#email3').focus(); 
         }else{
            $('#email3').css('visibility','hidden');
         }
      });
      
      $('#btnChkId').click(function(){
         open("checkId.jsp?memid="+$('#memid').val(),"chk",
               "width=450,height=300,left=0,top=0,location=yes,resizable");
      });
      

});


   function validate_userid(id){
      var pattern = new RegExp(/^[a-zA-Z0-9_]+$/g);
      return pattern.test(id);
      /*
         a에서 z 사이의 문자, A~Z사이의 문자, 0 에서 9사이의 숫자나 _로 시작하거나 끝나야 한다는 의미 
         닫기 대괄호(]) 뒤의 + 기호는 이 패턴이 한 번 또는 그 이상 반복된다는 의미, 입력값이 없다면 false
      */
   }
   