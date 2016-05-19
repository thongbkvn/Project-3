#ifndef FIELDINFO_H_
#define FIELDINFO_H_
#include <string>
#include "FieldType.h"

class FieldInfo
{
 public:
  enum AccessFlags{ACC_PUBLIC=0x1, ACC_PRIVATE=0x2, ACC_PROTECTED=0x4,
		   ACC_STATIC=0x8, ACC_FINAL=0x10, ACC_VOLATILE=0x40,
		   ACC_TRANSIENT=0x80, ACC_SYNTHETIC=0x1000, ACC_ENUM = 0x4000};
  
  FieldInfo(int flags,std::string name,FieldType type);
  
  int flags; //Chi dinh truy cap
  std::string name; //Ten bien
  FieldType type; //Kieu cua bien
};
#endif
