Running_JVMS=AdminControl.queryNames("*:type=Server,*").split(java.lang.System.getProperty("line.separator"))
ignorelist=['nodeagent','dmgr']
for JVM in Running_JVMS:
        ServerName=AdminControl.invoke(JVM ,"getName()")
        if ServerName not in ignorelist:
                JVMName=AdminControl.completeObjectName('type=JVM,process='+ServerName+',*')
                JVMObject=AdminControl.makeObjectName(JVMName)
                perf=AdminControl.completeObjectName('type=Perf,process='+ServerName+',*')
                perfObject=AdminControl.makeObjectName(perf)
                Obj=AdminControl.invoke_jmx(perfObject,"getStatsObject",[JVMObject,java.lang.Boolean('false')],['javax.management.ObjectName','java.lang.Boolean'
])
                current=Obj.getStatistic('HeapSize').getCurrent()
                used=Obj.getStatistic('UsedMemory').getCount()
                usage=float(used)/float(current)*100
                uptime=float(Obj.getStatistic('UpTime').getCount())/60/60/24

		current01=float(current)/1000
		used01=float(used)/1000
		
                print "--------------------------------------------"
                print "Nombre del servidor:	", ServerName
                print "Actividad(en dias):	", int(uptime)
                print "--------------------------------------------"
                print "Uso actual MB:		", current01
                print "Memoria usada MB:	", used01
                print "Uso en porcentaje:	", int(usage)
                print "--------------------------------------------"
