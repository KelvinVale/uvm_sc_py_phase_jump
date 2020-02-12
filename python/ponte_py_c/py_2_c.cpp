#include <Python.h>
#include <pythonrun.h> 
#include <bytearrayobject.h> 
//#include <bits/stdc++.h>
#include <stdio.h>
#include <math.h>

typedef struct {
    unsigned int a;
    unsigned int b;
} DpiStructGEN;

PyObject *pBlockObjectGEN;

extern "C" void gen_init_python()
    { 
        char pydir[400];
        
        PyObject *pBlockWrapper, *pBlockClass;

        Py_Initialize();

        PyRun_SimpleString("import sys"); 
        strcpy(pydir, "sys.path.append('");
        strcat(pydir, "./ponte_py_c/"); 
        strcat(pydir, "')"); 
        PyRun_SimpleString(pydir);


        pBlockWrapper = PyImport_ImportModule("Somador_8_bits"); 
        if(pBlockWrapper == NULL){ 
            PyErr_Print(); 
            exit(1); 
        }

        pBlockClass = PyObject_GetAttrString(pBlockWrapper, "Somador_8_bits"); 
        assert(pBlockClass && PyCallable_Check(pBlockClass)); 



        pBlockObjectGEN = PyObject_CallObject(pBlockClass, NULL);
        if(pBlockObjectGEN  == NULL){ 
            PyErr_Print(); 
            exit(1); 
        }

        Py_XDECREF(pBlockWrapper);
        Py_XDECREF(pBlockClass);

        //printf("\n PYTHON INITIALIZED\n\n"); 
    }

extern "C" void gen_set_param(DpiStructGEN *dpiStruct){
    PyObject *pBlockMethod, *pMethodReturn;
    PyObject *a;
    PyObject *b;

    a               = Py_BuildValue("f", dpiStruct->a       );
    b               = Py_BuildValue("f", dpiStruct->b       );

    pBlockMethod = Py_BuildValue("s", "set"); 
    assert(pBlockMethod != NULL); 

    pMethodReturn = PyObject_CallMethodObjArgs(
        pBlockObjectGEN, pBlockMethod, a, b, NULL);
    
    if(pMethodReturn == NULL){ 
        PyErr_Print(); 
        exit(1); 
    }

    Py_XDECREF(a        ); 
    Py_XDECREF(b        ); 
}

extern "C"  int Somador_8_bits(DpiStructGEN *dpiStruct){
    PyObject *pBlockMethod, *pMethodReturn;
    PyObject *a;
    PyObject *b;
    
    int retval;

    a               = Py_BuildValue("i", dpiStruct->a       );
    b               = Py_BuildValue("i", dpiStruct->b       );

    pBlockMethod = Py_BuildValue("s", "sum");
    assert(pBlockMethod != NULL);

    pMethodReturn = PyObject_CallMethodObjArgs(
        pBlockObjectGEN, pBlockMethod, a, b, NULL);
    
    if(pMethodReturn == NULL){ 
        PyErr_Print(); 
        exit(1); 
    }

    retval = int(PyFloat_AsDouble(pMethodReturn));
    return retval;
}

extern "C" void gen_end_python()
    {
        Py_Finalize();
       // printf("\n PYTHON FINALIZED: GEN_DATA\n\n");
    }
