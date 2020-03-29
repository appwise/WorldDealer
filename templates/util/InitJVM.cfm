<CFSETTING ENABLECFOUTPUTONLY=TRUE>
<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="begin $RCSfile: InitJVM.cfm,v $">
<!---
CFMODULE to initialize Java VM

Usage: <CFMODULE TEMPLATE="/util/InitJVM.cfm" PROPERTIES=#properties#>

Copyright (c) 2000 AppNet Inc.  All rights reserved.
$Id: InitJVM.cfm,v 1.4 2000/03/22 15:38:11 jsturm Exp $
--->

<!---
properties attribute (required)

required members:
	javaOut      - log path for JVM messages
	javaErr      - log path for JVM errors

optional members:
	checkpoint   - number of minutes per cache checkpoint
	timeout      - number of checkpoints before cached content times out
	classLoaderFactory - class to create custom classloaders
--->
<CFPARAM NAME="ATTRIBUTES.properties">

<CFSET properties = ATTRIBUTES.properties>

<CFIF NOT IsStruct(properties)>
	<CFABORT SHOWERROR="Properties is not a structure">
</CFIF>

<!--- initialize the Java VM --->
<CFIF NOT IsDefined("SERVER.javaVM")>
	<CFLOCK NAME="SERVER.javaVM" TIMEOUT="5">
		<CFOBJECT TYPE="COM"
			ACTION="Create"
			CLASS="COM.sigma6.util.VM"
			NAME="vm">
		<CFSCRIPT>
			// Redirect JVM output for logging
			vm.setStandardOutput(properties.javaOut);
			vm.setStandardError(properties.javaErr);

			// Log the VM initialization
			vm.logOutput("VM initialized");
			vm.logError("VM initialized");

			// Set CacheManager properties
			if (IsDefined("properties.checkpoint")) {
				vm.setProperty("cache.checkpoint", properties.checkpoint);
				vm.writeOutput("cache.checkpoint = " & properties.checkpoint);
			}
			if (IsDefined("properties.timeout")) {
				vm.setProperty("cache.timeout", properties.timeout);
				vm.writeOutput("cache.timeout = " & properties.timeout);
			}

			// Assign a ClassLoaderFactory, if requested
			if (IsDefined("properties.classLoaderFactory")) {
				factory = vm.createInstance(properties.classLoaderFactory);
				vm.setClassLoaderFactory(factory);
				vm.writeOutput("classLoaderFactory = " & factory.toString());
			}

			// Store the vm object where it'll persist forever (at least
			// until CF dies).
			SERVER.javaVM = vm;
		</CFSCRIPT>
	</CFLOCK>
</CFIF>

<CFMODULE TEMPLATE="/util/DumpDebug.cfm" TEXT="end   $RCSfile: InitJVM.cfm,v $">
<CFSETTING ENABLECFOUTPUTONLY=FALSE>
