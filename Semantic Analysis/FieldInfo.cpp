#include "FieldInfo.h"
#include "FieldType.h"
#include <iostream>
#include <string>
FieldInfo::FieldInfo(int flags,std::string name,FieldType type)
    {
	  this->flags = flags;
	  this->name =name;
	  this->type = type;
    }
