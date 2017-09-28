# -*- coding: utf-8 -*-
"""
Created on Wed Sep 27 17:40:23 2017

@author: mariam
"""
import re

def seletReads(fileRead,number,fileWrite,name):
    count=0
    fi=open(fileRead,'r')
    fiWrite=open(fileWrite,'w')
    line=fi.readline()
    while(1):
        
        if line[0]=='+' and len(line)==2:
            count+=1
        if count==number:
            fiWrite.write(line)
            line=fi.readline()
            fiWrite.write(line)
            break;
        fiWrite.write(line)
        line=fi.readline()
    fi.close()
    fiWrite.close()
    return 
    
def selectReadForAllFiles(filesNames,number):
    for i in filesNames:
        print i
        fileFin=i.split('/')
        fileFin=fileFin[len(fileFin)-1]
        fileFin=fileFin.split('.')
        name=fileFin[0]
        fileFin[0]=fileFin[0]+'s'
        fileFin='.'.join(fileFin)
        seletReads(i,number,fileFin,name)
    return 
    
files=['/home/mariam/Documents/datasets/ERR990557.fastq','/home/mariam/Documents/datasets/ERR990558.fastq','/home/mariam/Documents/datasets/ERR990559.fastq','/home/mariam/Documents/datasets/ERR990560.fastq']
selectReadForAllFiles(files,8000000)
            
            