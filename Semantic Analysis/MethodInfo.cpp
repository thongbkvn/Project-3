/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   MedthodInfo.cpp
 * Author: thongbkvn
 * 
 * Created on May 18, 2016, 4:35 PM
 */

#include "MethodInfo.h"
#include "FieldInfo.h"
#include "ClassInfo.h"
#include "MethodInfo.h"
#include <vector>
#include <string>
#include <iterator>



MethodInfo::MethodInfo(FieldType return_type, std::string name, std::vector<FieldInfo*> &param_list, ClassInfo *class_ref, int flags)
{
	this->return_type = return_type;
	this->name = name;
	this->class_ref = class_ref;
	this->flags = flags;
	this->params = param_list;
	for (std::vector<FieldInfo*>::iterator i = params.begin(); i != params.end(); i++)
		local_vars.push_back(*i);
}

int MethodInfo::addLocalVar(FieldInfo *var)
{
	std::vector<FieldInfo*>::iterator i;
	for (i = params.begin(); i != params.end(); i++)
		if ((*i)->name == var->name)
			return 0;
	local_vars.push_back(*i);
	return 1;
}
