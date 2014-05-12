# retry can be used to repeat an entire begin/end block in the event
# of an exception

@esmtp = true

begin
  # First try and extended login. If it fails, fall back to a normal login
  if @esmtp then @command.ehlo(helodom) else @command.helo(helodom)
  end

rescue ProtocolError
  if @esmtp then
    @esmtp = false
    retry
  else
    raise
  end
end

