package org.shengrui.oa.model;

import java.util.Date;

/**
 * The model of user
 * 
 * @author Jeccy.Zhao
 *
 */
public class ModelUser 
extends ModelBase
{
	/**
	 * The serial version UID
	 */
	private static final long serialVersionUID = -3992821886250653630L;
	
	/**
	 * The account name
	 */
	private String userName;
	
	/**
	 * The account password
	 */
	private String password;
	
	/**
	 * The account real name
	 */
	private String realName;
	
	/**
	 * The account phone number at home
	 */
	private String homePhone;
	
	/**
	 * The account phone number of mobile
	 */
	private String mobilePhone;
	
	/**
	 * The account home address
	 */
	private String homeAddress;
	
	/**
	 * The account email address
	 */
	private String emailAddress;
	
	/**
	 * The account type, by default as common
	 */
	private Integer userType = AccountType.COMMON.getValue();
	
	/**
	 * The account activation code
	 */
	private String userActivationCode;
	
	/**
	 * The account activation time
	 */
	private Date userActivationTime;
	
	/**
	 * The account registration time
	 */
	private Date userRegistrationTime;
	
	/**
	 * The account status, by default as not activation
	 */
	private Integer userStatus = AccountStatus.NOT_ACTIVATION.getValue();
	
	/**
	 * The default constructor
	 */
	public ModelUser()
	{
		
	}
	
	/**
	 * The sole constructor
	 * 
	 * @param userName
	 *          the account name
	 * @param password
	 *          the account password
	 * @param userType
	 *          the account type
	 */
	public ModelUser(String userName, String password, Integer userType)
	{
		this.userName = userName;
		this.password = password;
		this.userType = userType;
	}
	
	/**
	 * The enumeration of account type
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum AccountType
	{
		
		/**
		 * The type of Administrator
		 */
		ADMIN(0, "admin"),
		
		/**
		 * The type of Common
		 */
		COMMON(1, "common");
		
		private int value;
		private String text;
		
		AccountType(int value, String text)
		{
			this.value = value;
			this.text = text;
		}
		
		public int getValue()
		{
			return value;
		}
		
		public String getText()
		{
			return this.text;
		}
		
	}
	
	/**
	 * The enumeration of account status
	 * 
	 * @author Jeccy.Zhao
	 *
	 */
	public static enum AccountStatus
	{
		
		/**
		 * Not activation yet
		 */
		NOT_ACTIVATION(0, "notactivated"),
		
		/**
		 * Activation already
		 */
		ACTIVATION(1, "activated");
		
		private int value;
		private String text;
		
		AccountStatus (int value, String text)
		{
			this.value = value;
			this.text = text;
		}
		
		public int getValue(){
			return value;
		}
		
		public String getText()
		{
			return this.text;
		}
		
	}
	
	public String getRealName() 
	{
		return realName;
	}

	public void setRealName(String realName) 
	{
		this.realName = realName;
	}

	public String getHomePhone() 
	{
		return homePhone;
	}

	public void setHomePhone(String homePhone) 
	{
		this.homePhone = homePhone;
	}

	public String getMobilePhone() 
	{
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) 
	{
		this.mobilePhone = mobilePhone;
	}

	public String getHomeAddress() 
	{
		return homeAddress;
	}

	public void setHomeAddress(String homeAddress) 
	{
		this.homeAddress = homeAddress;
	}

	public String getEmailAddress() 
	{
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) 
	{
		this.emailAddress = emailAddress;
	}

	public String getUserName()
	{
		return userName;
	}
	
	public void setUserName(String userName)
	{
		this.userName = userName;
	}
	
	public String getPassword()
	{
		return password;
	}
	
	public void setPassword(String password)
	{
		this.password = password;
	}

	public Integer getUserType()
	{
		return userType;
	}

	public void setUserType(Integer userType) 
	{
		this.userType = userType;
	}

	public void setUserStatus(Integer userStatus)
	{
		this.userStatus = userStatus;
	}

	public Integer getUserStatus()
	{
		return userStatus;
	}

	public void setUserActivationCode(String userActivationCode)
	{
		this.userActivationCode = userActivationCode;
	}

	public String getUserActivationCode()
	{
		return userActivationCode;
	}

	public Date getUserActivationTime()
	{
		return userActivationTime;
	}

	public void setUserActivationTime(Date userActivationTime)
	{
		this.userActivationTime = userActivationTime;
	}

	public Date getUserRegistrationTime()
	{
		return userRegistrationTime;
	}

	public void setUserRegistrationTime(Date userRegistrationTime)
	{
		this.userRegistrationTime = userRegistrationTime;
	}
	
}
