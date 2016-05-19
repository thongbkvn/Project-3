#ifndef FIELDINFO_H_
#define FIELDINFO_H_
#include <iostream>
#include <string>

class FieldInfo
{
 public:
  enum AccessFlags{ACC_PUBLIC=0x1, ACC_PRIVATE=0x2, ACC_PROTECTED=0x4,
		   ACC_STATIC=0x8, ACC_FINAL=0x10, ACC_VOLATILE=0x40,
		   ACC_TRANSIENT=0x80, ACC_SYNTHETIC=0x1000, ACC_ENUM = 0x4000};
  enum FieldType{BOOLEAN, INT, FLOAT, STRING, OBJECT_TYPE, ARRAY_TYPE};

  FieldInfo(int flags,std::string name,FieldType base_type);

  FieldInfo(int flags,std::string name, FieldType type, std::string class_name);

  FieldInfo(int flags, std::string name, FieldType type, FieldInfo component_type);
  
  int flags; //Chi dinh truy cap
  std::string name; //Ten bien
  FieldType type; //Kieu cua bien
  std::string class_name; //Neu kieu bien la object thi chua ten class, 
  FieldInfo* component_type; //neu kieu bien la array thi chua ten kieu cua thanh phan
};
#endif
