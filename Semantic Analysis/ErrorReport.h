/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   ErrorReport.h
 * Author: thongbkvn
 *
 * Created on May 19, 2016, 12:26 AM
 */

#ifndef ERRORREPORT_H
#define ERRORREPORT_H
#include <iostream>
#include <string>

    enum ErrorType {SAME_TYPE, BOOL_EXP};
    void errorReport(ErrorType type, int line)
    {
        std::string msg;
        switch (type)
        {
            case SAME_TYPE:
                msg = "Expressions must have the same type at line " + line;
                break;
            case BOOL_EXP:
                msg = "Expression type must have boolean type at line " + line;
        }
        std::cout << msg << std::endl;
    }

#endif /* ERRORREPORT_H */

