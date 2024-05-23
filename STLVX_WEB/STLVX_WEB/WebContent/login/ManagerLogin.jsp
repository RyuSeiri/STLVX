<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>后台管理系统登录</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<script type="text/javascript" src="/STLVX_WEB/js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="/STLVX_WEB/js/login.js"></script>
<script type="text/javascript" >
var globalBasePath = "<%=basePath%>";
</script>
<script language="javascript">
function reloadcode(){
	document.getElementById("codeImg").src="<%=basePath%>ValidateCode.do?method=getValidateCode&time="+new Date();
	}
</script>
<STYLE>
TD {
	FONT-SIZE: 11px; COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serIf;
}
.input_1{
	width:100px;BORDER-RIGHT: #999999 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #999999 1px solid; PADDING-LEFT: 2px; LIST-STYLE-POSITION: inside; FONT-SIZE: 12px; PADDING-BOTTOM: 2px; MARGIN-LEFT: 10px; BORDER-LEFT: #999999 1px solid; COLOR: #333333; PADDING-TOP: 2px; BORDER-BOTTOM: #999999 1px solid; FONT-FAMILY: Arial, Helvetica, sans-serIf; LIST-STYLE-TYPE: none; HEIGHT: 18px;
}
</STYLE>
</HEAD>
<BODY>
<TABLE cellSpacing=0 cellPadding=0 width=651 align=center border=0>
  <TBODY>
  <TR>
    <TD height=50></TD>
  </TR>
  <TR>
    <TD height=351 width="100%"><TABLE cellSpacing=0 cellPadding=0 width="100%" border='0'>
        <TR>
          <TD width=15 background=/STLVX_WEB/login/images/ileft.gif height=43></TD>
          <TD width=620 background=/STLVX_WEB/login/images/i_topbg2.gif><IMG 
            height=43 src="/STLVX_WEB/login/images/i_top1.gif" width=43>
          </TD>
          <TD width=16><IMG height=43 src="/STLVX_WEB/login/images/iright.gif" 
            width=16></TD>
        </TR>
        <TR>
          <TD background=/STLVX_WEB/login/images/ileftbg.gif></TD>
          <TD align="center" background="/STLVX_WEB/login/images/bg.gif" height="279" width="100%">
          <TABLE height=109 cellSpacing=0 cellPadding=0 width=369 align=center 
           border=0>
              <TR style="padding: 1px">
                <TD width=155><IMG height='145' width="160" src="/STLVX_WEB/login/images/shoolLog.png" width=155  border=0>
                 </TD>
                <TD vAlign=top align=left width="100%">
                <TABLE cellSpacing=0 cellPadding=0 width='280' border=0>
                    <TR>
                      <TD vAlign=bottom  height=30 align="center">
                      <b style="font-size: 20px;font-weight: bold;">生态旅游后台管理系统</b>
                      </TD>
                    </TR>
                    <TR >
                      <TD height=123 >
                       <form id="loginform" name="form" action="" method="post">
                        	 <span style="margin: 10px 0 0 0">用户名: <input class="input_1" id="username" size=15 name="username"></span><b id="msg" style="color: red">${message}</b><br>
                             <span style="top:10px">密&nbsp;&nbsp; 码: <input class="input_1" id="password" type="password" size=15 name="password"></span><br>
                             <span > 验证码: <input class="input_1" type="text"   size=15 id="code" name="code"></span>&nbsp;<img  src="<%=basePath%>ValidateCode.do?method=getValidateCode&time='"+new Date()+"'" id="codeImg" alt="点击换一张" style="cursor: hand;width: 68px;height: 16px;bottom: -10px" onclick="reloadcode()" >
                        </form>
                            <DIV style="margin: 15px 0 0 30px">
                             <img    src="/STLVX_WEB/login/images/b_login.gif" id="submit" style="CURSOR: pointer;" onclick="login(globalBasePath)" />
                              <IMG style="CURSOR: pointer;" onclick=document.form.reset(); height=21  src="/STLVX_WEB/login/images/b_clean.gif" width=73> 
                             </DIV>
                        
                        </TD>
                    </TR>
                  </TABLE>
                  </TD>
              </TR>
            </TABLE>
            </TD>
          <TD background=/STLVX_WEB/login/images/irightbg.gif></TD>
        </TR>
        <TR>
          <TD><IMG height=29 src="/STLVX_WEB/login/images/i_bottom_left.gif" 
            width=15></TD>
          <TD background=/STLVX_WEB/login/images/i_bottom_bg.gif></TD>
          <TD width=16><IMG height=29 
            src="/STLVX_WEB/login/images/i_bottom_right.gif" width=16></TD>
        </TR>
      </TABLE></TD>
  </TR>
  <TR>
    <TD height=1></TD>
  </TR>
  <TR>
  </TR>
  </TBODY>
</TABLE>
<div style="text-align:center;">
</div>
</BODY>
</HTML>