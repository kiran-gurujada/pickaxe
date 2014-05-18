# Download a set of web apges in parallel.
# For each URL we download, the code creates a separate thread that handles
# the HTTP transaction

require 'net/http'

pages = %w( www.rubycentral.org slashdot.org www.google.com )

threads = pages.map do |page_to_fetch|
  # New threads are created with the Thread.new call
  # It is given a block that contains the code to run in a new thread
  # The block uses the net/http library to fetch the top page from
  # each of the nominated sites
  Thread.new(page_to_fetch) do |url|  # page_to_fetch is passed to block as url
    # We do this to give each thread a unique variable to work on, rather
    # than operating directly with page_to_fetch, which would be common to all
    # threads (and could change at any time, even mid-execution)
    # local variables created within the thread's block are unique to that thread - thus
    # url is set at thread creation time
    http = Net::HTTP.new(url, 80)
    print "Fetching: #{url}\n"
    # use print, not puts because puts actually runs two commands - using print
    # assures an atomic write to STDOUT and thus cannot be interrupted
    resp = http.get('/')
    print "Got #{url}: #{resp.message}\n"
  end
end

threads.each {|thr| thr.join} #  ensure termination of execution of all threads
