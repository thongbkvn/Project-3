/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   MedthodInfo.h
 * Author: thongbkvn
 *
 * Created on May 18, 2016, 4:35 PM
 */

#ifndef METHODINFO_H
#define METHODINFO_H
#include <string>
#include <vector>
#include "FieldType.h"
class ClassInfo;
class FieldInfo;

class MethodInfo {
public:
    enum AccessFlags{ACC_PUBLIC=0x1, ACC_PRIVATE=0x2, ACC_PROTECTED=0x4, ACC_STATIC=0x8, ACC_FINAL=0x10, ACC_SYNCHRONIZED=0x20, ACC_BRIDGE=0X40, ACC_VARAGS=0x80, ACC_NATIVE=0x100, ACC_ABSTRACT=0x400, ACC_STRICT=0x800, ACC_SYNTHETIC=0x1000};
    int flags;
    std::string name;
    std::vector<FieldInfo*> params;
    std::vector<FieldInfo*> local_vars;
    FieldType return_type;
    ClassInfo *class_ref;

    MethodInfo(FieldType return_type, std::string name, std::vector<FieldInfo*> &params, ClassInfo *class_ref, int flags = ACC_PUBLIC);

    int addLocalVar(FieldInfo* vars);

    FieldInfo* checkFieldAvailable(std::string label);
    MethodInfo* checkMethodAvailable(std::string label);
};

#endif /* MEDTHODINFO_H */

