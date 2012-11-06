<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
    $(function(){
    	$('#dialog_arrangedStaffNames').manifest({
    		// Use each location's full name as the display text.
    		formatDisplay: function (data, $item, $mpItem) {
    			return data.empName;
    		},
    		// Use each location's ID as the value to be submitted.
    		formatValue: function (data, $value, $item, $mpItem) {
    			return data.id;
    		},
    		valuesName: 'empid',
    		values:${staffNames ne null ? staffNames:'[]'}
    	});
    });
</script>
		<input name="staffNames" id="dialog_arrangedStaffNames" style="width:100%"/>
