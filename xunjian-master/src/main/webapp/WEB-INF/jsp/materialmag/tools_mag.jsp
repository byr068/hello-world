<%--
  Created by IntelliJ IDEA.
  User: wp
  Date: 2018/3/28
  Time: 9:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
</body>
<div class="container-fluid" id="main-container">
    <div id="page-content" class="clearfix">
        <div class="row-fluid">
            <!-- 检索  -->
            <form action="toolsmag/list.do" method="post" name="Form" id="Form">
                <table>
                    <tr>
                        <td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="enquiry" value="${pd.enquiry }" placeholder="这里输入内容" />
							<i id="nav-input-icon" class="icon-search"></i>
						</span>
                        </td>

                       <%-- <td style="vertical-align:top;">
                            <select class="chzn-select" name="description" id="description" data-placeholder="请选择工具类型" style="vertical-align:top;width: 120px;">
                                <option value="">全部</option>
                                <option value="扳手" >扳手</option>
                                <option value="测量计">测量计</option>
                                <option value="绳索">绳索</option>
                                <option value="螺丝刀">螺丝刀</option>
                            </select>
                        </td>--%>
                        <c:if test="${QX.cha == 1 }">
                            <td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();"  title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
                            <%-- <c:if test="${QX.edit == 1 }">
                                 <td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="fromExcel();" title="从EXCEL导入"><i id="nav-search-icon" class="icon-cloud-upload"></i></a></td>
                                 <td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td>
                             </c:if>--%>
                        </c:if>
                    </tr>
                </table>
                <%--检索--%>
                <table id="table_report" class="table table-striped table-bordered table-hover">

                    <thead>
                    <tr>
                       <%-- <th class="center">
                            <label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
                        </th>--%>
                        <th class="center">序号</th>
                        <th class="center">工具类别</th>
                        <th class="center">工具编号</th>
                        <th class="center">工具名称</th>
                        <th class="center">当前库存</th>
                        <th class="center">操作</th>
                    </tr>
                    </thead>

                    <tbody>

                    <!-- 开始循环 -->
                    <c:choose>
                        <c:when test="${not empty varList}">
                            <c:if test="${QX.cha == 1 }">
                                <c:forEach items="${varList}" var="var" varStatus="vs">
                                    <tr>
                                       <%-- <td class='center' style="width: 30px;">
                                            <label><input type='checkbox' name='ids' value="${var.material_id}" /><span class="lbl"></span></label>
                                        </td>--%>
                                        <td class='center' style="width: 30px;">${vs.index+1}</td>
                                        <td style="width: 60px;" class="center">${var.description}</td>
                                        <td style="width: 60px;" class="center">${var.material_id}</td>
                                        <td style="width: 60px;" class="center">${var.name}</td>
                                        <td style="width: 60px;" class="center">${var.stock}</td>
                                        <td style="width: 30px;" class="center">
                                            <div class='hidden-phone visible-desktop btn-group'>

                                                <c:if test="${QX.cha == 1 }">
                                                    <c:if test="${user.USERNAME != 'admin'}"><a class='btn btn-mini btn-info' title="出库" onclick="output('${var.material_id }');"><i class='icon-edit'></i></a></c:if>
                                                    <c:if test="${user.USERNAME == 'admin'}"><a class='btn btn-mini btn-info' title="您不能查看"><i class='icon-edit'></i></a></c:if>
                                                </c:if>
                                                &nbsp;&nbsp;&nbsp;
                                                <c:if test="${QX.cha == 1 }">
                                                    <c:if test="${user.USERNAME != 'admin'}"><a class='btn btn-mini btn-success' title="入库" onclick="input('${var.material_id}');"  data-placement="left"><i class="icon-edit"></i> </a></c:if>
                                                    <c:if test="${user.USERNAME == 'admin'}"><a class='btn btn-mini btn-success' title="您不能查看"><i class='icon-edit'></i></a></c:if>
                                                </c:if>
                                                &nbsp;&nbsp;&nbsp;
                                                <c:if test="${QX.del == 1 }">
                                                    <c:if test="${user.USERNAME != 'admin'}"><a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.material_id}');"  data-placement="left"><i class="icon-trash"></i> </a></c:if>
                                                    <c:if test="${user.USERNAME == 'admin'}"><a class='btn btn-mini btn-danger' title="您不能编辑"><i class='icon-trash'></i></a></c:if>
                                                </c:if>

                                            </div>
                                        </td>
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
                    </tbody>
                </table>
                <div class="page-header position-relative">
                    <table style="width:100%;">
                        <tr>
                            <td style="vertical-align:top;">
                                <c:if test="${QX.add == 1 }">
                                    <a class="btn btn-small btn-success" onclick="add();">新增</a>
                                </c:if>

                              <%--  <c:if test="${QX.del == 1 }">
                                    <a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='icon-trash'></i></a>
                                </c:if>--%>
                            </td>
                            <td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
                        </tr>
                    </table>
                </div>

            </form>
            <%--<table id="mission_msg"></table>--%>
        </div>
    </div>
</div>
<!-- 返回顶部  -->
<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
    <i class="icon-double-angle-up icon-only"></i>
</a>
<!-- 引入 -->
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/ace-elements.min.js"></script>
<script src="static/js/ace.min.js"></script>

<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
<!-- 引入 -->
<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
<%--引入house_msg--%>
<script type="text/javascript" src="static/js/myjs/mission_msg.js"></script>
<script type="text/javascript">
    $(top.hangge());

    //检索
    function search(){
        top.jzts();
        $("#Form").submit();
    }

    //删除
    function del(Id){
        bootbox.confirm("确定要删除吗?", function(result) {
            if(result) {
                top.jzts();
                var url = "<%=basePath%>partsmag/delete.do?material_id="+Id;
                $.get(url,function(data){
                    nextPage(${page.currentPage});
                });
            }
        });
    }
    //出库记录
    function output(Id){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="出库记录";
        diag.URL = '<%=basePath%>toolsmag/goOutput.do?material_id='+Id;
        diag.Width = 700;
        diag.Height = 500;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                if('${page.currentPage}' == '0'){
                    top.jzts();
                    setTimeout("self.location=self.location",100);
                }else{
                    nextPage(${page.currentPage});
                }
            }
            diag.close();
        };
        diag.show();
    }
    //入库记录
    function input(Id){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="入库记录";
        diag.URL = '<%=basePath%>toolsmag/goInput.do?material_id='+Id;
        diag.Width = 700;
        diag.Height = 500;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                if('${page.currentPage}' == '0'){
                    top.jzts();
                    setTimeout("self.location=self.location",100);
                }else{
                    nextPage(${page.currentPage});
                }
            }
            diag.close();
        };
        diag.show();
    }

    //入库
    function add(){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="新增";
        diag.URL = '<%=basePath%>toolsmag/goNewAdd.do';
        diag.Width = 400;
        diag.Height = 400;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                if('${page.currentPage}' == '0'){
                    top.jzts();
                    setTimeout("self.location=self.location",100);
                }else{
                    nextPage(${page.currentPage});
                }
            }
            diag.close();
        };
        diag.show();
    }

    $(function() {
        //下拉框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect:true});

        //日期框
        $('.date-picker').datepicker();

        //复选框
        $('table th input:checkbox').on('click' , function(){
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox')
                .each(function(){
                    this.checked = that.checked;
                    $(this).closest('tr').toggleClass('selected');
                });
        });
    });

    //批量操作
    function makeAll(msg){
        bootbox.confirm(msg, function(result) {
            if(result) {
                var str = '';
                for(var i=0;i < document.getElementsByName('ids').length;i++)
                {
                    if(document.getElementsByName('ids')[i].checked){
                        if(str=='') str += document.getElementsByName('ids')[i].value;
                        else str += ',' + document.getElementsByName('ids')[i].value;
                    }
                }
                if(str==''){
                    bootbox.dialog("您没有选择任何内容!",
                        [
                            {
                                "label" : "关闭",
                                "class" : "btn-small btn-success",
                                "callback": function() {
                                    //Example.show("great success");
                                }
                            }
                        ]
                    );

                    $("#zcheckbox").tips({
                        side:3,
                        msg:'点这里全选',
                        bg:'#AE81FF',
                        time:8
                    });

                    return;
                }else{
                    if(msg == '确定要删除选中的数据吗?'){
                        top.jzts();
                        $.ajax({
                            type: "POST",
                            url: '<%=basePath%>toolsmag/deleteAll.do?tm='+new Date().getTime(),
                            data: {ids:str},
                            dataType:'json',
                            //beforeSend: validateData,
                            cache: false,
                            success: function(data){
                                $.each(data.list, function(i, list){
                                    nextPage(${page.currentPage});
                                });
                            }
                        });
                    }
                }
            }
        });
    }


</script>
</body>
</html>

