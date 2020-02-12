#include <Python.h>
#include <pythonrun.h> 
#include <bytearrayobject.h> 

#include <stdio.h>
#include <math.h>

typedef struct {
    unsigned int a;
    bool b;
} DpiStructGEN;

PyObject *pBlockObjectGEN;

extern "C" void gen_init_python()
    { 
        char pydir[400];
        
        PyObject *pBlockWrapper, *pBlockClass;

        Py_Initialize();

        PyRun_SimpleString("import sys"); 
        strcpy(pydir, "sys.path.append('");
        strcat(pydir, "../python/"); 
        strcat(pydir, "')"); 
        PyRun_SimpleString(pydir);


        pBlockWrapper = PyImport_ImportModule("just_pass"); 
        if(pBlockWrapper == NULL){ 
            PyErr_Print(); 
            exit(1); 
        }

        pBlockClass = PyObject_GetAttrString(pBlockWrapper, "just_pass"); 
        assert(pBlockClass && PyCallable_Check(pBlockClass)); 



        pBlockObjectGEN = PyObject_CallObject(pBlockClass, NULL);
        if(pBlockObjectGEN  == NULL){ 
            PyErr_Print(); 
            exit(1); 
        }

        Py_XDECREF(pBlockWrapper);
        Py_XDECREF(pBlockClass);

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

extern "C"  int just_pass_val(DpiStructGEN *dpiStruct){
    PyObject *pBlockMethod, *pMethodReturn;
    PyObject *a;
    
    int ret_val;

    a               = Py_BuildValue("i", dpiStruct->a       );

    pBlockMethod = Py_BuildValue("s", "pass_val");
    assert(pBlockMethod != NULL);

    pMethodReturn = PyObject_CallMethodObjArgs(
        pBlockObjectGEN, pBlockMethod, a, NULL);
    
    if(pMethodReturn == NULL){ 
        PyErr_Print(); 
        exit(1); 
    }

    ret_val = int(PyFloat_AsDouble(pMethodReturn));



    return ret_val;
}

extern "C"  bool just_pass_bool(DpiStructGEN *dpiStruct){
    PyObject *pBlockMethod, *pMethodReturn;
    PyObject *b;

    bool ret_bool;

    b               = Py_BuildValue("i", dpiStruct->b       );

    pBlockMethod = Py_BuildValue("s", "pass_bool");
    assert(pBlockMethod != NULL);

    pMethodReturn = PyObject_CallMethodObjArgs(
        pBlockObjectGEN, pBlockMethod, b, NULL);
    
    if(pMethodReturn == NULL){ 
        PyErr_Print(); 
        exit(1); 
    }

    ret_bool = bool(PyFloat_AsDouble(pMethodReturn));


    return ret_bool;
}

extern "C" void gen_end_python()
    {
        Py_Finalize();
       // printf("\n PYTHON FINALIZED: GEN_DATA\n\n");
    }
