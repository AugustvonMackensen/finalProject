<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="now" value="<%=new java.util.Date()%>" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:formatDate var="sysTime" value="${now}" pattern="yyyy-MM-dd" />
<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta charset='utf-8' />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
  <!-- jquery CDN -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <!-- fullcalendar CDN -->
  <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
  <!-- fullcalendar 언어 CDN -->
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<style>
  /* body 스타일 */
  body {
    margin-top: 40px;
    font-size: 14px;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  }
  /* 드래그 박스의 스타일 */
  #external-events {
    position: fixed;
    left: 20px;
    top: 20px;
    width: 100px;
    padding: 0 10px;
    border: 1px solid #ccc;
    background: #eee;
    text-align: left;
  }
  #external-events h4 {
    font-size: 16px;
    margin-top: 0;
    padding-top: 1em;
  }
  #external-events .fc-event {
    margin: 3px 0;
    cursor: move;
  }
 
  #external-events p {
    margin: 1.5em 0;
    font-size: 11px;
    color: #666;
  }
 
  #external-events p input {
    margin: 0;
    vertical-align: middle;
  }
 
  #calendar-wrap {
    margin-left: 200px;
  }
 
  #calendar1 {
    max-width: 1100px;
    margin: 0 auto;
  }
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<div style="background-color: #F7F8F9;">
		<c:import url="/WEB-INF/views/common/somoimsidebar.jsp" />
		<div style="padding: 1px 16px; height: 800px; display: flex; margin-left: 20%; max-width: 1100px;">
			<!-- calendar 태그 -->
			<div id='calendar'>
			</div>
		</div>
</div>
  <script>
    $(function(){
    	var calendarEl = document.getElementById('calendar');
    	var data;
    	var current_data;
    	var group_no = "${gno}";
    	$.ajax({
    		url:"calGetData.do",
    		type:"post",
    		data:{"gno":${gno}},
    		dataType: "json",
    		success: function(dataObj){
    			data = dataObj;
    			cal_open();
    		},
    		error: function(request, status, errorData){
				console.log("error code : " + request.status
						+ "\nMessage : " + request.responseText
						+ "\nError : " + errorData);
			}
    	});
		
    	/* var data={"list":
    						[
    							{"allday":1,"cal_id":1,"start":'2022-12-06',"end":'2022-12-07',
						    		"writer":"user004","title":"타이틀","content":
						    		"내용","group_no":155} ,
					    		{"allday":1,"cal_id":1,"start":'2022-12-08',"end":'2022-12-012',
						    		"writer":"user004","title":"오오","content":
							    		"내용","group_no":155}
					    		]
    				}; */
   	
    function save_db(){
    		console.log(current_data);
    		var job = new Object();
			job.title = current_data["title"];
			job.start = dateToString(current_data["start"]);
			job.end = dateToString(current_data["end"]);
			job.allDaycurrent_data = current_data["allDay"];
			job.group_no = group_no;
			job.cal_writer = "${ loginMember.m_id }";
    		$.ajax({
    			url: "saveCal.do",
    			type:"post",
    			data:JSON.stringify(job),
    			contentType: "application/json; charset=utf-8",
    			success: function(result){
    				console.log(result);
				},
				error: function(request, status, errorData){
					console.log("error code : " + request.status
							+ "\nMessage : " + request.responseText
							+ "\nError : " + errorData);
				}
    		});
    }
    function dateToString(date){
    	var m,d;
    	var h,M,s;
		var y = date.getFullYear().toString();
		if((date.getMonth()+1) < 10){
			m = "0"+date.getMonth()+1;
		}else{
			m = date.getMonth()+1;
		}
		if(date.getDate()<10){
			d = "0"+date.getDate().toString();
		}else{
			d = date.getDate().toString();
		}
		if(date.getHours()<10){
		 h= "0"+date.getHours().toString();
		}else{
			h = date.getHours().toString();
		}
		if(date.getMinutes()<10){
			M = "0"+date.getMinutes().toString();
		}else{
			M = date.getMinutes().toString();
		}
		if(date.getSeconds()<10){
			s= "0" + date.getSeconds().toString();
		}else{
			s= date.getSeconds().toString();
		}
		var str = y+m+d+" "+h+M+s;
		return str;
	}
    function remove_db(){
    	console.log(current_data["cal_id"]);
    	console.log(typeof(current_data["cal_id"]));
    	var job = new Object();
		job.cal_id = String(current_data["cal_id"]);
    	$.ajax({
    		url:"removeCal.do",
    		type:"post",
    		data:JSON.stringify(job),
    		contentType: "application/json; charset=utf-8",
			success: function(result){
				console.log(result);
			},
			error: function(request, status, errorData){
				console.log("error code : " + request.status
						+ "\nMessage : " + request.responseText
						+ "\nError : " + errorData);
			}
    	});
    }
   	function cal_open(){
   		
        var calendar = new FullCalendar.Calendar(calendarEl, {
          headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
          },
          initialDate: "${sysTime}", // 초기 로딩 날짜.
          navLinks: true, // can click day/week names to navigate views
          selectable: true,
          selectMirror: true,
          // 이벤트명 : function(){} : 각 날짜에 대한 이벤트를 통해 처리할 내용..
          select: function(arg) {
        	  console.log(arg);

            var title = prompt('입력할 일정:');
        // title 값이 있을때, 화면에 calendar.addEvent() json형식으로 일정을 추가
            if (title) {
              calendar.addEvent(
            		  current_data = {
                title: title,
                start: arg.start,
                end: arg.end,
                allDay: arg.allDay,
              })
              save_db();
            }
            calendar.unselect()
          },
          eventClick: function(arg) {
        	  // 있는 일정 클릭시,
        	  console.log("#등록된 일정 클릭#");
        	  console.log(arg.event);
        	  
            if (confirm('Are you sure you want to delete this event?')) {
            	current_data = {
            			cal_id : arg.event._def["extendedProps"]["cal_id"]
            	};
            	remove_db();
              arg.event.remove()
            }
          },
          editable: true,
          dayMaxEvents: true, // allow "more" link when too many events
          events:
          data["list"],
          //================ ajax데이터 불러올 부분 =====================//
      });
        calendar.render();
    	}
});
</script>
</body>
</html>