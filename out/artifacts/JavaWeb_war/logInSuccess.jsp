<%--
  Created by IntelliJ IDEA.
  User: dicte
  Date: 2020/12/9
  Time: 23:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign In Success</title>
</head>
<body>
<div id="redirectPage">登录成功！将在3秒后跳转至主页。</div>
</body>
<script>
    var div =document.querySelector("div");
    var time=2;
    setInterval(function(){
        if(time===0){
            location.href="http://www.csu.edu.cn/";
        }else{
            div.innerHTML="登录成功！将在"+time+"秒后跳转至主页。";
            time--;
        }
    },1000);
</script>
</html>
