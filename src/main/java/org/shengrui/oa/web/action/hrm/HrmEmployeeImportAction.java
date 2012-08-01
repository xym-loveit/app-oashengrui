package org.shengrui.oa.web.action.hrm;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.shengrui.oa.model.hrm.ModelHrmEmployee;
import org.shengrui.oa.model.hrm.ModelHrmResume;
import org.shengrui.oa.model.system.ModelAppUser;
import org.shengrui.oa.util.ContextUtil;


import cn.trymore.core.util.UtilBean;
import cn.trymore.core.util.UtilDate;
import cn.trymore.core.util.UtilString;
import cn.trymore.core.util.excel.ExcelRowData;
import cn.trymore.core.util.excel.PoiExcelParser;



public class HrmEmployeeImportAction
extends BaseHrmAction
{
	
	/**
	 * The LOGGER
	 */
	private static final Logger LOGGER = Logger.getLogger(HrmEmployeeImportAction.class);
	
	
	public ActionForward actionEmpImport(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response)
	{
		
		return mapping.findForward("employee.page.import");
	}
	
	
	
	public ActionForward actionEmployeeImport(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response)
	{
		String path = request.getParameter("fileUrls");
		PoiExcelParser poiExcelParser = new PoiExcelParser("D:\\ProgramExamples\\Workspaces\\Eclipse\\app-oaShengRui\\src\\main\\web\\uploads\\"+path);
		List<ExcelRowData> excelRowData = poiExcelParser.getRowData(0);
		
		
		for(int i = 3; i <excelRowData.size();i++)
		{
			ModelHrmEmployee employee = new ModelHrmEmployee();
			ModelHrmResume resume = new ModelHrmResume();

			try {
				employee.setEmpName(excelRowData.get(i).getRowData().get(1));
				if(excelRowData.get(i).getRowData().get(1).equals("null"))
				{
					break;
				}
				resume.setFullName(excelRowData.get(i).getRowData().get(1));
				if(this.serviceSchoolDistrict.getDistrictByName(excelRowData.get(i).getRowData().get(2)).equals("null") || this.serviceSchoolDepartment.getDepartmentByName(excelRowData.get(i).getRowData().get(3)).equals("null"))
				{
					return ajaxPrint(response, getErrorCallback("您还没配置校区或部门，请先在系统里配置在导入员工信息！"));
				}
				employee.setEmployeeDistrict(this.serviceSchoolDistrict.getDistrictByName(excelRowData.get(i).getRowData().get(2)));
				employee.setEmployeeDepartment(this.serviceSchoolDepartment.getDepartmentByName(excelRowData.get(i).getRowData().get(3)));
				if(this.serviceSchoolDepartmentPosition.getPositionByName(excelRowData.get(i).getRowData().get(4)).equals("null")){
					return ajaxPrint(response, getErrorCallback("您还没配置岗位信息，请在系统内配置好在导入！"));
				}
				if(!excelRowData.get(i).getRowData().get(4).equals("null"))
				{
					employee.setEmployeePosition(this.serviceSchoolDepartmentPosition.getPositionByName(excelRowData.get(i).getRowData().get(4)));
				}
				if(!excelRowData.get(i).getRowData().get(5).equals( "null"))
				{
					employee.setOfficePhone(excelRowData.get(i).getRowData().get(5));
				}
				if(!excelRowData.get(i).getRowData().get(6).equals("null"))
				{
					employee.setStatus(excelRowData.get(i).getRowData().get(6));
				}
				if(!excelRowData.get(i).getRowData().get(7).equals( "null"))
				{
					employee.setOnboardDate(UtilDate.toDate(excelRowData.get(i).getRowData().get(7)));
				}
				if(!excelRowData.get(i).getRowData().get(8).equals( "null"))
				{
					employee.setContractEndDate(UtilDate.toDate(excelRowData.get(i).getRowData().get(8)));
				}
				if(!excelRowData.get(i).getRowData().get(9).equals("null"))
				{
					employee.setBankNo(excelRowData.get(i).getRowData().get(9));
				}
				if(!excelRowData.get(i).getRowData().get(10).equals( "null"))
				{
					resume.setBornPlace(excelRowData.get(i).getRowData().get(10));
				}
				if(!excelRowData.get(i).getRowData().get(11).equals( "null"))
				{
					if(excelRowData.get(i).getRowData().get(11).equals("群众"))
					{
						resume.setParty(1);
					}
					if(excelRowData.get(i).getRowData().get(11).equals("党员"))
					{
						resume.setParty(2);
					}
					if(excelRowData.get(i).getRowData().get(11).equals("团员"))
					{
						resume.setParty(3);
					}
				}
				if(!excelRowData.get(i).getRowData().get(12).equals( "null"))
				{
					if(excelRowData.get(i).getRowData().get(12).equals("男"))
					{
						resume.setSex(1);
					}
					else
					{
						resume.setSex(2);
					}
				}
				if(!excelRowData.get(i).getRowData().get(13).equals("null"))
				{
					resume.setAge(Integer.parseInt(excelRowData.get(i).getRowData().get(13)));
				}
				if(!excelRowData.get(i).getRowData().get(14).equals("null"))
				{
					employee.setBirthdate(UtilDate.toDate(excelRowData.get(i).getRowData().get(14)));
				}
				if(!excelRowData.get(i).getRowData().get(15).equals("null"))
				{
					DecimalFormat df = new DecimalFormat("0");    
					Double d = new Double(excelRowData.get(i).getRowData().get(15)); 
					employee.setPhoneNo(df.format(d));
					resume.setMobilePhone(df.format(d));
				}
				
				if(!excelRowData.get(i).getRowData().get(16).equals( "null"))
				{
					employee.setShortNo(excelRowData.get(i).getRowData().get(16));
				}
				if(!excelRowData.get(i).getRowData().get(17).equals( "null"))
				{
					employee.setUrgentContact(excelRowData.get(i).getRowData().get(17));
				}
				resume.setEmail(excelRowData.get(i).getRowData().get(18));
				resume.setIdentityNo(excelRowData.get(i).getRowData().get(19));
				resume.setAddress(excelRowData.get(i).getRowData().get(20));
				if(!excelRowData.get(i).getRowData().get(21).equals( "null"))
				{
					resume.setEducationCollege(excelRowData.get(i).getRowData().get(21));
				}
				if(!excelRowData.get(i).getRowData().get(22).equals( "null"))
				{
					resume.setEducationMajority(excelRowData.get(i).getRowData().get(22));
				}
				if(!excelRowData.get(i).getRowData().get(23).equals( "null"))
				{
					if(excelRowData.get(i).getRowData().get(23).equals("研究生"))
					{
						resume.setEducationDegree(1);
					}
					if(excelRowData.get(i).getRowData().get(23).equals("本科"))
					{
						resume.setEducationDegree(2);
					}
					if(excelRowData.get(i).getRowData().get(23).equals("大专"))
					{
						resume.setEducationDegree(3);
					}
					if(excelRowData.get(i).getRowData().get(23).equals("其他"))
					{
						resume.setEducationDegree(4);
					}
				}
				if(!excelRowData.get(i).getRowData().get(24).equals( "null"))
				{
					if(excelRowData.get(i).getRowData().get(24).equals("有"))
					{
						resume.setTeacherCertifaciton(1);
					}
					else
					{
						resume.setTeacherCertifaciton(2);
					}
				}
				
				if(!excelRowData.get(i).getRowData().get(25).equals( "null"))
				{
					if(excelRowData.get(i).getRowData().get(25).equals("是"))
					{
						resume.setTeacherMajority(1);
					}
					else
					{
						resume.setTeacherMajority(2);
					}
				}
				if(!excelRowData.get(i).getRowData().get(26).equals( "null"))
				{
					if(excelRowData.get(i).getRowData().get(26).equals("CET-4"))
					{
						resume.setEnglishLevel(1);
					}
					if(excelRowData.get(i).getRowData().get(26).equals("CET-6"))
					{
						resume.setEnglishLevel(2);
					}
					if(excelRowData.get(i).getRowData().get(26).equals("专业四级"))
					{
						resume.setEnglishLevel(3);
					}
					if(excelRowData.get(i).getRowData().get(26).equals("专业八级"))
					{
						resume.setEnglishLevel(4);
					}
					if(excelRowData.get(i).getRowData().get(26).equals("其他"))
					{
						resume.setEnglishLevel(5);
					}
				}
				if(!excelRowData.get(i).getRowData().get(27).equals( "null"))
				{
					if(excelRowData.get(i).getRowData().get(27).equals("一级甲等"))
					{
						resume.setChineseLevel(1);
					}
					if(excelRowData.get(i).getRowData().get(27).equals("一级乙等"))
					{
						resume.setChineseLevel(2);
					}
					if(excelRowData.get(i).getRowData().get(27).equals("二级甲等"))
					{
						resume.setChineseLevel(3);
					}
					if(excelRowData.get(i).getRowData().get(27).equals("二级乙等"))
					{
						resume.setChineseLevel(4);
					}
					if(excelRowData.get(i).getRowData().get(27).equals("三级甲等"))
					{
						resume.setChineseLevel(5);
					}
					if(excelRowData.get(i).getRowData().get(27).equals("三级乙等"))
					{
						resume.setChineseLevel(6);
					}
					if(excelRowData.get(i).getRowData().get(27).equals("无"))
					{
						resume.setChineseLevel(7);
					}
				}
				
				employee.setEntryDateTime(new Date());
				employee.setEntryId(ContextUtil.getCurrentUserId());
				
				//如果导入时xls文件里有员工编号 判断是否已存在该员工并执行更新
				if(!excelRowData.get(i).getRowData().get(0).equals("null"))
				{
					ModelHrmEmployee modelHrmEmployee = this.serviceHrmEmployee.getEmployeeByEmpNo(excelRowData.get(i).getRowData().get(0));
					UtilBean.copyNotNullProperties(modelHrmEmployee,employee);
					ModelHrmResume model1 = this.serviceHrmResume.get(modelHrmEmployee.getResume().getId());
					if(model1 == null){
						this.serviceHrmResume.save(resume);
					}else {
						UtilBean.copyNotNullProperties(model1, resume);
					}
					this.serviceHrmEmployee.merge(modelHrmEmployee);
					return ajaxPrint(response, getSuccessCallback("导入员工信息成功")); 
				}
				

				
				//判断记录是否已存在 存在执行更新
				if(this.serviceHrmEmployee.findByFullName(excelRowData.get(i).getRowData().get(1)).size() > 0 )
				{
					for(int j = 0;j<this.serviceHrmEmployee.findByFullName(excelRowData.get(i).getRowData().get(1)).size();j++)
					{
						String districtId = this.serviceHrmEmployee.findByFullName(excelRowData.get(i).getRowData().get(1)).get(j).getEmployeeDistrict().getId();
						String depId      = this.serviceHrmEmployee.findByFullName(excelRowData.get(i).getRowData().get(1)).get(j).getEmployeeDepartment().getId();
						String posId      = this.serviceHrmEmployee.findByFullName(excelRowData.get(i).getRowData().get(1)).get(j).getEmployeePosition().getId();
						if(districtId.equals(this.serviceSchoolDistrict.getDistrictByName(excelRowData.get(i).getRowData().get(2)).getId())
								&&	depId.equals(this.serviceSchoolDepartment.getDepartmentByName(excelRowData.get(i).getRowData().get(3)).getId())	
								&& posId.equals(this.serviceSchoolDepartmentPosition.getPositionByName(excelRowData.get(i).getRowData().get(4)).getId())) 
						{
							employee.setEmpNo(this.serviceHrmEmployee.findByFullName(excelRowData.get(i).getRowData().get(1)).get(j).getEmpNo());
							ModelHrmEmployee model = this.serviceHrmEmployee.findByFullName(excelRowData.get(i).getRowData().get(1)).get(j);
							ModelHrmResume model1 = this.serviceHrmResume.get(model.getResume().getId());
							UtilBean.copyNotNullProperties(model,employee);
							
							if(model1 == null){
								this.serviceHrmResume.save(resume);
							}else {
								UtilBean.copyNotNullProperties(model1, resume);
							}
							this.serviceHrmEmployee.merge(model);
							return ajaxPrint(response, getSuccessCallback("导入员工信息成功")); 
						}
					}
				}
				this.serviceHrmResume.save(resume);
				employee.setResume(resume);
				// 生成员工号编号
				int amount = this.serviceHrmEmployee.getEmployeeAmoutByDistrictIdAndDepId(
						employee.getEmployeeDistrict().getId(), employee.getEmployeeDepartment().getId());
				employee.setEmpNo(this.generateEmployeeNo(
						employee.getEmployeeDistrict(), employee.getEmployeeDepartment(), amount));
				this.serviceHrmEmployee.save(employee);
				resume.setEmployeeId(Integer.parseInt(employee.getId()));
				this.serviceHrmResume.save(resume);
				
				//生成员工对应的用户数据
				ModelAppUser user = new ModelAppUser();
				user.setEmployee(employee);
				user.setUsername(employee.getEmpNo());
				user.setPassword(UtilString.encryptSha256(employee.getEmpNo()));
				user.setFullName(employee.getEmpName());
				user.setStatus(ModelAppUser.EUserStatus.ACTIVATED.getValue());
				user.setDistrict(employee.getEmployeeDistrict());
				user.setPosition(employee.getEmployeePosition());
				user.setDepartment(employee.getEmployeeDepartment());
				this.serviceAppUser.save(user);
				
			} catch (Exception e) {
				e.printStackTrace();
				LOGGER.error("Exception raised when import employee information.", e);
				return ajaxPrint(response, getErrorCallback("员工信息导入失败:" + e.getMessage()));
			}
		}
		return ajaxPrint(response, getSuccessCallback("导入员工信息成功"));
	}
}
