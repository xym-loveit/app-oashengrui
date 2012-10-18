<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">

$(function(){
	<c:if test="${arragedStaffs ne null}">
	$('#staffs').manifest({
		// Use each location's full name as the display text.
		formatDisplay: function (data, $item, $mpItem) {
			return data.empName;
		},
		// Use each location's ID as the value to be submitted.
		formatValue: function (data, $value, $item, $mpItem) {
			return data.id;
		},
		valuesName: 'empid',
		marcoPolo: {
			url: 'app/base.do?action=lookupEmployeeByName',
			formatItem: function (data) {
			  return '"' + data.empName + '" (' + data.districtName + '-' + data.depName + ')';
			},
			onSelect: function (data, $item){
				var count = $('#attendances_count').val();
				if(count == "" || count == null) count = 0;
				$('#attendances_count').val(1+parseInt(count));
			}, 
			param: 'fullName'
		}
	});
	json =${arragedStaffs} ;
	$('#staffs').manifest("add",json);
	</c:if>
});

</script>
<input id="staffs" type="text" style="width: 90%;height:auto" />