# Tracing your program's execution
#
# Ruby allows you to look at executing statements. You can watch the
# interpreter using the TracePoint class.
#
# This outputs debugging information every time a new source line is executed,
# methods are called, objects are created etc.

class Test
  def test
    a = 1
  end
end

TracePoint.trace do |tp|
  p tp
end

t = Test.new
t.test

# Produces:
#
#<TracePoint:c_return `trace'@tracing_execution.rb:15>
#<TracePoint:line@tracing_execution.rb:19>
#<TracePoint:c_call `new'@tracing_execution.rb:19>
#<TracePoint:c_call `initialize'@tracing_execution.rb:19>
#<TracePoint:c_return `initialize'@tracing_execution.rb:19>
#<TracePoint:c_return `new'@tracing_execution.rb:19>
#<TracePoint:line@tracing_execution.rb:20>
#<TracePoint:call `test'@tracing_execution.rb:10>
#<TracePoint:line@tracing_execution.rb:11 in `test'>
#<TracePoint:return `test'@tracing_execution.rb:12>

# The method +trace_var+ allows you to add a hook to a global variable -
# whenever an assignment is made to the global, your proc is invoked.
