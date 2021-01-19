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
    <link rel="stylesheet" href="css/signIn.css">
    <title>Login Index</title>
<%--    <base href="http://localhost:8080/JavaWeb_War/">--%>
</head>
<body>
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
        <div class="header">注册</div>
            <div class="form-wrapper">
                <span style="color:red;display: block;height: 15px" id="alerting"></span>
                <input type="text" name="username" placeholder="账号" class="input-item" id="accountInput">
                <input type="password" name="password" placeholder="密码" class="input-item" id="passwordInput">
                <input type="text" name="phoneNumber" placeholder="手机号" class="input-item" id="phoneInput">
                <div class="btn">
                    <input id="loginButton" type="submit" onclick="signIn()" value="注册">
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    function signIn(){
        var username=document.getElementById("accountInput").value;
        var password=document.getElementById("passwordInput").value;
        var phoneNumber=document.getElementById("phoneInput").value;
        if(username === "" || password === ""){
            document.getElementById("alerting").innerHTML="输入不得为空";
            return;
        }
        if(!checkMobile(phoneNumber)){
            document.getElementById("alerting").innerHTML="手机号有误";
            return;
        }
        if(password.length<6){
            document.getElementById("alerting").innerHTML="密码过短";
            return;
        }
        var xhr=new XMLHttpRequest();
        var requestInfor="http://localhost:8080/register?username="+username+"&password="+password+"&phoneNumber="+phoneNumber;
        xhr.open('POST',requestInfor,true);
        xhr.onreadystatechange=function(){
            if(xhr.readyState===4 && xhr.status===200){
                var jsonObj=JSON.parse(xhr.responseText);
                var message=jsonObj.message;
                if(message==="SIGNIN SUCCESS"){
                    alert("注册成功！");
                    window.location.href="index.jsp";
                }else if(message==="DUPLICATED PHONE"){
                    document.getElementById("alerting").innerHTML="手机号已被注册";
                }else if(message==="DUPLICATED ACCOUNT"){
                    document.getElementById("alerting").innerHTML="账号已被注册";
                }
            }
        }
        xhr.send();
    }

    function checkMobile(s){
        var length = s.length;
        return length === 11 && /^(((13[0-9]{1})|(17[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[0-9]{1})|)+\d{8})$/.test(s);
    }
</script>
</html>
