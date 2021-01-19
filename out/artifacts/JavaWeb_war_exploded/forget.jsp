<%--
  Created by IntelliJ IDEA.
  User: dicte
  Date: 2020/12/10
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/forget.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/slick-theme.css">
    <link rel="stylesheet" href="css/slick.css">
    <title>Forget Password</title>
</head>
<body>
<div class="container">
    <ul class="cb-slideshow">
        <li><span></span></li>
        <li><span></span></li>
        <li><span></span></li>
        <li><span></span></li>
        <li><span></span></li>
        <li><span></span></li>
    </ul>
    <div class="login-wrapper">
        <div class="header">找回密码</div>
        <div class="form-wrapper">
            <span style="color:red;display: block;height: 15px" id="alerting"></span>
            <input type="text" name="username" placeholder="账号" class="input-item" id="accountInput">
            <input type="text" name="password" placeholder="短信验证码" class="input-item" id="SMSCodeInput">
            <input type="password" name="password" placeholder="密码" class="input-item" id="passwordInput">
            <input type="password" name="passwordAgain" placeholder="确认密码" class="input-item" id="passwordConfirm">
            <div class="btn">
                <input id="confirmButton" type="submit" onclick="changePassword()" value="确认">
            </div>
        </div>
        <div class="SMS">
            <a href="#" id="getSMSCode" onclick="getSMSCode()">获取验证码</a>
            <a href="#" id="timer" >60s</a>
        </div>
    </div>
</div>
</body>

<script>
    var maxtime=60;
    var timers;

    function waitFor60s(){
        var timer=document.getElementById("timer")
        var SMSButton=document.getElementById("getSMSCode");
        SMSButton.style.display="none";
        timer.style.display="inline-block";
        timers=setInterval("countdown()",1000);
    }

    function countdown(){
        var timer=document.getElementById("timer");
        var SMSButton=document.getElementById("getSMSCode");
        if(maxtime>0){
            timer.innerHTML=(maxtime-1)+"s";
            maxtime--;
        }else{
            clearInterval(timers);
            SMSButton.style.display="inline-block";
            timer.style.display="none";
            timer.innerHTML="60s";
            maxtime=60;
        }
    }



    function getSMSCode(){
        var x = document.getElementById('accountInput');
        var xhr=new XMLHttpRequest();
        var requestInfor="http://localhost:8080/getMessage?phone="+x.value;
        xhr.open('GET',requestInfor,true);
        xhr.onreadystatechange=function (){
            if(xhr.readyState===4 && xhr.status===200){
                var jsonObj=JSON.parse(xhr.responseText);
                var message=jsonObj.message;
                if(message==="NO SUCH PHONE"){
                    alert("手机号码有误！");
                }else if(message==="SENT"){
                    alert("发送成功！")
                }
            }
        }
        xhr.send();
        waitFor60s();
    }

    function changePassword(){
        document.getElementById("alerting").innerHTML="";
        var phoneNumber=document.getElementById("accountInput").value;
        var SMSCode=document.getElementById("SMSCodeInput").value;
        var password1=document.getElementById("passwordInput").value;
        var password2=document.getElementById("passwordConfirm").value;
        if(password1!==password2 || password2===null||password2===undefined){
            alert("两次密码输入不一致！");
            return;
        }
        var xhr=new XMLHttpRequest();
        var requestInfor="http://localhost:8080/forgetPassword" +
            "?phoneNumber="+phoneNumber+"&SMSCode="+SMSCode+"&password="+password2;
        xhr.open('POST',requestInfor,true);
        xhr.onreadystatechange=function (){
            if(xhr.readyState===4 && xhr.status===200){
                var jsonObj=JSON.parse(xhr.responseText);
                var message=jsonObj.message;
                if(message==="MODIFIED"){
                    alert("修改成功！");
                    window.location.href="/index.jsp"
                }else if(message==="WRONG CODE"){
                    document.getElementById("alerting").innerHTML="验证码错误";
                }else if(message==="WRONG PHONE NUMBER"){
                    alert("出错了！");
                }
            }
        }
        xhr.send();
    }
</script>
</html>
