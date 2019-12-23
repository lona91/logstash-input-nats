# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require "nats/io/client"

# Generate a repeating message.
#
# This plugin is intented only as an example.

class LogStash::Inputs::Nats < LogStash::Inputs::Base
  config_name "nats"

  # If undefined, Logstash will complain, even if codec is unused.
  default :codec, "json"

  # HOST
  config :host, :validate => :string, :default => "nats://127.0.0.1:4222"
  config :channel, :validate => :string, :default => "log"

  public
  def register
    @nats = NATS::IO::Client.new
    @nats.connect(@host)
    puts "Connected to #{@nats.connected_server}"
  end # def register

  def run(queue)
    # we can abort the loop if stop? becomes true
    @nats.subscribe(@channel) do |msg|
      @codec.decode(msg) do |event|
        decorate(event)
        queue << event
      end
    end
      # because the sleep interval can be big, when shutdown happens
      # we want to be able to abort the sleep
      # Stud.stoppable_sleep will frequently evaluate the given block
      # and abort the sleep(@interval) if the return value is true
    while true
      
    end # loop
  end # def run

  def stop
    @nats.close
    # nothing to do in this case so it is not necessary to define stop
    # examples of common "stop" tasks:
    #  * close sockets (unblocking blocking reads/accepts)
    #  * cleanup temporary files
    #  * terminate spawned threads
  end
end # class LogStash::Inputs::Example
