class CallScreen < PM::Screen
  include YinsiHelpers
  include BW::KVO

  stylesheet :call

  def on_init # only called once, ever
    set_tab_icon(:phone, "Call")
  end

  def on_load
    layout(self.view, :root) do
      @username = subview(UITextField, :username, delegate: self)
      @call_time = subview(UILabel, :call_time)
      @challenge_text = subview(ChallengeTextView, :challenge_text)
      @call_button = subview(FUIButton, :call_button)
    end

    @call_button.on(:touch) { push_call_button }

    dismiss_keyboard_on_tap
  end

  # Delegate for keyboard go/return button
  def textFieldShouldReturn
    push_call_button
  end

  def call(username)
    User.lookup_sip_address(username) do |sip_address|
      if sip_address.nil?
        # TODO: Remove this puts and maybe think about more error handling
        puts "User not found" # Trust the user already got feedback
      else
        do_call(sip_address)
      end

    end
  end

  def setup_sip_agent
    if @sip_agent
      @sip_agent.reset
    else
      @sip_agent = GSUserAgent.sharedAgent
    end

    account_config = GSAccountConfiguration.defaultConfiguration
    account_config.address = "#{User.current.sip_username}@yinsiapp.com"
    account_config.username = User.current.sip_username
    account_config.password = User.current.sip_password
    account_config.domain = "yinsiapp.com"
    account_config.proxyServer = User.current.sip_proxy
    account_config.enableRingback = true
    account_config.ringbackFilename = "ringtone.wav"

    config = GSConfiguration.defaultConfiguration
    config.account = account_config
    config.logLevel = 3
    config.consoleLogLevel = 3
    config.transportType = GSUDPTransportType

    @sip_agent.configure(config)
    @sip_agent.start

    account = @sip_agent.account
    account.delegate = self
    observe(account, :status) do |old, new|
      case(new)
        when GSAccountStatusOffline
          puts "Account: offline"
        when GSAccountStatusConnecting
          puts "Account: connecting"
        when GSAccountStatusConnected
          puts "Account: Connected!"
        when GSAccountStatusDisconnecting
          puts "Account: Disconnecting..."
        when GSAccountStatusInvalid
          puts "Account: Invalid account info :("
      end
    end
    account.connect
  end

  # Delegate method on incoming calls
  def account(account, didReceiveIncomingCall: call)
    #TODO: Implement something here
    puts "You have an inbound call!"
  end

  ##############################################
  # Private Methods
  ##############################################
  private

  def do_call(address)
    puts "Calling: #{address}"
    @call = GSCall.outgoingCallToUri(address, fromAccount: @sip_agent.account)
    #observe(@call, :status) do |old, new|
    #  puts "Call status changed from #{old} to #{new}."
    #end
    @call.begin
  end

  def push_call_button
    call(@username.text) unless @username.text.empty?
  end
end