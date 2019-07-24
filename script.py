#Get the list of ALL installed APPs
appList=AdminApp.list().splitlines()

#Get the list of Application ports for each APP
for app in appList:
    print "  "
    #print APP Name
    print "Nombre de la aplicacion:"
    print app
    #Get the list of Application Ports
    print "Detalles de la aplicacion"
    portList=AdminTask.listApplicationPorts(app).splitlines()
    for port in portList:
        #Print the port Details for the APP
        print port
