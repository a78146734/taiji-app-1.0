function T2C() {
	// 按照行\列 line column
	this.ranks = "line";
	// 图表类型 list line bar pie
	this.chartType = "list";
	this.firstInit = false;
	// 图表对象
	this.myChart = echarts.init(document.getElementById('chart'));
}
T2C.prototype.init = function(data) {
	this.chartType = "list";
	this.ranks = "line";
	$('input[name="tuname"]').each(function() {
		if ($(this).val() == 'line') {
			$(this).prop("checked", "checked");
		}
	});
	$("#initIndexCharts").hide();
	t2c = false;
	this.createTable(data);
	this.hideCheckbox(true);
	this.updateChart();
	this.addListen();
}

T2C.prototype.createTable = function(data) {
	var tableHtml = '<tr><th style="width:300px"><strong>指标</strong></th><th class="checkbox-y">&nbsp;</th>';
	for (var i = 0; i < data[data.length - 1].value.length; i++) {
		tableHtml += '<th style="width:160px"><strong>'
				+ data[data.length - 1].value[i] + '</strong></th>';
	}
	tableHtml += '</tr><tr class="checkbox-x"><th></th><th></th>';
	for (var i = 0; i < data[data.length - 1].value.length; i++) {
		tableHtml += '<th><input type="checkbox"></th>';
	}
	tableHtml += '</tr>';
	$("#th").html(tableHtml);
	tableHtml = '';
	for (var i = 0; i < data.length - 1; i++) {
		var key = data[i].key;
		tableHtml += '<tr><td class="white-space:nowrap;">' + key
				+ '</td><td class="checkbox-y"><input type="checkbox"></td>';
		for (var ii = 0; ii < data[i].value.length; ii++) {
			tableHtml += '<td>' + data[i].value[ii] + '</td>';
		}
		tableHtml += '</tr>';
	}
	$("#tb").html(tableHtml);
}

T2C.prototype.addListen = function() {
	var t2c = this;
	$(".drawTu").find("a").click(function() {
		var type = $(this).attr('class');
		t2c.changeChart(type);
	});
	$('input[name="tuname"]').click(function() {
		t2c.ranks = $(this).val();
		t2c.changeChart(t2c.chartType);
	});

	$(".checkbox-x").find("input[type='checkbox']").click(function() {
		if (t2c.ranks == 'column' && t2c.chartType == 'pie') {
			if ($(this).is(':checked')) {
				t2c.changeCheckboxX(false);
				$(this).prop("checked", "checked");
			}
		}
		t2c.updateChart();
	});
	$(".checkbox-y").find("input[type='checkbox']").click(function() {
		if (t2c.ranks == 'line' && t2c.chartType == 'pie') {
			if ($(this).is(':checked')) {
				t2c.changeCheckboxY(false);
				$(this).prop("checked", "checked");
			}
		}
		t2c.updateChart();
	});
}
T2C.prototype.changeChart = function(type) {
	var t2c = this;
	if (type == 'list') {
		t2c.hideCheckbox(true);
		$("#initIndexCharts").hide();
	} else {
		t2c.hideCheckbox(false);
		$("#initIndexCharts").show();
	}

	if (!t2c.firstInit) {
		t2c.firstInit = true;
		if (t2c.ranks == 'line') {
			t2c.changeCheckboxX(true);
			t2c.changeCheckboxY(false)
			$(".checkbox-y").find("input[type='checkbox']").first().prop(
					"checked", "checked");
		} else if (t2c.ranks == 'column') {
			t2c.changeCheckboxX(false);
			t2c.changeCheckboxY(true)
			$(".checkbox-x").find("input[type='checkbox']").first().prop(
					"checked", "checked");
		}
	}
	if (t2c.ranks == 'line' && type == 'pie') {
		t2c.changeCheckboxX(true);
		t2c.changeCheckboxY(false)
		$(".checkbox-y").find("input[type='checkbox']").first().prop("checked",
				"checked");
	} else if (t2c.ranks == 'column' && type == 'pie') {
		t2c.changeCheckboxX(false);
		t2c.changeCheckboxY(true)
		$(".checkbox-x").find("input[type='checkbox']").first().prop("checked",
				"checked");
	}
	t2c.chartType = type;
	t2c.updateChart();
}

T2C.prototype.updateChart = function() {
	var t2c = this;
	var option;
	if (t2c.chartType == 'line') {
		option = t2c.lineChartPption();
	} else if (t2c.chartType == 'bar') {
		option = t2c.barChartPption();
	} else if (t2c.chartType == 'pie') {
		option = t2c.pieChartPption();
	}
	t2c.myChart.clear();
	if (option != null) {
		t2c.myChart.setOption(option);
	}
}

T2C.prototype.lineChartPption = function() {
	var t2c = this;
	var xAxisData = new Array();
	var xAxisIndex = new Array();
	var table = $("#table").find("tr");
	var firstTr = table.first();
	var seriesData = new Array();
	var legendData = new Array();
	if (t2c.ranks == 'line') {
		$(".checkbox-x").find("input[type='checkbox']")
				.each(
						function() {
							if ($(this).is(':checked')) {
								var th = $(this).parents("th");
								var index = $(th).parents("tr").find("th")
										.index($(th));
								xAxisData.push($(firstTr.find("th").get(index))
										.find("strong").first().text());
								xAxisIndex.push(index);
							}
						});
		xAxisData.reverse();
		xAxisIndex.reverse();
		$(".checkbox-y").find("input[type='checkbox']").each(
				function() {
					if ($(this).is(':checked')) {
						var tr = $(this).parents("tr");
						var index = $(tr).parents("table").find("tr").index(
								$(tr));
						var yItemData = new Array();
						for (var i = 0; i < xAxisIndex.length; i++) {
							yItemData.push($(table.get(index)).find("td").get(
									xAxisIndex[i]).innerHTML);
						}
						var legendName = $(table.get(index)).find("td").first()
								.text();
						legendData.push(legendName)
						seriesData.push({
							name : legendName,
							type : 'line',
							data : yItemData
						});
					}
				});

	} else {
		$(".checkbox-y").find("input[type='checkbox']")
				.each(
						function() {
							if ($(this).is(':checked')) {
								var tr = $(this).parents("tr");
								var index = $(tr).parents("table").find("tr")
										.index($(tr));
								xAxisData.push($(table.get(index)).find("td")
										.get(0).innerHTML);
								xAxisIndex.push(index);
							}
						});
		$(".checkbox-x").find("input[type='checkbox']")
				.each(
						function() {
							if ($(this).is(':checked')) {
								var th = $(this).parents("th");
								var index = $(th).parents("tr").find("th")
										.index($(th));
								var yItemData = new Array();
								for (var i = 0; i < xAxisIndex.length; i++) {
									yItemData.push($(table.get(xAxisIndex[i]))
											.find("td").get(index).innerHTML);
								}
								var legendName = $(table.get(0)).find("th")
										.get(index).innerText;
								legendData.push(legendName)
								seriesData.push({
									name : legendName,
									type : 'line',
									data : yItemData
								});
							}
						});
	}

	var option = {
		tooltip : {
			trigger : 'axis'
		},
		legend : {
			y : 'bottom',
			data : legendData
		},
		calculable : true,
		xAxis : [ {
			data : xAxisData
		} ],
		yAxis : [ {
			type : 'value',
			axisLabel : {
				formatter : '{value} '
			}
		} ],
		series : seriesData
	};
	return option;
}

T2C.prototype.barChartPption = function() {
	var t2c = this;
	var xAxisData = new Array();
	var xAxisIndex = new Array();
	var table = $("#table").find("tr");
	var firstTr = table.first();
	var seriesData = new Array();
	var legendData = new Array();
	if (t2c.ranks == 'line') {
		$(".checkbox-x").find("input[type='checkbox']")
				.each(
						function() {
							if ($(this).is(':checked')) {
								var th = $(this).parents("th");
								var index = $(th).parents("tr").find("th")
										.index($(th));
								xAxisData.push($(firstTr.find("th").get(index))
										.find("strong").first().text());
								xAxisIndex.push(index);
							}
						});
		xAxisData.reverse();
		xAxisIndex.reverse();
		$(".checkbox-y").find("input[type='checkbox']").each(
				function() {
					if ($(this).is(':checked')) {
						var tr = $(this).parents("tr");
						var index = $(tr).parents("table").find("tr").index(
								$(tr));
						var yItemData = new Array();
						for (var i = 0; i < xAxisIndex.length; i++) {
							yItemData.push($(table.get(index)).find("td").get(
									xAxisIndex[i]).innerHTML);
						}
						var legendName = $(table.get(index)).find("td").first()
								.text();
						legendData.push(legendName)
						seriesData.push({
							name : legendName,
							type : 'bar',
							data : yItemData
						});
					}
				});
	} else {
		$(".checkbox-y").find("input[type='checkbox']")
				.each(
						function() {
							if ($(this).is(':checked')) {
								var tr = $(this).parents("tr");
								var index = $(tr).parents("table").find("tr")
										.index($(tr));
								xAxisData.push($(table.get(index)).find("td")
										.get(0).innerHTML);
								xAxisIndex.push(index);
							}
						});
		$(".checkbox-x").find("input[type='checkbox']")
				.each(
						function() {
							if ($(this).is(':checked')) {
								var th = $(this).parents("th");
								var index = $(th).parents("tr").find("th")
										.index($(th));
								var yItemData = new Array();
								for (var i = 0; i < xAxisIndex.length; i++) {
									yItemData.push($(table.get(xAxisIndex[i]))
											.find("td").get(index).innerHTML);
								}
								var legendName = $(table.get(0)).find("th")
										.get(index).innerText;
								legendData.push(legendName)
								seriesData.push({
									name : legendName,
									type : 'bar',
									data : yItemData
								});
							}
						});
	}
	var option = {
		tooltip : {
			trigger : 'axis'
		},
		legend : {
			y : 'bottom',
			data : legendData
		},
		calculable : true,
		xAxis : [ {
			data : xAxisData
		} ],
		yAxis : [ {
			type : 'value',
			axisLabel : {
				formatter : '{value} '
			}
		} ],
		series : seriesData
	};
	return option;
}

T2C.prototype.pieChartPption = function() {
	var table = $("#table").find("tr");
	var firstTr = table.first();
	var xAxisData = new Array();
	var xAxisIndex = new Array();
	var seriesData = new Array();
	var legendData = new Array();
	if (this.ranks == 'line') {
		$(".checkbox-x").find("input[type='checkbox']")
				.each(
						function() {
							if ($(this).is(':checked')) {
								var th = $(this).parents("th");
								var index = $(th).parents("tr").find("th")
										.index($(th));
								xAxisData.push($(firstTr.find("th").get(index))
										.find("strong").first().text());
								xAxisIndex.push(index);
							}
						});
		$(".checkbox-y").find("input[type='checkbox']").each(
				function() {
					if ($(this).is(':checked')) {
						var tr = $(this).parents("tr");
						var index = $(tr).parents("table").find("tr").index(
								$(tr));
						for (var i = 0; i < xAxisIndex.length; i++) {
							legendData.push(xAxisData[i]);
							seriesData.push({
								name : xAxisData[i],
								value : $(table.get(index)).find("td").get(
										xAxisIndex[i]).innerHTML
							});
						}
						return false;
					}
				});
	} else {
		$(".checkbox-y").find("input[type='checkbox']")
				.each(
						function() {
							if ($(this).is(':checked')) {
								var tr = $(this).parents("tr");
								var index = $(tr).parents("table").find("tr")
										.index($(tr));
								xAxisData.push($(table.get(index)).find("td")
										.get(0).innerHTML);
								xAxisIndex.push(index);
							}
						});
		$(".checkbox-x")
				.find("input[type='checkbox']")
				.each(
						function() {
							if ($(this).is(':checked')) {
								var th = $(this).parents("th");
								var index = $(th).parents("tr").find("th")
										.index($(th));
								for (var i = 0; i < xAxisIndex.length; i++) {
									legendData.push(xAxisData[i]);
									var th = $(this).parents("th");
									seriesData
											.push({
												name : xAxisData[i],
												value : $(
														table
																.get(xAxisIndex[i]))
														.find("td").get(index).innerHTML,
												showLegendSymbol : true
											});
								}
								return false;
							}
						});
	}
	// xAxisData.reverse();
	// xAxisIndex.reverse();
	var option = {
		tooltip : {
			trigger : 'item',
			formatter : "{a} <br/>{b} : {c} ({d}%)"
		},
		series : [ {
			type : 'pie',
			data : seriesData
		} ]
	};
	return option;
}

T2C.prototype.hideCheckboxX = function(isHide) {
	if (isHide) {
		$(".checkbox-x").hide();
	} else {
		$(".checkbox-x").show();
	}
}

T2C.prototype.hideCheckboxY = function(isHide) {
	if (isHide) {
		$(".checkbox-y").hide();
	} else {
		$(".checkbox-y").show();
	}
}

T2C.prototype.hideCheckbox = function(isHide) {
	this.hideCheckboxY(isHide);
	this.hideCheckboxX(isHide);
}

T2C.prototype.changeCheckboxX = function(checked) {
	if (checked) {
		$(".checkbox-x").find("input[type='checkbox']").prop("checked",
				"checked");
	} else {
		$(".checkbox-x").find("input[type='checkbox']").removeAttr("checked");
	}
}

T2C.prototype.changeCheckboxY = function(checked) {
	if (checked) {
		$(".checkbox-y").find("input[type='checkbox']").prop("checked",
				"checked");
	} else {
		$(".checkbox-y").find("input[type='checkbox']").removeAttr("checked");
	}
}