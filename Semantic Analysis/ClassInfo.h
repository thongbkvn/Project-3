/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   ClassInfo.h
 * Author: thongbkvn
 *
 * Created on May 18, 2016, 8:45 PM
 */

#ifndef CLASSINFO_H
#define CLASSINFO_H
#include "FieldInfo.h"
#include <vector>
class MethodInfo;
class ClassInfo {
public:
    enum AccessFlag{ACC_PUBLIC = 0x1, ACC_FINAL = 0x10, ACC_SUPER = 0x20, ACC_INTERFACE = 0x200,
    ACC_ABSTRACT = 0x400, ACC_SYNTHETIC=0x1000, ACC_ANNOTATION=0x2000, ACC_ENUM=0x4000};
    static ClassInfo *root; //Class Object, goc tren cay ke thua
    static ClassInfo *getClass(std::string class_name, ClassInfo *super_class = root); //Chi xet truong hop cac class tren cay ke thua khac ten nhau
    int flags;
    std::string name;
    ClassInfo *super;
    ClassInfo *self;
    std::vector<ClassInfo*> childs;
    std::vector<FieldInfo*> fields;
    std::vector<MethodInfo*> methods;
    
    ClassInfo(std::string name, std::string super_name = NULL, int flags = ACC_PUBLIC);
    int addField(FieldInfo *field);
    int addMethod(MethodInfo *method);
    void addChild(ClassInfo *child);
    
    
    FieldInfo* getFieldLocal(std::string field_name);
    MethodInfo* getMethodLocal(std::string method_name); //Co the thay sang chu ki neu yeu cau ca overload
    
    FieldInfo getFieldInheirited(std::string field_name, ClassInfo *super); //Tim them tren cay ke thua
    MethodInfo getMethodInherited(std::string method_name, ClassInfo *super); //Tim them tren cay ke thua
    
private:

};

#endif /* CLASSINFO_H */

