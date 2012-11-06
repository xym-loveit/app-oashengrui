/*
 * Copyright (c) 2010-2012 Zhao.Xiang<z405656232x@163.com> Holding Limited.
 * All rights reserved.
 * 
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package cn.trymore.oa.dao.system.impl;

import cn.trymore.oa.dao.system.DAOFileAttach;
import cn.trymore.oa.model.system.ModelFileAttach;

import cn.trymore.core.dao.impl.DAOGenericImpl;
import cn.trymore.core.exception.DAOException;
import cn.trymore.core.util.UtilString;

/**
 * The file attachment repository.
 * 
 * @author Jeccy.Zhao
 *
 */
public class DAOFileAttachImpl
extends DAOGenericImpl<ModelFileAttach> implements DAOFileAttach
{
	/*
	 * (non-Javadoc)
	 * @see cn.trymore.oa.dao.system.DAOFileAttach#getByPath(java.lang.String)
	 */
	@Override
	public ModelFileAttach getByPath(String filePath) throws DAOException
	{
		if (UtilString.isNotEmpty(filePath))
		{
			String str = "from ModelFileAttach f where f.filePath=?";
			return (ModelFileAttach) findUnique(str, new Object[] { filePath });
		}
		
		return null;
	}

}
