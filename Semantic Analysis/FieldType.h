/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   FieldType.h
 * Author: thongbkvn
 *
 * Created on May 18, 2016, 4:51 PM
 */

#ifndef FIELDTYPE_H
#define FIELDTYPE_H
#include <string>

class FieldType {
public:
    enum Type{VOID_TYPE, BASE_TYPE, OBJECT_TYPE, ARRAY_TYPE};
    Type type;
    
    enum BaseType{BOOLEAN, INTEGER, FLOAT};
    BaseType base_type;
    std::string object_type;
    FieldType *component_type;

    FieldType();
    FieldType(Type type, BaseType base_type); 
    FieldType(Type type, std::string object_type);
    FieldType(Type type, FieldType *component_type);
    FieldType(const FieldType &fieldType);
    const FieldType& operator=(const FieldType &fieldType);
};

#endif /* FIELDTYPE_H */

