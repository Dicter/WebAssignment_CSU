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
    <title>Forget Password</title>
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
        <div class="header">修改密码</div>
        <div class="form-wrapper">
            <span style="color:red;display: block;height: 15px" id="alerting"></span>
            <input type="text" name="username" placeholder="账号" class="input-item" id="accountInput">
            <input type="password" name="password" placeholder="输入原密码" class="input-item" id="rawPasswordInput">
            <input type="password" name="password" placeholder="新密码" class="input-item" id="passwordInput">
            <input type="password" name="passwordAgain" placeholder="确认密码" class="input-item" id="passwordConfirm">
            <div class="btn">
                <input id="confirmButton" type="submit" onclick="changePassword()" value="确认">
            </div>
        </div>
    </div>
</div>
</body>

<script>


    function changePassword(){
        document.getElementById("alerting").innerHTML="";
        var account=document.getElementById("accountInput").value;
        var rawPassword=document.getElementById("rawPasswordInput").value;
        var password1=document.getElementById("passwordInput").value;
        var password2=document.getElementById("passwordConfirm").value;
        if(account === "" || rawPassword === "" ||password2 === ""||password1===""){
            document.getElementById("alerting").innerHTML="输入不得为空";

            return;
        }
        if(password1!==password2 || password2===null||password2===undefined){
            document.getElementById("alerting").innerHTML="两次输入密码不一致";
            return;
        }
        if(password1.length<6){
            document.getElementById("alerting").innerHTML="密码过短";
            return;
        }
        var xhr=new XMLHttpRequest();
        var requestInfor="http://localhost:8080/changePassword" +
            "?account="+account+"&rawPassword="+rawPassword+"&password="+password2;
        xhr.open('POST',requestInfor,true);
        xhr.onreadystatechange=function (){
            if(xhr.readyState===4 && xhr.status===200){
                var jsonObj=JSON.parse(xhr.responseText);
                var message=jsonObj.message;
                if(message==="MODIFIED"){
                    alert("修改成功！");
                    window.location.href="/index.jsp"
                }else if(message==="WRONG PASSWORD"){
                    document.getElementById("alerting").innerHTML="密码错误";
                }else if(message==="WRONG PHONE NUMBER"){
                    alert("出错了！");
                }else if(message==="NO SUCH ACCOUNT"){
                    document.getElementById("alerting").innerHTML="账号不存在";
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
