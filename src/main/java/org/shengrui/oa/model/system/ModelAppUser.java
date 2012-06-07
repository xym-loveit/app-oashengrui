package org.shengrui.oa.model.system;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.xml.bind.annotation.XmlTransient;

import com.google.gson.annotations.Expose;

import cn.trymore.core.model.ModelBase;
import cn.trymore.core.util.UtilString;

/**
 * Model: 用户模型
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelAppUser
extends ModelBase
{

	private static final long serialVersionUID = 6633139098998882031L;
	
	/**
	 * 用户名
	 */
	@Expose
	protected String username;
	
	/**
	 * 用户密码
	 */
	protected String password;
	
	/**
	 * 用户邮箱
	 */
	@Expose
	protected String email;
	
	/**
	 * 座机
	 */
	@Expose
	protected String phone;
	
	/**
	 * 手机
	 */
	@Expose
	protected String mobile;
	
	/**
	 * 传真
	 */
	@Expose
	protected String fax;
	
	/**
	 * 地址
	 */
	@Expose
	protected String address;
	
	/**
	 * 邮编
	 */
	@Expose
	protected String zip;
	
	/**
	 * 照片
	 */
	@Expose
	protected String photo;
	
	/**
	 * 状态 ( 1=激活,0=禁用,2=离职)
	 */
	@Expose
	protected Short status;
	
	/**
	 * 最后登陆IP
	 */
	@Expose
	protected String lastLogonIP;
	
	/**
	 * 最后登录时间
	 */
	@Expose
	protected Date lastLogonTime;
	
	/**
	 * 用于存储该用户的权限,需要合并公共的
	 */
	protected Set<String> rights = new HashSet<String>();
	
	/**
	 * 用户所属岗位
	 */
	@Expose
	protected ModelSchoolDepartmentPosition position;
	
	/**
	 * 用户拥有的角色
	 */
	@XmlTransient
	protected Set<ModelAppRole> roles;
	
	/**
	 * 判断是否为超级管理员.
	 * 
	 * @param role
	 * @return
	 */
	private boolean isSuperRoot (final ModelAppRole role)
	{
		return role != null ? ModelAppRole.SUPER_ROLEID.equals(role.getId()) : false;
	}
	
	/**
	 * 判断当前用户是否为超级管理员.
	 * 
	 * @return
	 */
	public boolean isSupperManage()
	{
		final Set<ModelAppRole> roles = this.roles;
		boolean flag = false;
		for (Iterator<ModelAppRole> it = roles.iterator(); it.hasNext();) 
		{
			ModelAppRole role = it.next();
			if (isSuperRoot(role))
			{
				flag = true;
				break;
			}
		}
		return flag;
	}
	
	/**
	 * 取得所有的Function的权限，则以_为开头的权限
	 * 
	 * @return
	 */
	public String getFunctionRights() 
	{
		StringBuffer sb = new StringBuffer();

		Iterator<String> it = rights.iterator();

		while (it.hasNext()) 
		{
			sb.append(it.next()).append(",");
		}

		if (rights.size() > 0) 
		{
			sb.deleteCharAt(sb.length() - 1);
		}

		return sb.toString();
	}
	
	/**
	 * 初始化菜单权限信息
	 */
	public void initMenuRights()
	{
		// 进行合并权限的处理
		final Set<ModelAppRole> roleSet = this.roles;
		Iterator<ModelAppRole> it = roleSet.iterator();
		
		while (it.hasNext()) 
		{
			ModelAppRole role = it.next();
			if (isSuperRoot(role))
			{
				this.rights.add(ModelAppRole.SUPER_RIGHTS);
				break;
			}
			else
			{
				if (UtilString.isNotEmpty(role.getRoleRights()))
				{
					String[] items = role.getRoleRights().split("[,]");
					for (int i = 0; i < items.length; i++) 
					{
						String item = items[i];
						if (!this.rights.contains(item)) 
						{
							getRights().add(item);
						}
					}
				}
			}
		}
	}
	
	public String getUsername()
	{
		return username;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public String getPhone()
	{
		return phone;
	}

	public void setPhone(String phone)
	{
		this.phone = phone;
	}

	public String getMobile()
	{
		return mobile;
	}

	public void setMobile(String mobile)
	{
		this.mobile = mobile;
	}

	public String getFax()
	{
		return fax;
	}

	public void setFax(String fax)
	{
		this.fax = fax;
	}

	public String getAddress()
	{
		return address;
	}

	public void setAddress(String address)
	{
		this.address = address;
	}

	public String getZip()
	{
		return zip;
	}

	public void setZip(String zip)
	{
		this.zip = zip;
	}

	public String getPhoto()
	{
		return photo;
	}

	public void setPhoto(String photo)
	{
		this.photo = photo;
	}

	public Short getStatus()
	{
		return status;
	}

	public void setStatus(Short status)
	{
		this.status = status;
	}

	public Set<String> getRights()
	{
		return rights;
	}

	public void setRights(Set<String> rights)
	{
		this.rights = rights;
	}

	public Set<ModelAppRole> getRoles()
	{
		return roles;
	}

	public void setRoles(Set<ModelAppRole> roles)
	{
		this.roles = roles;
	}

	public String getLastLogonIP()
	{
		return lastLogonIP;
	}

	public void setLastLogonIP(String lastLogonIP)
	{
		this.lastLogonIP = lastLogonIP;
	}

	public Date getLastLogonTime()
	{
		return lastLogonTime;
	}

	public void setLastLogonTime(Date lastLogonTime)
	{
		this.lastLogonTime = lastLogonTime;
	}

	public ModelSchoolDepartmentPosition getPosition()
	{
		return position;
	}

	public void setPosition(ModelSchoolDepartmentPosition position)
	{
		this.position = position;
	}
	
}
