<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta charset='utf-8' />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
  <!-- jquery CDN -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	<!-- calendar 태그 -->
	<div id='calendar'>
	</div>
</div>
  <script>
    $(function(){
    	var calendarEl = document.getElementById('calendar');
    	// new FullCalendar.Calendar(대상 DOM객체, {속성:속성값, 속성2:속성값2..})
    	var list = '${list}';
    	var data = {
    			"cal_id": 1,
    			"group_no": 10,
    			"title": "제목",
    			"writer": 'user004',
    			"content":"응?",
    			"start":"2022-12-07",
    			"end":"2022-12-10",
    			"allday":true,
    	};
        var calendar = new FullCalendar.Calendar(calendarEl, {
          headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
          },
          initialDate: '2022-12-06', // 초기 로딩 날짜.
          navLinks: true, // can click day/week names to navigate views
          selectable: true,
          selectMirror: true,
          // 이벤트명 : function(){} : 각 날짜에 대한 이벤트를 통해 처리할 내용..
          select: function(arg) {
        	  console.log(arg);

            var title = prompt('입력할 일정:');
        // title 값이 있을때, 화면에 calendar.addEvent() json형식으로 일정을 추가
            if (title) {
              calendar.addEvent({
                title: title,
                start: arg.start,
                end: arg.end,
                allDay: arg.allDay,
              })
            }
            calendar.unselect()
          },
          eventClick: function(arg) {
        	  // 있는 일정 클릭시,
        	  console.log("#등록된 일정 클릭#");
        	  console.log(arg.event);
        	  
            if (confirm('Are you sure you want to delete this event?')) {
              arg.event.remove()
            }
          },
          editable: true,
          dayMaxEvents: true, // allow "more" link when too many events
          events:
        	  [data]
          //================ ajax데이터 불러올 부분 =====================//
      });

        calendar.render();
      });
</script>
</body>
</html>