function chCkStr(strg,wch){
	var filter=null;
	switch(wch){
	case "letter":
		 filter=/^([a-zA-Zа-яА-Я_\.\-\ ]){1,30}$/;
 	break;
	case "user":
		filter=/^([a-zA-Z0-9_\.\-]){3,30}$/;
	break;
	case "name":
		filter=/^([a-zA-Zа-яА-Я0-9_\.\-\ ]){2,20}$/;
	break;
	case "passwd":
		filter=/^([a-zA-Z0-9_\.\-]{6,30})$/;
	break;
	case "num":
		filter=/^([0-9]{3,14})$/; // fix it ???!!!
	break;
	default:
		filter=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})$/;
	break;
	}
	if(filter.test(strg)) return true;
	else return false;
}



	 
function clear_all() {  // SET all form elements to empty values - null or 0
     document.regform.firstname.value = "";
     document.regform.lastname.value = "";
     document.regform.login.value = "";
     document.regform.passwd.value = "";
     document.regform.repass.value = "";
     document.regform.address.value = "";
     document.regform.email.value = "";
     document.regform.check.checked = false;  // checked = false means not checked
}
	 	 
function check_all() {
//  use  function chCkStr(strg,wch) check string in cases: "letter"; "user" ; "name" ; "pass" ; "num" and default mail 
   var check_case = "";
   check_case = document.regform.firstname.value;
   if (check_case == "" || check_case == null) {
       alert("Въведете име!");
       return false;
   }
   if (!chCkStr(check_case,'letter')) {
       alert("Невалидно име!");
       return false;
   }
   check_case = document.regform.lastname.value;
   if (check_case == "" || check_case == null) {
       alert("Въведете фамилия!");
       return false;
   }
   if (!chCkStr(check_case,'letter')) {
       alert("Невалидно име!");
       return false;
   }
   check_case = document.regform.login.value;
   if (check_case == "" || check_case == null) {
       alert("Въведете потребителско име!");
       return false;
   }
   if (!chCkStr(check_case,'letter')) {
       alert("Невалидно потребителско име!");
       return false;
   }
   check_case = document.regform.passwd.value; 
   if (check_case == "" || check_case == null) {
       alert("Въведете парола!");
       return false;
   }
   if (!chCkStr(check_case,'passwd')) {
       alert("Невалидна парола!");
       return false;
   }
   check_case = document.regform.repass.value;
   if (check_case == "" || check_case == null) {
       alert("Въведете повторна парола!");
       return false;
   }
   if (!chCkStr(check_case,'passwd')) {
       alert("Невалидна повторна парола!");
       return false;
   }
   if (check_case != document.regform.passwd.value){
       alert("Парола и повторна парола се различават!");
       return false;
   }
/*
   check_case = document.regform.address.value; 
   if (check_case == "" || check_case == null) {
       alert("Въведете адрес!");
       return false;
   }
   check_case = document.regform.mail.value;
   if (check_case == "" || check_case == null) {
       alert("Въведете email!");
       return false;
   } 
*/
   check_case = document.regform.email.value;
   if (!chCkStr(check_case,'') && (check_case != "" && check_case != null) ) {
       alert("Невалиден email!");
       return false;
   }
   // alert("Всичко се изпълнява!");
}



