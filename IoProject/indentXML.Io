Builder := Object clone

tab := ""
brackets := method(
  r := List clone;
  call message arguments foreach(arg,
    r append(arg))
)

Builder forward := method(
  writeln(tab, "<", call message name, ">")
  tab = tab .. "  "
  call message arguments foreach(
	arg,
	content := self doMessage(arg);
  if(content type == "Sequence", writeln(tab, content)))
  tab = tab exclusiveSlice(2)
  writeln(tab, "</", call message name, ">"))

Builder ul(li("Io"),li("Ruby"));
