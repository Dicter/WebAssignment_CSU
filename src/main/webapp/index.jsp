<%--
  Created by IntelliJ IDEA.
  User: dicte
  Date: 2020/12/8
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/index.css">
    <title>Login Index</title>
</head>
<body onload="clear()">
<div class="top" id="top"
     style="z-index: 100;">
    <img class="topLogo" src="images/logo.png"  alt="logo">
</div>
<div class="container">
    <ul class="slideshow">
        <li><span></span></li>
        <li><span></span></li>
        <li><span></span></li>
        <li><span></span></li>
        <li><span></span></li>
        <li><span></span></li>
   </ul>
    <div class="login-wrapper">
        <div class="header">登录</div>
            <div class="form-wrapper">
                <span style="color:red;display: block;height: 15px" id="alerting"></span>
                <input type="text" name="username" placeholder="账号" class="input-item" id="accountInput">
                <input type="password" name="password" placeholder="密码" class="input-item" id="passwordInput">
                <div class="code" style="display: inline-block">
                    <input type="text" name="code" placeholder="验证码" class="input-code" id="code">
                    <img src="http://localhost:8080/kaptcha.jpg" style="width: 45%; height: 50%; float: right;vertical-align:middle" id="CodeImg"
                    onclick="changeImage()">
                </div>

                <div class="btn">
                    <input id="loginByPasswordButton" type="submit" onclick="loginByPassword()" value="登录">
                    <input id="loginBySMSButton" type="submit" onclick="loginBySMS()" value="登录">
                </div>
            </div>
        <div class="SMS">
            <a href="#" id="loginBySMS" onclick="loginToSMS()">短信验证码登录 </a>
            <a href="#" id="getSMSCode" onclick="getSMSCode()">获取验证码</a>
            <a href="#" id="timer" >60s</a>
            <a href="#" id="loginByPassword" onclick="loginToAccount()">账号密码登录</a>
        </div>
        <div class="msg">
            <a href="signIn.jsp">注册  </a>
            <a href="forget.jsp">忘记密码</a>
            <a href="modifyPassword.jsp">修改密码</a>
        </div>
    </div>
</div>
</body>
<script>
    var maxtime=60;
    var timers;

    function loginByPassword(){
        var username=document.getElementById("accountInput").value;
        var password=document.getElementById("passwordInput").value;
        var code=document.getElementById("code").value;
        if(username === "" || password === "" ||code === ""){
            document.getElementById("alerting").innerHTML="输入不得为空";
            changeImage();
            return;
        }
        var xhr=new XMLHttpRequest();
        var requestInfor="http://localhost:8080/login?username="+username+"&password="+password+"&code="+code;
        xhr.open('POST',requestInfor,true);
        xhr.onreadystatechange=function(){
            if(xhr.readyState===4 && xhr.status===200){
                var jsonObj=JSON.parse(xhr.responseText);
                var message=jsonObj.message;
                if(message==="USERNAME LOGIN SUCCESS"){
                    if(username==="admin"){
                        window.location.href="/admin.jsp";
                    }else{
                        window.location.href="/logInSuccess.jsp";
                    }
                }else if(message==="USERNAME LOGIN ERROR"){
                    document.getElementById("alerting").innerHTML="账号不存在或密码错误";
                    changeImage();
                }else if(message==="WRONG CODE"){
                    document.getElementById("alerting").innerHTML="验证码错误或失效";
                    changeImage();
                }
            }
        }
        xhr.send();
    }

    function loginBySMS(){
        var phoneNumber=document.getElementById("accountInput").value;
        var SMSCode=document.getElementById("passwordInput").value;

        if(phoneNumber === "" || SMSCode === ""){
            document.getElementById("alerting").innerHTML="输入不得为空";
            changeImage();
            return;
        }
        var xhr=new XMLHttpRequest();
        var requestInfor="http://localhost:8080/login?phoneNumber="+phoneNumber+"&SMSCode="+SMSCode;
        xhr.open('POST',requestInfor,true);
        xhr.onreadystatechange=function(){
            if(xhr.readyState===4 && xhr.status===200){
                var jsonObj=JSON.parse(xhr.responseText);
                var message=jsonObj.message;
                if(message==="PHONE LOGIN SUCCESS"){
                    window.location.href="/logInSuccess.jsp";
                }else if(message==="PHONE LOGIN ERROR"){
                    document.getElementById("alerting").innerHTML="手机不存在或验证码错误";
                }
            }
        }
        xhr.send();
    }

    function loginToAccount(){
        var inputArea1=document.getElementById("accountInput");
        inputArea1.placeholder = "账号";
        inputArea1.name="username";
        inputArea1.innerHTML="";

        var inputArea2=document.getElementById('passwordInput');
        inputArea2.placeholder="密码"
        inputArea2.name ="password";
        inputArea2.innerHTML="";

        var VCode=document.getElementById("code");
        VCode.style.display="inline";
        var CodeImg=document.getElementById("CodeImg");
        CodeImg.style.display="inline";

        var gettingSMSCode=document.getElementById("getSMSCode");
        gettingSMSCode.style.display='none';

        var loginbyPassword=document.getElementById("loginBySMS");
        loginbyPassword.style.display='inline-block';

        var loginByPasswordButton=document.getElementById("loginByPasswordButton");
        loginByPasswordButton.style.display="inline-block";

        var loginBySMSButton=document.getElementById("loginBySMSButton");
        loginBySMSButton.style.display="none";

        var loginBySMSCode=document.getElementById("loginByPassword");
        loginBySMSCode.style.display='none';

        var alter=document.getElementById("alerting");
        alter.innerHTML="";

        var timer=document.getElementById("timer");
        if(timers!=null){
            clearInterval(timers);
            timer.style.display="none";
            timer.innerHTML="60s";
            maxtime=60;
            
        }
    }

    function loginToSMS(){
        var inputArea1=document.getElementById("accountInput");
        inputArea1.placeholder = "手机号";
        inputArea1.name="phone";
        inputArea1.innerHTML="";

        var inputArea2=document.getElementById('passwordInput');
        inputArea2.placeholder="短信验证码"
        inputArea2.type="text";
        inputArea2.name ="SMSCode";
        inputArea2.innerHTML="";

        var VCode=document.getElementById("code");
        VCode.style.display="none";
        var CodeImg=document.getElementById("CodeImg");
        CodeImg.style.display="none";

        var gettingSMSCode=document.getElementById("getSMSCode");
        gettingSMSCode.style.display='inline-block';

        var loginbyPassword=document.getElementById("loginByPassword");
        loginbyPassword.style.display='inline-block';

        var loginbySMSCode=document.getElementById("loginBySMS");
        loginbySMSCode.style.display='none';

        var loginBySMSButtons=document.getElementById("loginBySMSButton");
        loginBySMSButtons.style.display="inline-block";

        var loginByPasswordButtons=document.getElementById("loginByPasswordButton");
        loginByPasswordButtons.style.display='none';

        var alter=document.getElementById("alerting");
        alter.innerHTML="";

        var timer=document.getElementById("timer");
        if(timers!=null){
            clearInterval(timers);
            timer.style.display="none";
            timer.innerHTML="60s";
            maxtime=60;
        }
    }


    function waitFor60s(){
        var timer=document.getElementById("timer")
        var SMSbutton=document.getElementById("getSMSCode");
        SMSbutton.style.display="none";
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
        if(x.value === ""){
            var alert=document.getElementById("alerting");
            alert.innerHTML="手机号码不得为空";
            return;
        }
        if(!checkMobile(x.value)){
            document.getElementById("alerting").innerHTML="手机号有误";
            return;
        }
        var xhr=new XMLHttpRequest();
        var requestInfor="http://localhost:8080/getMessage?phone="+x.value;
        xhr.open('GET',requestInfor,true);
        xhr.onreadystatechange=function (){
            if(xhr.readyState===4 && xhr.status===200){
                var jsonObj=JSON.parse(xhr.responseText);
                var message=jsonObj.message;
                if(message==="NO SUCH PHONE"){
                    var alert=document.getElementById("alerting");
                    alert.innerHTML="手机号码有误";

                }else if(message==="SENT"){
                    var alert=document.getElementById("alerting");
                    alert.innerHTML="发送成功";
                    waitFor60s();
                }
            }
        }
        xhr.send();
    }

    function changeImage(){
        let img=document.getElementById("CodeImg");
        img.src="http://localhost:8080/kaptcha.jpg?d="+new Date();
    }

    function checkMobile(s){
        var length = s.length;
        return length === 11 && /^(((13[0-9]{1})|(17[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[0-9]{1})|)+\d{8})$/.test(s);
    }
    function clear(){
        document.getElementById("accountInput").value="";
        document.getElementById("phoneInput").value="";
        document.getElementById("passwordInput").value="";
        document.getElementById("code").value="";
    }


</script>
</html>
