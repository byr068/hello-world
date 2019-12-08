<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>"><!-- jsp文件头和头部 -->
    <%@ include file="../system/admin/top.jsp"%>
</head>
<body>
<form action="taskmag/auditMisson.do" id="Form"   method="post">
<div id="zhongxin">
<table id="table_report" class="table table-striped table-bordered table-hover">
    <tr>
        <td style="width:110px;text-align: right;padding-top: 13px;">任务名称:</td>
        <td style="width:110px;text-align: center;padding-top: 13px;">${pd.mission_name}</td>
        <td style="width:110px;text-align: right;padding-top: 13px;">任务类型:</td>
        <td style="width:110px;text-align: center;padding-top: 13px;">${pd.mission_type}</td>
        <td style="width:110px;text-align: right;padding-top: 13px;"></td>
        <td style="width:110px;text-align: right;padding-top: 13px;"></td>
    </tr>
    <tr>
        <td style="width:110px;text-align: right;padding-top: 13px;">任务级别:</td>
        <td style="width:110px;text-align: center;padding-top: 13px;">${pd.mission_level}</td>
        <td style="width:110px;text-align: right;padding-top: 13px;">任务来源:</td>
        <td style="width:110px;text-align: center;padding-top: 13px;">${pd.mission_source}</td>
        <td style="width:110px;text-align: right;padding-top: 13px;"></td>
        <td style="width:110px;text-align: right;padding-top: 13px;"></td>
    </tr>
    <tr>
        <td style="width:110px;text-align: right;padding-top: 13px;">班组:</td>
        <td style="width:110px;text-align: center;padding-top: 13px;">${pd.team}</td>
        <td style="width:110px;text-align: right;padding-top: 13px;">检修员工:</td>
        <td style="width:110px;text-align: center;padding-top: 13px;">${pd.worker_name}</td>
        <td style="width:110px;text-align: right;padding-top: 13px;">电话:</td>
        <td style="width:110px;text-align: center;padding-top: 13px;">${pd.worker_phone}</td>
    </tr>
    <tr>
        <td style="width:110px;text-align: right;padding-top: 13px;">任务开始时间:</td>
        <td style="width:110px;text-align: center;padding-top: 13px;">${pd.start_time}</td>
        <td style="width:110px;text-align: right;padding-top: 13px;">任务结束时间:</td>
        <td style="width:110px;text-align: center;padding-top: 13px;">${pd.finish_time}</td>
        <td style="width:110px;text-align: right;padding-top: 13px;"></td>
        <td style="width:110px;text-align: right;padding-top: 13px;"></td>
    </tr>

        <input type="hidden" id="missionId" name="missionId" value="${missionId}">
        <table id="t" class="table table-striped table-bordered table-hover">
            <tr>
                <td style="width:110px;text-align: right;padding-top: 13px;">任务审核人:</td>
                <td><input style="width:90%;" type="text" name="auditor" id="auditor" value="${NAME}" size="18" maxlength="200"  title=""></td>
            </tr>
            <tr>
                <td style="width:110px;text-align: right;padding-top: 13px;">审核意见:</td>
                <td>
                    <textarea cols="50" rows="10" name="opinion" id="opinion" placeholder="在这里输入内容..."></textarea>
                </td>
            </tr>
            <tr>
                <td style="width:110px;text-align: right;padding-top: 13px;">审核结果:</td>
                <td>
                    <select class="form-control" name="mission_condition" id="mission_condition" value="">
                        <option value="6">审核通过</option>
                        <option value="7">审核未通过</option>
                    </select>
                </td>
            </tr>
            <tr id="p1">
                <td style="text-align: center;" colspan="10">
                    <a class="btn btn-small btn-primary" onclick="save();">保存</a>
                </td>
            </tr>
            <tr id="p2" hidden="hidden">
                <td style="text-align: center;" colspan="10">
                    <a class="btn btn-small btn-primary" onclick="resend();">保存并重新下发任务</a>
                </td>
            </tr>
        </table>

    <tr>
        <label class="control-label" style="margin-left:45%;margin-top: 5px;margin-bottom: 5px">该任务所包含事件</label>
    </tr>
    <table id="event" class="table table-striped table-bordered table-hover">
        <thead>
        <tr>
           <%-- <th class="center">
                <label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
            </th>--%>
            <th class="center">序号</th>
            <th class="center">所属车间</th>
            <th class="center">经度</th>
            <th class="center">纬度</th>
            <th class="center">事件名称</th>
            <th class="center">具体位置</th>
            <th class="center">查看详情</th>
        </tr>
        </thead>
        <c:choose>
            <c:when test="${not empty varList}">
                <c:if test="${QX.cha == 1 }">
                    <c:forEach items="${varList}" var="var" varStatus="vs">
                        <tr>
                           <%-- <td class='center' style="width: 30px;">
                                <label><input type='checkbox' id="${var.event_id}" name='ids' value="${var.event_id}"/><span class="lbl"></span></label>
                            </td>--%>
                            <td class='center' style="width: 30px;">${vs.index+1}</td>
                            <td style="width: 60px;" class="center"> ${var.workshop}</td>
                            <td style="width: 60px;" class="center">${var.jingdu}</td>
                            <td style="width: 60px;" class="center">${var.weidu}</td>
                            <td style="width: 100px;" class="center">${var.event_name}</td>
                            <td style="width: 60px;" class="center">${var.instrument_place}</td>
                            <td style="width: 60px;" class="center">
                                <a class='btn btn-mini btn-info' title="详情"  onclick="check('${var.event_id}','${missionId}');"><i class='icon-edit'></i></a>
                                <%--<a href="<%=basePath%>taskmag/getWorkContentDetail.do?event_id=${var.event_id}&mission_id=${missionId}">查看详情</a></td>--%>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${QX.cha == 0 }">
                    <tr>
                        <td colspan="100" class="center">您无权查看</td>
                    </tr>
                </c:if>
            </c:when>
            <c:otherwise>
                <tr class="main_info">
                    <td colspan="100" class="center" >没有相关数据</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </table>
    <div class="page-header position-relative">
        <table style="width:100%;">
            <tr>
                <td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
            </tr>
        </table>
    </div>

</table>
</div>
<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
</form>
</body>
</html>
<!-- 引入 -->
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/ace-elements.min.js"></script>
<script src="static/js/ace.min.js"></script>
<script type="text/javascript">
    $(top.hangge());

    $("#mission_condition").change(function(){
        var options = $(this).children("option:selected").val(); //获取选中的项的值
        if(options == "6") {
            $("#p1").removeAttr("hidden");
            $("#p2").attr("hidden","hidden");
        }else if(options == "7"){
            $("#p2").removeAttr("hidden");
            $("#p1").attr("hidden","hidden");
        }
    });
    //重新下发任务
    function resend(){
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            url: "<%=basePath%>taskmag/auditMisson.do" ,//url
            data: $('#Form').serialize(),
            success: function (result) {
                var missionId= $("#missionId").val();
                window.location.href= '<%=basePath%>taskmag/noPass.do?missionId='+missionId
            },
            error : function() {
                alert("出现异常！");
            }
        });
       /* var missionId= $("#missionId").val();
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="下发任务";
        diag.URL = '<%=basePath%>taskmag/noPass.do?missionId='+missionId;
        diag.Width = 700;
        diag.Height = 800;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                /!*if('${page.currentPage}' == '0'){
                    top.jzts();
                    setTimeout("self.location=self.location",100);
                }else{
                    window.location.href='<%=basePath%>taskmag/list.do';
                }*!/

            }
            diag.close();
        };
        diag.show();*/
    }

    function save(){
       $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
     /* $.ajax({
            type: "POST",//方法类型
            url: "<%=basePath%>taskmag/auditMisson.do" ,//url
            data: $('#Form').serialize(),
            success: function (result) {
                //打印服务端返回的数据(调试用)
                alert("任务审核成功！");
               // window.location.href='<%=basePath%>taskmag/list.do';
            },
            error : function() {
                alert("出现异常！");
            }
        });*/
    }

    function check(eventId,id){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="详情";
        diag.URL = "<%=basePath%>taskmag/getWorkContentDetail.do?event_id="+eventId+"&mission_id="+id;
        diag.Width = 850;
        diag.Height = 700;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                if('${page.currentPage}' == '0'){
                    top.jzts();
                    setTimeout("self.location=self.location",100);
                }else{
                    //  nextPage(${page.currentPage});
                }
            }
            diag.close();
        };
        diag.show();
    }
</script>