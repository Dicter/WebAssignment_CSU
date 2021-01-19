<%--
  Created by IntelliJ IDEA.
  User: dicte
  Date: 2020/12/10
  Time: 9:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>用户管理界面</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body onload="updateUserInfor()">
    <div class="titleBar">用户管理面板</div>

    <div class="functionBar">
        <button id="append" onclick="appendUser()">增加用戶</button>
        <button id="check" onclick="checkUser()">查找用戶</button>
    </div>
    <div id="userDisplay">
        <table id="userTable">
            <tr>
                <th>学号</th>
                <th>密码</th>
                <th>手机号码</th>
                <th>操作</th>
            </tr>
        </table>
    </div>
</body>

<script>
    var delFunction=function deleteItem(){
        var delUsername=this.parentElement.parentElement.firstChild.textContent;
        var xhr=new XMLHttpRequest();
        var requestInfor="http://localhost:8080/admin?request=del&username="+delUsername;
        xhr.open('POST',requestInfor,true);
        xhr.onreadystatechange=function(){
            if(xhr.readyState===4 && xhr.status===200){
                jsonObj=JSON.parse(xhr.responseText);
                var message=jsonObj.message;
                if(message==='SUCCESS'){
                    alert("删除成功！");
                    updateUserInfor()
                }
            }
        }
        xhr.send();
        this.parentElement.parentElement.parentElement.removeChild(this.parentElement.parentElement);
    }

    var modiFunction=function modify(){
        var modifyUsername=this.parentElement.parentElement.firstChild.textContent;
        var newPassword=prompt("请输入新的密码：");
        var newPhoneNumber=prompt("请输入新的手机号：");
        var xhr=new XMLHttpRequest();
        var requestInfor="http://localhost:8080/admin?request=modi&username="+modifyUsername
            +"&newPassword="+newPassword+"&newPhoneNumber="+newPhoneNumber;
        console.log(newPassword+"\t"+newPhoneNumber);
        xhr.open("POST",requestInfor,true);
        xhr.onreadystatechange=function (){
            if(xhr.readyState===4 && xhr.status===200) {
                jsonObj=JSON.parse(xhr.responseText);
                var message=jsonObj.message;
                if(message==='MODIFY SUCCESS'){
                    alert("更改成功！");
                    updateUserInfor();
                }
            }
        }
        xhr.send();

    }

    function appendUser(){
        var newUsername=prompt("请输入新的用戶名：");
        var newPassword=prompt("请输入新的密码：");
        var newPhoneNumber=prompt("请输入新的手机号：");

        var xhr=new XMLHttpRequest();
        var xhrInfor="http://localhost:8080/admin?request=append&username="+newUsername
            +"&newPassword="+newPassword+"&newPhoneNumber="+newPhoneNumber;
        xhr.open("POST",xhrInfor,true);
        xhr.onreadystatechange=function(){
            if(xhr.readyState===4 && xhr.status===200) {
                jsonObj=JSON.parse(xhr.responseText);
                var message=jsonObj.message;
                if(message==="PHONE ALREADY EXISTED"){
                    alert("该手机号已存在！");
                }else if(message==="USERNAME ALREADY EXISTED"){
                    alert("该用户名已经存在！");
                }else if(message==="APPEND SUCCESS"){
                    alert("用户新增成功！");
                    updateUserInfor();
                }
            }
        }
        xhr.send();
    }

    function checkUser() {
        var username = prompt("请输入需要查询的用户名：");
        var xhr = new XMLHttpRequest();
        var xhrInfor = "http://localhost:8080/admin?request=check&username=" + username;
        xhr.open("POST", xhrInfor, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                jsonObj = JSON.parse(xhr.responseText);
                var message=jsonObj.message;
                if(message==="NO SUCH USER"){
                    alert("输入的用户不存在！");
                }else{
                    var username=jsonObj.username;
                    var password=jsonObj.password;
                    var phoneNumber=jsonObj.phoneNumber;
                    alert("用户名："+username+"\n"+
                            "手机号："+phoneNumber+"\n"+
                            "密码："+password);
                }

            }
        }
        xhr.send();
    }

    function updateUserInfor(){
        document.getElementById("userDisplay").innerHTML="<table id=\"userTable\">\n" +
            "            <tr>\n" +
            "                <th>学号</th>\n" +
            "                <th>密码</th>\n" +
            "                <th>手机号码</th>\n" +
            "                <th>操作</th>\n" +
            "            </tr>\n" +
            "        </table>"
        var xhr=new XMLHttpRequest();
        var jsonObj
        var requestInfor="http://localhost:8080/admin?request=userList";
        xhr.open('POST',requestInfor,true);
        xhr.onreadystatechange=function(){
            if(xhr.readyState===4 && xhr.status===200) {
                jsonObj=JSON.parse(xhr.responseText);
                var jsonLenth=0;
                var key;
                for(key in jsonObj){
                    if (jsonObj.hasOwnProperty(key))
                        jsonLenth++;
                }
                for (var i=0;i<jsonLenth;i++){
                    var tr=document.createElement("tr");
                    var td = document.createElement("td");
                    var modi,del;
                    td.innerText = jsonObj[i].username;
                    tr.appendChild(td);
                    td = document.createElement("td");
                    td.innerText = jsonObj[i].password;
                    tr.appendChild(td);
                    td = document.createElement("td");
                    td.innerText = jsonObj[i].phoneNumber;
                    tr.appendChild(td);
                    td = document.createElement("td");
                    del = document.createElement("a");
                    del.innerText = '删除';
                    del.href='javascript:void(0)';
                    del.onclick = delFunction;
                    modi = document.createElement("a");
                    modi.innerText = '修改';
                    modi.href='javascript:void(0)';
                    modi.onclick=modiFunction;
                    td.appendChild(del);
                    td.appendChild(modi);
                    tr.appendChild(td);
                    document.getElementById("userTable").appendChild(tr);
                }
            }
        }
        xhr.send();
    }


</script>
</html>
