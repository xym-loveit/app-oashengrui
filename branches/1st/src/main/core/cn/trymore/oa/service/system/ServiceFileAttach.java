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

package cn.trymore.oa.service.system;

import cn.trymore.core.exception.ServiceException;
import cn.trymore.core.service.ServiceGeneric;
import cn.trymore.oa.model.system.ModelFileAttach;

/**
 * The file attachment service.
 * 
 * @author Jeccy.Zhao
 *
 */
public interface ServiceFileAttach
extends ServiceGeneric<ModelFileAttach>
{
	
	/**
	 * Obtains the file attach entity with the specified file path. 
	 * 
	 * @param filePath
	 *           the file path
	 * @return file attachment entity
	 * @throws ServiceException
	 */
	ModelFileAttach getByPath (String filePath) throws ServiceException;
	
}
