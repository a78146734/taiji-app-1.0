$('#calendar').calendar({
	// startView:"week",
	// startDate:"2019-8-14",
	// withHeader:false,
	lang:'zh_cn',
	clickEvent: function(event) {
        console.log(event);
		$('.modal1').modal('show');
		$('#yes').click(function(){
			event.event.title = $(this).parents('.modal1').find('input').val();
			console.log(event)
			calendar.display();  
		});
        // console.log("你点击了一个事件");
        // 处理 clickEvent 事件
        // ...
    }
});

var calendar = $('#calendar').data('zui.calendar');
// calendar.display('month','2017.1.12')
// calendar.display()

var newEvent=[
	{
		title:'hello0',
		desc:'hello,javascript',
		start:'2017-1-11 10:00',
		end:'2017-1-11 11:00',
		data:'hhhhh'
	},
	{
		title:'hello1',
		desc:'hello,javascript',
		start:'2017-1-10 10:00',
		end:'2017-1-10 12:00',
		data:'hhhhh'
	},
	{
		title:'hello2',
		desc:'hello,javascript',
		start:'2017-1-12 10:00',
		end:'2017-1-12 12:00',
		data:'hhhhh'
	}
]

calendar.addEvents(newEvent)
calendar.removeEvents('4343');
var newCalendar = {name: 'work', title: '工作', desc: '这是一个工作日历', color: '#ff0000'};
calendar.addCalendars(newCalendar);
/* 获取日历数据 */
var calendars = calendar.calendars; // 获取所有日历对象实例
var events    = calendar.events;    // 获取所有事件对象实例

console.log(calendars)
console.log(events)

$('.btn1').click(function(){
    $('.modal1').modal('show')
})
// $('.calendar').calendar({
    
// });
