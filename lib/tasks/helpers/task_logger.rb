# ----------------------------------------
# TaskLogger
# ----------------------------------------


module TaskLogger
  def log_errors(errors)
    log_multiple(errors, :error)
  end


  def log_warnings(warnings)
    log_multiple(warnings, :warning)
  end


  def log_notices(notices)
    log_multiple(notices, :notice)
  end


  def log_successes(successes)
    log_multiple(successes, :success)
  end


  def log_multiple(messages, level=:notice)
    unless messages.empty?
      color = color_for(level)
      puts "\n"
      puts ('*' * 20).colorize(color)
      puts "\n"
      messages.each do |error|
        puts error.colorize(color)
      end
    end
  end


  def log_single(message, level=:notice)
    log_multiple([message], level)
  end


  def log(message, level=:notice)
    log_single(message, level)
  end


  def color_for(level)
    {
      :error => :red,
      :danger => :red,
      :alert => :red,
      :warn => :yellow,
      :warning => :yellow,
      :notice => :blue,
      :success => :green,
      :ok => :green
    }
  end
end



