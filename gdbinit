define loadfs 
	attach $arg0
	p (char)[[NSBundle bundleWithPath:@"~/Development/XCode/F-Script/FScript.framework"] load]
	p (void)[FScriptMenuItem insertInMainMenu]
	continue 
end

