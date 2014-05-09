# a string in `backticks` is by default executed as a command
# In face, the string is passed to a method called Kernel#`
# This can be overridden.

alias old_backtick `

def `(cmd)
  result = old_backtick(cmd)
  if $? != 0
    puts "*** Command #{cmd} failed: status = #{$?.exitstatus}"
  end
  result
end

print `ls -l /etc/passwd`
print `ls -l /etc/wibble`
