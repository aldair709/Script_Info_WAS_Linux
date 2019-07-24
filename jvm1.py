jvmName=AdminControl.completeObjectName('WebSphere:type=JVM,process=MyServerName,*')
print AdminControl.getAttribute(jvmName,'maxMemory')
