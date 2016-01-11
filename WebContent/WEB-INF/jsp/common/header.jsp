<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%String context_header = request.getContextPath();%>

<div id="common_nav" class="wrapper">
    <div class="container clearfix">

        <div class="cf" id="common_nav_L2">
            <ul>
                
            <c:choose>
                <c:when test="${user == null}">
                    <li>
                        <a class="current" title="登录" href="javascript:void(0)" rel="nofollow" id="login_header">登录</a>
                    </li>
                    <li>
                         <a class="current" title="注册" href="javascript:void(0)" rel="nofollow" id="regist_header">注册</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li>
                        <a class="current" title="退出" href="javascirpt:void(0)" rel="nofollow" id="logout_header">退出</a>
                    </li>
                    <li>
                        <a class="current" title="" href="javascript:void(0)" rel="nofollow">欢迎，${user.name}</a>
                    </li>
                    
                </c:otherwise>
            </c:choose>
                
                <li><a class="current" title="知识中心首页" target="view_window" href="http://www.ckcest.cn" rel="nofollow">知识中心首页</a></li>
                <li><a class="current" title="中草药系统首页" target="view_window"  href="http://zcy.ckcest.cn/tcm/" rel="nofollow">中草药系统首页</a></li>
            </ul>
        </div>

    </div>
</div>