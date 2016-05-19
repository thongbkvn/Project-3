/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   FieldType.cpp
 * Author: thongbkvn
 * 
 * Created on May 18, 2016, 4:51 PM
 */

#include "FieldType.h"

FieldType::FieldType()
 {
	type = FieldType::VOID_TYPE;
};

FieldType::FieldType(FieldType::Type type, FieldType::BaseType base_type) {
    this->type = type;
    this->base_type = base_type;
}

FieldType::FieldType(FieldType::Type type, std::string class_name) {
    this->type = type;
    this->object_type = class_name;
}
FieldType::FieldType(FieldType::Type type, FieldType *component_type) {
    this->type = type;
    this->component_type = component_type;
}


FieldType::FieldType(const FieldType &fieldType)
{
	this->type = fieldType.type;
	this->object_type = fieldType.object_type;
	this->component_type = fieldType.component_type;
}

const FieldType& FieldType::operator=(const FieldType &fieldType)
{
	this->type = fieldType.type;
	this->object_type = fieldType.object_type;
	this->component_type = fieldType.component_type;
	return fieldType;
}
