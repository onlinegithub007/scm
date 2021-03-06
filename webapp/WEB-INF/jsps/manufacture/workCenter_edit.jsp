<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="/common/taglib.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Production WorkCenters</title>
		<link href="${global_css_url}scm.css" rel="stylesheet" type="text/css" />
		<link href="${global_css_url}table.css" rel="stylesheet"
			type="text/css" />
		<link href="${global_css_url}tab-view.css" rel="stylesheet"
			type="text/css" />
		<link href="${global_js_url}jquery/themes/base/ui.all.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" language="javascript"
			src="${global_js_url}jquery/jquery.js"></script>
		<script type="text/javascript" language="javascript"
			src="${global_js_url}util/util.js"></script>
		<script src="${global_js_url}jquery/jquery.validate.js?v=1"
			type="text/javascript"></script>
		<script type="text/javascript" src="${global_js_url}tab-view.js"></script>
		<script
			src="${global_js_url}jquery/external/bgiframe/jquery.bgiframe.min.js"
			type="text/javascript"></script>
		<script src="${global_js_url}jquery/ui/ui.core.js"
			type="text/javascript"></script>
		<script src="${global_js_url}jquery/ui/ui.draggable.js"
			type="text/javascript"></script>
		<script src="${global_js_url}jquery/ui/ui.resizable.js"
			type="text/javascript"></script>
		<script src="${global_js_url}jquery/ui/ui.dialog.js"
			type="text/javascript"></script>
		<script type="text/javascript">
			function edit(groupId) {
			   window.location = "work_group!edit.action?id=" + groupId + "&operation_method=view";
			}

			function assign(obj){
				 var centerId=$("#centerId").val();
				 if(!centerId||centerId=="") {
					 centerId = $("#sessWorkCenterId").val();
				 }
			     if(!obj.val()){
			         alert("Please select Product/Service!");
			         obj.focus();
			         return;
			     }
			     var reqUrl = "work_center!assign.action?assignValue="+obj.val()+"&sessWorkCenterId="+centerId;
			     //alert(reqUrl);
			     $.ajax({
			         type:"POST",
			         url: reqUrl,
			         dataType: 'json',
			         success:function(data){
			            // obj.remove($(obj).find(":selected"));
			              $("#listShip").html(data.workCenterAssignedStr);
			         }
			     });
			}
			function unassign(){
				 var centerId=$("#centerId").val();
				 if(!centerId||centerId=="") {
					 centerId = $("#sessWorkCenterId").val();
				 }
			    var checkedObj=$("input[name='assigned']:checked");
			    var checkedIds="";
			    for(i=0;i<checkedObj.length;i++){
			        checkedIds+=$(checkedObj[i]).val()+",";
			    }
			    if(checkedIds==""){
			        alert("Please select the Unassign Product/Service.");
			        return;
			    }
			    var reqUrl = "work_center!unassign.action?assignValue="+checkedIds.substr(0, checkedIds.length-1)+"&sessWorkCenterId="+centerId;
			    $.ajax({
			        type:"POST",
			        url: reqUrl,
			        dataType: 'json',
			        success: function(data){
			            $("#listShip").html(data.workCenterAssignedStr);
			        }

			    });
			    
			}			
				
            $(function() {
            	$("select").each(function(){
         			var changeWidth=false;
         	   		var len = this.offsetWidth;
         	   		if(len!=0) {
        	 	   		this.style.width = 'auto';
        	 	   		if(len<this.offsetWidth) {
        	 	   			changeWidth = true;
        	 	   		}
        	 	   		this.style.width=len+"px";
        	 	   		$(this).mousedown(function(){
        	 	   			if(changeWidth) {
        	 	   				this.style.width = 'auto';
        	 	   			}
        	 	   			});
        	 	   		$(this).blur(function() {this.style.width = len+"px";});
        	 	   		$(this).change(function(){this.style.width = len+"px";});
         	   		}
         	   		
         	   	});
                var flagVal = '${workCenter.defaultFlag}';
                if (flagVal == 'Y') {
                  $("#flag").get(0).checked = true;
                } else {
                  $("#flag").get(0).checked = false;
                }
			    $("#resultTable tr:odd").find("td").addClass("list_td2");
			
			    //复选框绑定: 全选|全不选
			    $("#check_all").click( function() {
			       $(":checkbox").each(function() {
			          this.checked = $("#check_all").get(0).checked;
			       });      
			    });
			    
			    //删除选中的checkbox.
			    $("#check_del").click( function() {   
			        var param = "id=${param.id}"; 
			        //alert($("#resultTable :checkbox:checked").length);
			        if ($("#resultTable :checkbox:checked").length < 1) {
			           alert('Please select one at least!');
					   return;
			        }
			  		if (!confirm('Are you sure to delete?')) {
						return;
					}
					$("#resultTable :checkbox:checked").each(function() {
					   param += "&centerResId=" + $(this).val();
					   var tdObj = $(this).parent();
                       var trObj = tdObj.parent();  
                       if (tdObj.children(":hidden").length >0) {
					     $('<input type="hidden" name="dettachGroupIdList" value="' + $(this).val() + '" />').appendTo($("#workCenter_form"));
					   }
                       trObj.remove();
					});			
					$("#resultTable tr:even").find("td").removeClass("list_td2");
					$("#resultTable tr:odd").find("td").addClass("list_td2");			
			    });//end of $("#check_del").click.

               //验证form的逻辑
			   $('#workCenter_form').validate({
					errorClass:"validate_error",
					highlight: function(element, errorClass) {
						$(element).addClass(errorClass);
				    },
				    unhighlight: function(element, errorClass, validClass) {
				        $(element).removeClass(errorClass);
				    },
					invalidHandler: function(form, validator) {
						 $.each(validator.invalid, function(key,value){
				            alert(value);
				            $(this).find("name=[" + key + "]").focus();
				            return false;
				        });
					 },
					 rules: {
						 "workCenter.name": { required:true}
					 },
					 messages: {
						 "workCenter.name": { required : "Please enter the name !" }
					 },
					 errorPlacement: function(error, element) {
					 }
				});

                //绑定保存按钮事件.
                $("#save_btn").click (function() {
                   if (! $('#workCenter_form').valid()) {
                      return false;
                   }
                   var formStr = $('#workCenter_form').serialize();
                   if (! $("#flag").get(0).checked) {
                       formStr += "&workCenter.defaultFlag=N";
                   }
                   frames["resource_list_frame"].$("#resultTable :checkbox").each(function() {
                       formStr += "&groupIdList=" + $(this).val();
                   });
                   $('#save_btn').attr("disabled", true);
                   $.ajax({
						type: "POST",
						url: "work_center!save.action",
						data: formStr,
						dataType: 'json',
						success: function(data, textStatus){
							if(hasException(data)){//有错误信息.
				 	           $('#save_btn').attr("disabled", false);				
							}else{                              
							  alert(data.message);
							  $('#save_btn').attr("disabled", false);
							  window.location.reload();
							 // window.location = "work_center!search.action";
							  //window.history.go(-1);
							}
						},
						error: function(xhr, textStatus){
						   alert("failure");
				 	       $('#save_btn').attr("disabled", false);
						   return;
						}
					});
                
                });//end of {$("#save_btn").click};            
                
            	$('#sel_res_dlg').dialog({
					autoOpen: false,
					height: 440,
					width: 700,
					modal: true,
					bgiframe: true,
					buttons: {
					}
				});
				
                $("#new_res_btn").click( function() {
					$('#sel_res_dlg').dialog("option", "open", function() {	
	              		 var htmlStr = '<iframe src="work_group!selectForCenter.action?centerId=${workCenter.id}" height="100%" width="680" scrolling="no" style="border:0px" frameborder="0"></iframe>';
				         $('#sel_res_dlg').html(htmlStr);
					});
					$('#sel_res_dlg').dialog('open');
                });
            	$('#userChoiceDialog').dialog({
            		autoOpen: false,
            		height: 440,
            		width: 700,
            		modal: true,
            		bgiframe: true,
            		buttons: {
            		}
            	}); 
                             
            
            });
          //choice user
            function userSelect() {
            	$('#userChoiceDialog').dialog("option", "open", function() {	
             		 var htmlStr = '<iframe src="work_group!selectUser.action" id="workGroupAddFrame"  height="100%" width="680" scrolling="no" style="border:0px" frameborder="0"></iframe>';
             		$('#userChoiceDialog').html(htmlStr);
            	});
            	$('#userChoiceDialog').dialog('open');
            }
          
          //type change
          function typeChange() {
        	  var type=$("#type").val();
        	  $.ajax({
					type: "POST",
					url: "work_center!typeChange.action",
					data: "type="+type,
					dataType: 'json',
					success: function(data, textStatus){
						$("#ps_sel").empty();
						 $.each(data.producatServiceMap,function(name,value) {
							 var option2 = "<option value='"+name+"'>"+value+"</option>";
				        		$("#ps_sel").append(option2);
					        });
					},
					error: function(xhr, textStatus){
					   alert("failure");
					   return;
					}
				});
          }
        </script>
	</head>
	<body class="content">
		<div class="scm">
			<div class="title_content">
				<div class="title">
					${workCenter.name} Center
				</div>
			</div>
			<div class="input_box">
				<div class="content_box">
					<form method="get" id="workCenter_form" class="niceform">
						<input type="hidden" name="workCenter.id" value="${workCenter.id}" />                        
						<table border="0" cellpadding="0" cellspacing="0"
							class="General_table">
							<tr>
								<th width="160">
									Work Center Name
								</th>
								<td>
									<input name="workCenter.name" value="${workCenter.name}"
										type="text" class="NFText" size="76" />
								</td>
								<th width="150">
									Status
								</th>
								<td>
									<s:select list="{'ACTIVE', 'INACTIVE'}"
										value="workCenter.status" name="workCenter.status"></s:select>
								</td>
							</tr>
							<tr>
								<th valign="top">
									Description
								</th>
								<td>
									<input name="workCenter.description" type="text"
										value="${workCenter.description}" class="NFText" size="76" />
								</td>
								<th>
									
								</th>
								<td>
									<input type="checkbox" id="flag" name="workCenter.defaultFlag" value="Y" /><label for="flag">Set as Default</label> 
								</td>
							</tr>
							<tr>
								<th>
									Supervisor
								</th>
								<td>
									<input name="workCenter.superName" value="${workCenter.superName}" id="superName" type="text" class="NFText" size="25" readonly="readonly"/>
					<s:hidden name="workCenter.supervisor" id="supervisor"></s:hidden>
					<a href="#" onclick="userSelect()"><img id="org_1Trigger" src="images/search.gif" width="16" height="16" align="absmiddle" /></a>
								</td>
								<th>
									Storage Warehouse
								</th>
								<td>
									<s:select id="warehouse_sel" name="workCenter.warehouseId"
										list="warehouseList" listKey="warehouseId" listValue="name"
										value="workCenter.warehouseId"></s:select>
								</td>
							</tr>
							<tr>
								<th>
									Comment
								</th>
								<td>
									<textarea name="workCenter.comment" class="content_textarea2">${workCenter.comment}</textarea>
								</td>
								<td>
									&nbsp;
								</td>
								<td>
									&nbsp;
								</td>
							</tr>
							<tr>
								<th>
									Modified Date
								</th>
								<td>
									<input name="workCenter.modifyDate" type="text" class="NFText"
										size="20" readonly="readonly"
										value="<s:date name="workCenter.modifyDate" format="yyyy-MM-dd"/>" />
								</td>
								<th>
									Modified By
								</th>
								<td>
									<input name="workCenter.modifyUser" type="text" class="NFText"
										readonly="readonly" size="20" value="${workCenter.modifyUser}" />
								</td>
							</tr>
							<tr>
				                  <th valign="top">&nbsp;</th>
				                  <td colspan="2">&nbsp;</td>
				                  <th>&nbsp;</th>
				                  <td>&nbsp;</td>
                			</tr>
							<tr>
				                  <th valign="top">&nbsp;</th>
				                  <td colspan="2">Product/Service Type to be Processed</td>
				                  <th>&nbsp;</th>
				                  <td>&nbsp;</td>
                			</tr>
                
               				<tr>
               					
				                  <th valign="top">&nbsp;</th>
				                  <td colspan="2">
				                  Type
               					<select id="type" onchange="typeChange();">
               						<option value="product">Product</option>
               						<option value="service">Service</option>
               					</select>
				                  <s:if test="producatServiceMap!=null&&producatServiceMap.size>0">
							          	<s:select id="ps_sel"
							          	  			list="producatServiceMap" 
							          	  			listKey="key"
													listValue="value">
										 </s:select>
					          	 </s:if>
					          	 <s:else>
					          		<select id="ps_sel">
					          			<option value="">Please select...</option>
					          		</select>
					          	 </s:else>
                    
			                    <input type="button" name="Submit33"  class="style_botton" value="Assign" onclick="assign($('#ps_sel'))"/>
			                    <input type="button" name="Submit"  class="style_botton" value="Unassign" onclick="unassign()"/>
			                  </td>
			                  <td>&nbsp;</td>
			                  <td>&nbsp;</td>
                			</tr>
                
			                <tr>
			                  <th>&nbsp;</th>
			                  <td colspan="2">
			                  	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="listShip">
			                      		${workCenterAssignedStr}
			                    </table>
			                  </td>
			                  <th>&nbsp;</th>
			                  <td>&nbsp;</td>
			                </tr>
                
						</table>
						<s:hidden name="workCenter.createdBy"></s:hidden>
						<s:hidden name="workCenter.creationDate"></s:hidden>
						<s:hidden name="workCenter.deptId"></s:hidden>
						<s:hidden name="workCenter.internalCustNo"></s:hidden>
						<s:hidden name="sessWorkCenterId" id="sessWorkCenterId"></s:hidden>
					</form>
				</div>
			</div>
			<div id="dhtmlgoodies_tabView1">
				<div class="dhtmlgoodies_aTab">
					<iframe width="100%" height="310px" id="resource_list_frame" name="resource_list_frame" scrolling="no" frameborder="0" src="work_center!getWorkGroupList.action?id=${id}"></iframe>
				</div>
			</div>
			<div class="button_box">
			<saveButton:saveBtn parameter="${operation_method}"
				disabledBtn='<input type="button" name="Submit123" value="Save" class="search_input" disabled="disabled"/>'
				saveBtn='<input type="button" name="Submit123" value="Save" class="search_input" id="save_btn" />'
			/> 	
				<input type="button" name="Submit124" value="Cancel"
					class="search_input" <s:if test="operation_method=='edit'">
								  onclick="window.location = 'work_center!search.action';";
					  		 </s:if>
							   <s:else> 
								  onclick="window.history.go(-1);"
							  </s:else>/>
			</div>
		</div>
		<div id="sel_res_dlg" title="Select Work Group"></div>
		<div id="userChoiceDialog" title="Select Supervisor"></div>
		<script type="text/javascript"> 
          initTabs('dhtmlgoodies_tabView1',Array('Work Group'),0,998,320);
        </script>
	</body>
</html>