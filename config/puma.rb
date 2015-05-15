environment ENV['RAILS_ENV'] || 'production'

bind "unix:///home/quosh/abimorrownet.sock"

pidfile "/home/quosh/abimorrownet/tmp/puma/pid"
state_path "/home/quosh/abimorrownet/tmp/puma/state"
activate_control_app
