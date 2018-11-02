#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  
		  Dim exe_to_run As FolderItem
		  
		  Dim whole_cl As String
		  Dim the_exe As String
		  Dim p1 As Int32
		  Dim p2 As Int32
		  
		  whole_cl = System.CommandLine
		  System.DebugLog(whole_cl)
		  
		  p1 = whole_cl.InStr(".exe")
		  If p1 = 0 Then
		    MsgBox("Program: " + whole_cl + " Is syntactically incorrect for execution.")
		    Self.AutoQuit = True
		  Else
		    p2 = p1 + 5
		    the_exe = whole_cl.Mid(p2+1)
		    System.DebugLog(the_exe)
		    
		    exe_to_run = New FolderItem(the_exe)
		    
		    If exe_to_run <> Nil And exe_to_run.Exists Then
		      LaunchAsAdmin(exe_to_run)
		    Else
		      MsgBox("Failed to run " + exe_to_run.Name)
		    End If
		    
		    SleepCurrentThread(1000)
		    
		    Self.AutoQuit =True 
		    
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub LaunchAsAdmin(program_exe As FolderItem, ParamArray args As String)
		  
		  ' Not necessary (not intended for any OS except Windows).
		  #If TargetWin32 Then
		    Declare Function ShellExecuteW Lib "Shell32" (HWND As Integer, verb As WString, _
		    file As WString, params As WString, dir As WString, cmd As Integer) As Integer
		    
		    Dim params As String
		    params = Join(args, " ")
		    
		    // Too many args?
		    //Call ShellExecuteW(0, "runas", program_exe.NativePath, params, App.ExecutableFile.NativePath, 1)
		    Call ShellExecuteW(0, "runas", program_exe.NativePath, params, App.ExecutableFile.NativePath, 1)
		  #Endif
		End Sub
	#tag EndMethod


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
