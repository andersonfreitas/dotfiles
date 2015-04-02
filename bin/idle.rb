# usage: (for fun)
# watch -n .1 ruby idle.rb

idle = `ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/!{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'`

idle = idle.to_f / 1000000000

print "#{idle}\n"

