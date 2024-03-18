
#font create myFont -family Helvetica -size 18 -weight bold 
#pack [label .myLabel -font myFont -text "Hello World"]

grid [frame .gender -background "light gray"]
global myLabel1 myEnt1 myEnt2 myEnt3 occupied1 occupied2 occupied3 collectme mid pre
set pre ""
set mid ""
set myEnt2 ""
set myEnt3 ""
proc preAndMid {} {
   global myLabel1 myEnt1 myEnt2 myEnt3 occupied1 occupied2 occupied3 collectme mid pre
   if {$myEnt2 == ""} {
	  set mid ","
   } else {
	  set mid $myEnt2
   }
   if {$myEnt3 == ""} {
	  set pre ""
   } else {
	  set pre $myEnt3
   }   

}
preAndMid
proc myExport {} {
	global myLabel1 myEnt1 myEnt2 myEnt3 occupied1 occupied2 occupied3 collectme mid pre
	preAndMid
	if {[.gender.myList get 0] != ""} {
		set listExport [.gender.myList get 0 end]
		#.gender.myList delete 0 end
		
		if {$occupied1 && $occupied2} {
			set collectme "("
			foreach elem $listExport {
				if {$collectme == "("} {
					set collectme "(${pre}'${elem}'"
				} else {
					set collectme "${collectme}${mid}${pre}'${elem}'"
				}
			
			}
			set collectme "${collectme})"
			#set myLabel1 $collectme
		} elseif {$occupied1 && $occupied3} {
			set collectme "("
			foreach elem $listExport {
				if {$collectme == "("} {
					set collectme "(${pre}\"${elem}\""
				} else {
					set collectme "${collectme}${mid}${pre}\"${elem}\""
				}
			
			}
			set collectme "${collectme})"
			#set myLabel1 $collectme
		} elseif {$occupied1} {
			set collectme "("
			foreach elem $listExport {
				if {$collectme == "("} {
					set collectme "(${pre}${elem}"
				} else {
					set collectme "${collectme}${mid}${pre}${elem}"
				}
			
			}
			set collectme "${collectme})"
			#set myLabel1 $collectme			
		} elseif {$occupied2} {
			set collectme ""
			foreach elem $listExport {
				if {$collectme == ""} {
					set collectme "${pre}'${elem}'"
				} else {
					set collectme "${collectme}${mid}${pre}'${elem}'"
				}
			
			}
			#set myLabel1 $collectme
		} elseif {$occupied3} {
			set collectme ""
			foreach elem $listExport {
				if {$collectme == ""} {
					set collectme "${pre}\"${elem}\""
				} else {
					set collectme "${collectme}${mid}${pre}\"${elem}\""
				}
			
			}
			#set myLabel1 $collectme
		} else {
			set collectme ""
			foreach elem $listExport {
				if {$collectme == ""} {
					set collectme "${pre}${elem}"
				} else {
					set collectme "${collectme}${mid}${pre}${elem}"
				}
			
			}
			#set myLabel1 $collectme
		}
		
		set myLabel1 "Clipboard Exported!!"
		clipboard clear			
		clipboard append $collectme
	}
}
proc myImport { } {
	global myLabel1 myEnt1 myEnt2 myEnt3 occupied1 occupied2 occupied3 collectme mid pre
	.gender.myList delete 0 end
	if {[catch {clipboard get} contents]} {
		set txt ""
	} elseif {$myEnt1 == ""} {
		set txt [clipboard get]		
		if {[regexp {\t} $txt]} {
			set txt [split $txt \t]
			foreach elem $txt {
				.gender.myList insert 0 $elem
			}
		} elseif {[regexp {\n} $txt]} {
			set txt [split $txt \n]
			foreach elem $txt {
				.gender.myList insert 0 $elem
			}			
		} else {
			set txt ""
			.gender.myList insert 0 $txt
		}
		set myLabel1 "Clipboard Imported!!"
		
	} else {
		set txt [clipboard get]
		set txt [split $txt $myEnt1]
		foreach elem $txt {
			.gender.myList insert 0 $elem
			
		}
		set myLabel1 "Clipboard Imported!!"		
	}
}

font create myFont -family Helvetica -size 16 -weight bold
font create myFont2 -family Helvetica -size 12 -weight bold
font create myFont3 -family Helvetica -size 12
font create myFont4 -family Helvetica -size 11
font create myFont5 -family Helvetica -size 14

label .gender.label -text "Delimit the Clipboard"  -font myFont -background "light gray"
grid .gender.label -row 0 -column 0 -columnspan 3

grid [label .gender.separate1 -text "" -background "light gray"]
grid .gender.separate1 -row 1 -column 0  -columnspan 2

grid [label .gender.label2 -text "Clipboard Preview: "  -font myFont2  -background "light gray"]
grid .gender.label2 -row 2 -column 0

listbox .gender.myList -font myFont4
grid .gender.myList -row 2 -column 1 -sticky news
.gender.myList insert 0

grid [label .gender.separate2 -text "Other Input Delimit: "  -background "light gray"  -font myFont2]
grid .gender.separate2 -row 3 -column 0

grid [entry .gender.myEntry -text "" -font myFont3  -textvariable myEnt1]
grid .gender.myEntry -row 3 -column 1

grid [label .gender.separate2b -text "Other Output Delimit: "  -background "light gray"  -font myFont2]
grid .gender.separate2b -row 4 -column 0

grid [entry .gender.myEntry2 -text "" -font myFont3  -textvariable myEnt2]
grid .gender.myEntry2 -row 4 -column 1

grid [label .gender.separate3 -text "Prefix: "  -background "light gray"  -font myFont2]
grid .gender.separate3 -row 5 -column 0

grid [entry .gender.myEntry3 -text "" -font myFont3  -textvariable myEnt3]
grid .gender.myEntry3 -row 5 -column 1

grid [checkbutton .gender.chk1 -text "(..)" -variable occupied1 -font myFont  -background "light gray" -command {if {$occupied1 } {
	preAndMid
   if {$occupied2} {
		set myLabel1 "(${pre}'value1'${mid}${pre}'value2' )"
   } elseif {$occupied3} {
		set myLabel1 "(${pre}\"value1\"${mid}${pre}\"value2\" )"
   } else {
		set myLabel1 "(${pre}value1${mid}${pre}value2 )"
   }
} else {
   preAndMid 
   if {$occupied2} {
		set myLabel1 "${pre}'value1'${mid}${pre}'value2'"
   } elseif {$occupied3} {
		set myLabel1 "${pre}\"value1\"${mid}${pre}\"value2\""
   } else {
		set myLabel1 "${pre}value1${mid}${pre}value2"	
   }
} }]
grid [checkbutton .gender.chk2 -text "'..'" -variable occupied2 -font myFont  -background "light gray" -command {if {$occupied2 } {
	set occupied3 0
   preAndMid
	if {$occupied1} {
		set myLabel1 "(${pre}'value1'${mid}${pre}'value2' )"
	} else {
		set myLabel1 "${pre}'value1'${mid}${pre}'value2'"
	}
} else {
   preAndMid  
	if {$occupied1} {
		set myLabel1 "(${pre}value1${mid}${pre}value2 )"
	} else {
		set myLabel1 "${pre}value1${mid}${pre}value2"	
	}
} }]

grid [checkbutton .gender.chk3 -text "\"..\"" -variable occupied3 -font myFont  -background "light gray" -command {if {$occupied3 } {
	set occupied2 0
  preAndMid  
	if {$occupied1} {
		set myLabel1 "(${pre}\"value1\"${mid}${pre}\"value2\" )"
	} else {
		set myLabel1 "${pre}\"value1\"${mid}${pre}\"value2\""
	}
} else {
   preAndMid 
	if {$occupied1} {
		set myLabel1 "(${pre}value1${mid}${pre}value2 )"
	} else {
		set myLabel1 "${pre}value1${mid}${pre}value2"	
	}
} }]

grid .gender.chk1 -row 6 -column 0
grid .gender.chk2 -row 6 -column 1
grid .gender.chk3 -row 6 -column 2

grid [label .gender.label3 -text ""  -font myFont2  -background "light gray"]
grid .gender.label3 -row 7 -column 0

grid [label .gender.myLabel  -text "No Clipboard Imported.." -textvariable myLabel1   -font myFont5  -background "light gray"]
grid .gender.myLabel -row 7 -columnspan 3

grid [button .gender.myButton1 -text "Clipboard Import"  -font myFont2 -background "gray" -command myImport]
grid [button .gender.myButton2 -text "Clipboard Export"  -font myFont2 -background "gray" -command myExport]
#grid [button .gender.myButton3 -text "Close"  -font myFont2 -background "gray" -command myExport]
grid .gender.myButton1 -row 8 -column 0
grid .gender.myButton2 -row 8 -column 2
#grid .gender.myButton3 -row 8 -column 1
