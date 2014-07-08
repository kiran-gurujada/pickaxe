# The Ruby virtual machine is called YARV.
#
# YARV exposes some of its state via Ruby classes.

code = RubyVM::InstructionSequence.compile('a = 1; puts 1 + a')
puts code.disassemble
